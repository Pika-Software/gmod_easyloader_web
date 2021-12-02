local CompileString = CompileString
local string_format = string.format
local timer_Simple = timer.Simple
local isfunction = isfunction
local isnumber = isnumber
local CurTime = CurTime
local HTTP = HTTP
local MsgC = MsgC

local version = EasyLoader and EasyLoader["_VERSION"] or 0
local lastCheck, checkDelay = 0, 900

function EasyLoaderWeb(after_load)
    local time = CurTime()
    if ((version == nil) or (version == 0)) or ((time - lastCheck) > checkDelay) then
        timer_Simple(0, function()
            if (HTTP({
                ["url"] = "https://raw.githubusercontent.com/Pika-Software/gmod_easyloader/main/lua/easyloader/core.lua",
                ["method"] = "GET",
                ["success"] = function(code, body)
                    if (code == 200 or code == 0) then
                        local run = CompileString(body, "EasyLoader Web")
                        if isfunction(run) then
                            local object = run()
                            version = EasyLoader["_VERSION"]

                            MsgC(Color(82, 200, 255), "[EasyLoader Web] ", Color(255, 191, 73), string_format("%s (%s)", ((isnumber(version) and version > 0) and "OK" or "ERROR"), version), "\n")

                            if isfunction(after_load) then
                                after_load(object)
                            end
                        end
                    end
                end,
            }) == nil) then
                MsgC("[EasyLoader Web] Failed\n")
            end
        end)

        lastCheck = time
    elseif isfunction(after_load) then
        after_load(object)
    end
end

EasyLoaderWeb()