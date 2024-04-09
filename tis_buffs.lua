local tis = {}
_G.tis = tis

local Nyx = LibStub("Nyx")

local defaultMissingList = {
  ["Hero Potion"] = "on",
  ["Grassland Mix"] = "on",
}

function tis:OnEvent(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    self[event](self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
end

function print_r(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else 
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end

local frame = _G.Tis_Frame
frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("SAVE_VARIABLES")

TB_Variables = { 
 missinglist = defaultMissingList
}
TisBuffs_Variables = {}
_G.TisBuffs_Variables = TisBuffs_Variables

function tisbuffs_onLoad()
  SaveVariables("TisBuffs_Variables")
end

function tis:VARIABLES_LOADED()
  if Nyx.TableSize(TisBuffs_Variables) > 0 then
    TB_Variables = TisBuffs_Variables
    DEFAULT_CHAT_FRAME:AddMessage(print_r(TisBuffs_Variables))
  end
  TisBuffs_Variables = TB_Variables
end

function tis:SAVE_VARIABLES()
  TisBuffs_Variables = TB_Variables
end

function tis_buffsList(type)

 local missings = TisBuffs_Variables.missinglist;

 for i=1,100 do 
  buffname = UnitBuff("player", i);
  if buffname then 
    local timeleft = math.floor(GetPlayerBuffLeftTime(GetPlayerBuff(i, "HELPFUL")) / 60);

    if type == "all" then
     DEFAULT_CHAT_FRAME:AddMessage("TisBuff: "..buffname.." | pozostało: "..timeleft.."min")
    end

    for buffname_mis, value in pairs(missings) do
      if buffname_mis == buffname then
        missings[buffname] = nil
      end
    end

  end

 end

 local missing_counter = 0
 for buffname, value in pairs(missings) do
   DEFAULT_CHAT_FRAME:AddMessage("TisBuff: Brak "..buffname, 1, 0, 0)
   missing_counter = missing_counter + 1
 end

 if missing_counter == 0 then
  DEFAULT_CHAT_FRAME:AddMessage("TisBuff: Wszystkie buffki odpalone", 0, 1, 0)
 end

end

function tis_buffsHelp()
  DEFAULT_CHAT_FRAME:AddMessage("Lista wszystkich aktywnych buffów")
  DEFAULT_CHAT_FRAME:AddMessage("/tb all")
  DEFAULT_CHAT_FRAME:AddMessage("Lista brakujących")
  DEFAULT_CHAT_FRAME:AddMessage("/tb mis")
  DEFAULT_CHAT_FRAME:AddMessage("Lista dodanych")
  DEFAULT_CHAT_FRAME:AddMessage("/tb cur")
  DEFAULT_CHAT_FRAME:AddMessage("Dodawanie buffa")
  DEFAULT_CHAT_FRAME:AddMessage("/tb add Nazwa buffa")
  DEFAULT_CHAT_FRAME:AddMessage("Usuwanie buffa")
  DEFAULT_CHAT_FRAME:AddMessage("/tb rem Nazwa buffa")
end

SLASH_TISBUFF1 = "/tis_buff"
SLASH_TISBUFF2 = "/tb"
SlashCmdList["TISBUFF"] = function (editBox, msg)

    if ( not msg or msg == "" ) then
        tis_buffsHelp()
        return;
    end

    local cmds={}
    for cm in string.gmatch(string.lower(msg), "%a+") do table.insert(cmds,cm) end

    local help = nil
    for i = 1,table.getn(cmds) do
        fl = string.sub(cmds[i],1,3)
        if fl == "all" then
           tis_buffsList("all")
        end
        if fl == "mis" then
           tis_buffsList("missing")
        end
        if fl == "add" then
           buffname = string.sub(msg, 5)
           TB_Variables["missinglist"][buffname] = "on"
           DEFAULT_CHAT_FRAME:AddMessage("TisBuff: Dodano do listy: "..buffname)
        end
        if fl == "rem" then
           buffname = string.sub(msg, 5)
           TB_Variables["missinglist"][buffname] = nil
           DEFAULT_CHAT_FRAME:AddMessage("TisBuff: Usunięto z listy: "..buffname)
        end
        if fl == "cur" then
           
           for buffname, value in pairs(TB_Variables["missinglist"]) do
            DEFAULT_CHAT_FRAME:AddMessage("TisBuff: "..buffname, 0, 1, 0)
           end
           
        end
    end

    TisBuffs_Variables = TB_Variables

end

tisbuffs_onLoad(this)
