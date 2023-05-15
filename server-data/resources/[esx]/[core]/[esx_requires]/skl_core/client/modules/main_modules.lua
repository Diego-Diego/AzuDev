InitClientScripts = {}

function InitClientScripts.InitScripts(scriptList)
    for i, scriptName in ipairs(scriptList) do
        TriggerEvent("InitClientScript:" .. scriptName)
    end
end

InitClientScripts.InitScripts({"discord", "escape", "marker"})