if not game:IsLoaded() then game["Loaded"]:Wait() end

getgenv().saveinstance = function(Options)
	 local Params = {
        RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
        SSI = "saveinstance",
     }
     local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
     --local Options = {} -- Documentation here https://luau.github.io/UniversalSynSaveInstance/api/SynSaveInstance
     synsaveinstance(Options)
end

getgenv().isexecutorclosure = newcclosure(function(fnc)
	local genv = getgenv();
        local isroblox = false
        table.foreach(getrenv(), function(k, v)
	        if v == fnc and fnc ~= genv.loadstring then
                isroblox = true
            end
        end)
        if isroblox then
            return false
        end
        for i, v in pairs(genv) do
            if v == fnc then
                return true
            end
        end
        if getfenv(fnv)._G == genv._G then
            return true
        end
        return false

end)

getgenv()["savegame"] = saveinstance
getgenv()["saveplace"] = saveinstance

getgenv()["lz4_compress"] = lz4compress
getgenv()["Lz4Compress"] = lz4compress

getgenv()["lz4_decompress"] = lz4decompress
getgenv()["Lz4Decompress"] = lz4decompress


local function RobloxConsoleHandler(...)
	warn("rconsole library disabled.")
end

getgenv()["rconsoleclear"] = newcclosure(RobloxConsoleHandler)
getgenv()["consoleclear"] = rconsoleclear
getgenv()["console_clear"] = rconsoleclear
getgenv()["ConsoleClear"] = rconsoleclear

getgenv()["rconsolecreate"] = newcclosure(RobloxConsoleHandler)
getgenv()["consolecreate"] = rconsolecreate
getgenv()["console_create"] = rconsolecreate
getgenv()["ConsoleCreate"] = rconsolecreate

getgenv()["rconsoledestroy"] = newcclosure(RobloxConsoleHandler)
getgenv()["consoledestroy"] = rconsoledestroy
getgenv()["console_destroy"] = rconsoledestroy
getgenv()["ConsoleDestroy"] = rconsoledestroy

getgenv()["rconsoleinput"] = newcclosure(RobloxConsoleHandler)
getgenv()["consoleinput"] = rconsoleinput
getgenv()["console_input"] = rconsoleinput
getgenv()["ConsoleInput"] = rconsoleinput

getgenv()["rconsoleprint"] = newcclosure(RobloxConsoleHandler)
getgenv()["consoleprint"] = rconsoleprint
getgenv()["console_print"] = rconsoleprint
getgenv()["ConsolePrint"] = rconsoleprint

getgenv()["rconsolesettitle"] = newcclosure(RobloxConsoleHandler)
getgenv()["rconsolename"] = rconsolesettitle
getgenv()["consolesettitle"] = rconsolesettitle
getgenv()["console_set_title"] = rconsolesettitle
getgenv()["ConsoleSetTitle"] = rconsolesettitle

setreadonly(getgenv().debug,false)
getgenv().debug.traceback = getrenv().debug.traceback
getgenv().debug.profilebegin = getrenv().debug.profilebegin
getgenv().debug.profileend = getrenv().debug.profileend
getgenv().debug.getmetatable = getgenv().getrawmetatable
getgenv().debug.setmetatable = getgenv().setrawmetatable
getgenv().debug.info = getrenv().debug.info
getgenv().debug.loadmodule = getrenv().debug.loadmodule

local _setidentity = _setidentity or function() error("_setidentity not defined") end
local oldreq = clonefunction(getrenv().require)


getgenv().setthreadidentity = function(identity: number): ()
    _setidentity(identity)
    task.wait()
end

getgenv().setidentity = getgenv().setthreadidentity
getgenv().setcontext = getgenv().setthreadidentity
getgenv().setthreadcontext = getgenv().setthreadidentity



getgenv().getscriptfunction = getgenv().getscriptclosure

getgenv().getloadedmodules = newcclosure(function()
    local list = {}
    for _, v in ipairs(getgc(false)) do
        if typeof(v) == "function" then
            local env = getfenv(v)
            local scriptInstance = env["script"]
            if typeof(scriptInstance) == "Instance" and scriptInstance:IsA("ModuleScript") and not table.find(list, scriptInstance) then
                table.insert(list, scriptInstance)
            end
        end
    end
    return list
end)

getgenv().require = newcclosure(function(v)
    assert(v, "Module argument is required")
    local oldlevel = getthreadcontext()
    local succ, res = pcall(oldreq, v)
    
    if not succ and res:find("RobloxScript") then
        succ = nil
        local co = coroutine.create(function()
            setthreadcontext((oldlevel > 5 and 2) or 8)
            succ, res = pcall(oldreq, v)
        end)
        coroutine.resume(co)
        repeat task.wait() until succ ~= nil
    end
    
    setthreadcontext(oldlevel)
    return succ and res or nil
end)

getgenv().getscripts = newcclosure(function()
    local a = {}
    for b,c in next,getreg() do
        if type(c)=="table" then
            for d,e in next,c do
                if typeof(e) == "Instance" and (e:IsA("LocalScript") or e:IsA("ModuleScript")) then
                    table.insert(a,e)
                elseif typeof(e) == "Instance" and (e:IsA("Script")) then
                    if e.RunContext == Enum.RunContext.Client then
                        table.insert(a,e)
                    end
                end
            end
        end
    end
    return a
end)
getgenv().getactors = newcclosure(function()
    local actors = {};
    for i, v in game:GetDescendants() do
        if v:IsA("Actor") then
            table.insert(actors, v);
        end
    end
    return actors;
end);

getgenv().get_actors = getgenv().getactors
getgenv().GetActors = getgenv().getactors
getgenv().getActors = getgenv().getactors

do
    local CoreGui = game:GetService('CoreGui')
    local HttpService = game:GetService('HttpService')

    local comm_channels = CoreGui:FindFirstChild('comm_channels') or Instance.new('Folder', CoreGui)
    if comm_channels.Name ~= 'comm_channels' then
        comm_channels.Name = 'comm_channels'
    end
    getgenv().create_comm_channel = newcclosure(function() 
        local id = HttpService:GenerateGUID()
        local event = Instance.new('BindableEvent', comm_channels)
        event.Name = id
        return id, event
    end)

    getgenv().get_comm_channel = newcclosure(function(id) 
        assert(type(id) == 'string', 'string expected as argument #1')
        return comm_channels:FindFirstChild(id)
    end)
end

getgenv()["getscripthash"] = newcclosure(function(Inst)
    assert(typeof(Inst) == "Instance", "invalid argument #1 to 'getscripthash' (Instance expected, got " .. typeof(Inst) .. ") ", 2)
	assert(Inst:IsA("LuaSourceContainer"), "invalid argument #1 to 'getscripthash' (LuaSourceContainer expected, got " .. Inst["ClassName"] .. ") ", 2)
    if Inst:IsA("Script") then
        if Inst.RunContext == Enum.RunContext.Client then
            return getscripthash_handler(Inst)
        end
    end
	return getscripthash_handler(Inst)
end)

getgenv()["getscriptclosure"] = newcclosure(function(Inst)
    assert(typeof(Inst) == "Instance", "invalid argument #1 to 'getscriptclosure' (Instance expected, got " .. typeof(Inst) .. ") ", 2)
	assert(Inst:IsA("LuaSourceContainer"), "invalid argument #1 to 'getscriptclosure' (LuaSourceContainer expected, got " .. Inst["ClassName"] .. ") ", 2)
    if Inst:IsA("Script") then
        if Inst.RunContext == Enum.RunContext.Client then
            return getscriptclosure_handler(Inst)
        end
    end
	return getscriptclosure_handler(Inst)
end)

getgenv().getscriptfunction = getgenv().getscriptclosure

getgenv().iselephatclosure = getgenv().isexecutorclosure

getrenv()._G = getscriptglobals()._G
getrenv().shared = getscriptglobals().shared

getgenv().checkclosure = getgenv().isexecutorclosure
getgenv().isourclosure = getgenv().isexecutorclosure
getgenv().iselephatclosure = getgenv().isexecutorclosure

getgenv().isnetworkowner = function(part: BasePart): boolean
    return part.ReceiveAge == 0 and not part.Anchored and part.Velocity.Magnitude > 0
end

getgenv().setsimulationradius = function(newRadius)
    assert(newRadius, `arg #1 is missing`)
    assert(type(newRadius) == "number", `arg #1 must be type number`)

    local LocalPlayer = game:GetService("Players").LocalPlayer
    if LocalPlayer then
        LocalPlayer.SimulationRadius = newRadius
        LocalPlayer.MaximumSimulationRadius = newRadius
    end
end

getgenv().getsimulationradius = function()
    assert(newRadius, `arg #1 is missing`)
    assert(type(newRadius) == "number", `arg #1 must be type number`)

    local LocalPlayer = game:GetService("Players").LocalPlayer
    if LocalPlayer then
        return LocalPlayer.SimulationRadius
    end
end

getgenv().http = {}
getgenv().http.request = request
setreadonly(http, true)

getgenv().http_request = request

getgenv().getconnection = newcclosure(function(signal, index)
    local connections = getconnections(signal)
    if index > 0 and index <= #connections then
        return connections[index]
    else
        return nil
    end
end)

load_autoexec_scripts()

--loadstring(game:HttpGet('https://raw.githubusercontent.com/xiaomasoftworks/ElephatScripts/refs/heads/main/luaudrawlib.lua'))()

