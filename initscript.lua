if not game:IsLoaded() then game["Loaded"]:Wait() end


local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local InsertService = game:GetService("InsertService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local ExploitInfo = table.freeze({
    ["Name"] = "%Elephat-BETA%",
})

local ClientInfo = {
	["IsWindowFocused"] = true
}

local RobloxEnvironment = table.freeze({
	["print"] = print, ["warn"] = warn, ["error"] = error, ["assert"] = assert, ["collectgarbage"] = collectgarbage, ["require"] = require,
	["select"] = select, ["tonumber"] = tonumber, ["tostring"] = tostring, ["type"] = type, ["xpcall"] = xpcall,
	["pairs"] = pairs, ["next"] = next, ["ipairs"] = ipairs, ["newproxy"] = newproxy, ["rawequal"] = rawequal, ["rawget"] = rawget,
	["rawset"] = rawset, ["rawlen"] = rawlen, ["gcinfo"] = gcinfo,

	["coroutine"] = {
		["create"] = coroutine["create"], ["resume"] = coroutine["resume"], ["running"] = coroutine["running"],
		["status"] = coroutine["status"], ["wrap"] = coroutine["wrap"], ["yield"] = coroutine["yield"],
	},

	["bit32"] = {
		["arshift"] = bit32["arshift"], ["band"] = bit32["band"], ["bnot"] = bit32["bnot"], ["bor"] = bit32["bor"], ["btest"] = bit32["btest"],
		["extract"] = bit32["extract"], ["lshift"] = bit32["lshift"], ["replace"] = bit32["replace"], ["rshift"] = bit32["rshift"], ["xor"] = bit32["xor"],
	},

	["math"] = {
		["abs"] = math["abs"], ["acos"] = math["acos"], ["asin"] = math["asin"], ["atan"] = math["atan"], ["atan2"] = math["atan2"], ["ceil"] = math["ceil"],
		["cos"] = math["cos"], ["cosh"] = math["cosh"], ["deg"] = math["deg"], ["exp"] = math["exp"], ["floor"] = math["floor"], ["fmod"] = math["fmod"],
		["frexp"] = math["frexp"], ["ldexp"] = math["ldexp"], ["log"] = math["log"], ["log10"] = math["log10"], ["max"] = math["max"], ["min"] = math["min"],
		["modf"] = math["modf"], ["pow"] = math["pow"], ["rad"] = math["rad"], ["random"] = math["random"], ["randomseed"] = math["randomseed"],
		["sin"] = math["sin"], ["sinh"] = math["sinh"], ["sqrt"] = math["sqrt"], ["tan"] = math["tan"], ["tanh"] = math["tanh"]
	},

	["string"] = {
		["byte"] = string["byte"], ["char"] = string["char"], ["find"] = string["find"], ["format"] = string["format"], ["gmatch"] = string["gmatch"],
		["gsub"] = string["gsub"], ["len"] = string["len"], ["lower"] = string["lower"], ["match"] = string["match"], ["pack"] = string["pack"],
		["packsize"] = string["packsize"], ["rep"] = string["rep"], ["reverse"] = string["reverse"], ["sub"] = string["sub"],
		["unpack"] = string["unpack"], ["upper"] = string["upper"],
	},

	["table"] = {
		["clone"] = table.clone, ["concat"] = table.concat, ["insert"] = table.insert, ["pack"] = table.pack, ["remove"] = table.remove, ["sort"] = table.sort,
		["unpack"] = table.unpack,
	},

	["utf8"] = {
		["char"] = utf8["char"], ["charpattern"] = utf8["charpattern"], ["codepoint"] = utf8["codepoint"], ["codes"] = utf8["codes"],
		["len"] = utf8["len"], ["nfdnormalize"] = utf8["nfdnormalize"], ["nfcnormalize"] = utf8["nfcnormalize"],
	},

	["os"] = {
		["clock"] = os["clock"], ["date"] = os["date"], ["difftime"] = os["difftime"], ["time"] = os["time"],
	},

	["delay"] = delay, ["elapsedTime"] = elapsedTime, ["spawn"] = spawn, ["tick"] = tick, ["time"] = time, ["typeof"] = typeof,
	["UserSettings"] = UserSettings, ["version"] = version, ["wait"] = wait, ["_VERSION"] = _VERSION,

	["task"] = {
		["defer"] = task["defer"], ["delay"] = task["delay"], ["spawn"] = task["spawn"], ["wait"] = task["wait"], ["cancel"] = task["cancel"]
	},

	["debug"] = {
		["traceback"] = debug["traceback"], ["profilebegin"] = debug["profilebegin"], ["profileend"] = debug["profileend"],
	},

	["game"] = game, ["workspace"] = workspace, ["Game"] = game, ["Workspace"] = workspace,

	["getmetatable"] = getmetatable, ["setmetatable"] = setmetatable
})

getgenv().saveinstance = function(Options)
	 local Params = {
        RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
        SSI = "saveinstance",
     }
     local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()
     --local Options = {} -- Documentation here https://luau.github.io/UniversalSynSaveInstance/api/SynSaveInstance
     synsaveinstance(Options)
end

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

getrenv()._G = getscriptglobals()._G
getrenv().shared = getscriptglobals().shared

getgenv().checkclosure = getgenv().isexecutorclosure
getgenv().isourclosure = getgenv().isexecutorclosure

loadstring(game:HttpGet('https://raw.githubusercontent.com/xiaomasoftworks/ElephatScripts/refs/heads/main/luaudrawlib.lua'))()

