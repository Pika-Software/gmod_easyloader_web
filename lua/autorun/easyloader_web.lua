local version = 0
function EasyLoaderWeb(after_load)
    if (version == nil) or (version == 0) then
        timer.Simple(0, function()
            if (HTTP({
                ["url"] = "https://raw.githubusercontent.com/Pika-Software/gmod_easyloader/main/lua/easyloader/core.lua",
                ["method"] = "GET",
                ["success"] = function(code, body)
                    if (code == 200 or code == 0) then
                        local run = CompileString(body, "EasyLoader Web")
                        if isfunction(run) then
                            local object = run()
                            version = EasyLoader["_VERSION"]

                            print("[EasyLoader Web] " .. ((isnumber(version) and version > 0) and "OK" or "ERROR"))

                            if isfunction(after_load) then
                                after_load(object)
                            end
                        end
                    end
                end,
            }) == nil) then
                print("[EasyLoader Web] Failed")
            end
        end)
    elseif isfunction(after_load) then
        after_load(object)
    end
end