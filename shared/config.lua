Config = Config or {}

Config.DebugName = "[BOILERPLATE]"

local function SearchDependencies(resourceTable)
    for i = 1, #resourceTable do
        local resource, id = resourceTable[i][1], resourceTable[i][2]
        local state = GetResourceState(resource)

        if Config.Debug then
            print(Config.DebugName, "Searching for dependency:", resource, "State:", state)
        end

        if state == "started" or state == "starting" then
            if Config.Debug then
                print(Config.DebugName, "Found dependency:", resource, "ID:", id)
            end

            return id
        end
    end

    if Config.Debug then
        print(Config.DebugName .. "%s No dependencies found, falling back to standalone")
    end

    return nil
end

local frameworks = {
    { "qbx_core", "qbx" },
    { "qb-core", "qb" },
    { "es_extended", "esx" },
}

--[[
    [INFO]
    The locale sets the language used for every text shown by the script. If the language you
    need is not available, you can add it yourself by creating a new file with the language code

    as its name in this folder:
        locales/

    [EDITABLE]
    Locale Options:
    - "en" (default)
    - "es"
]]
Config.Locale = "en"


--[[ 
    [INFO]
    Debug mode prints extra information in the console, such as every resource checked during
    the automatic framework detection and the result it settled on. Useful when the wrong
    framework is picked up. Keep it disabled on a live server, it is only console noise.

    [EDITABLE]
    Debug Options:
        - false (default)
        - true
]]
Config.Debug = true

--[[ 
    [INFO]
    The framework is detected automatically from the resources running on your server, and
    falls back to "standalone" when none of them is found. Replace the whole line with a plain
    string if you want to force one instead.

    The value must match the name of the file that implements it, so "esx" loads esx.lua and
    "qbx" loads qbx.lua. If your framework is not supported, set this to "custom" and write the
    integration in these two files:
        bridge/client/framework/custom.lua
        bridge/server/framework/custom.lua

    You can also add your framework to the frameworks table above as { "resource", "custom" }
    to keep the detection automatic.

    [EDITABLE]
    Framework Options:
        - SearchDependencies(frameworks) or "standalone" (default) -- Automatic
        - "esx"
        - "qbcore"
        - "qbx"
        - "custom" -- Integration needed
        - "standalone" -- No framework
]]
Config.Framework = SearchDependencies(frameworks) or "standalone"