local resourceName = GetCurrentResourceName()
local currentVersion = GetResourceMetadata(resourceName, "version", 0)

local function versionToNumber(version)
    if not version then return 0 end
    local number = ""
    for part in string.gmatch(version, "%d+") do
        number = number .. part
    end
    return tonumber(number) or 0
end

local function compareVersions(remoteVersion)
    return versionToNumber(remoteVersion) - versionToNumber(currentVersion)
end

local githubURL = "https://raw.githubusercontent.com/CREATIVE-ST/versions/main/" .. resourceName .. ".json"

PerformHttpRequest(githubURL, function(code, response)
    if code ~= 200 then
        print("^1[VERSION CHECK] Unable to check version for " .. resourceName .. "^0")
        return
    end

    local data = json.decode(response)
    if not data or not data.version then
        print("^1[VERSION CHECK] Unable to check version for " .. resourceName .. "^0")
        return
    end

    local difference = compareVersions(data.version)

    print("^5--------------------------------^0")
    print("^5Resource:^0" .. resourceName)
    print("^5Current:^0" .. currentVersion)
    print("^5Remote:^0" .. data.version)

    if difference == 0 then
        print("^2Status:^0 Up to date")
    elseif difference > 0 then
        print("^3Status:^0 Update available")
    else
        print("^4Status:^0 Local version is newer")
    end

    print("^5--------------------------------^0")

end, "GET")