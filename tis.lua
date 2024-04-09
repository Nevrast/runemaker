local Sol = LibStub("Sol");
local WaitTimer = LibStub("WaitTimer");
local slot_no = 8;
local second_item_name = "Gold-wrapped Belt";
DEFAULT_CHAT_FRAME:AddMessage("Addon Tis zaladowany | EGOIST KURNA")

ITEM_QUEUE_FRAME_UPDATETIME = 0; 
ITEM_QUEUE_FRAME_INSERTITEM = 0;

local transmutor_npc_name = "Montestaire"

function tis_purestarttransmutor()
 ExtFusion.func.max()

 transmutor_npc_name = UnitName("target")
  
 WaitTimer.Call(tis_pureopennpc);

end

function tis_pureopennpc()
  
  WaitTimer.CallWait(1);

  slot_no = 3
  second_item_name = "Purified Fusion Stone"

  WaitTimer.Call(tis_purestartbuy);

end

function tis_purestartbuy()

 local used,total=GetBagCount()
 if used == 180 then
  DEFAULT_CHAT_FRAME:AddMessage("Brak miejsca w plecaku!")
  return false;
 end

 total_itemstotrasmute = 0

 total_stones_t3 = 0
 total_stones_t4 = 0
 total_stones_t5 = 0
 total_stones_t6 = 0
 total_stones_t7 = 0
 total_stones_t8 = 0
 total_stones_t9 = 0
 total_stones_t10 = 0

 total_items1 = 0
 total_items2 = 0

 for i=1,180 do
  a,b,name,count = GetBagItemInfo(i) 
  if name == "Mana Stone Tier 3" then
   total_stones_t3 = total_stones_t3 + 1
  end

  if name == "Mana Stone Tier 4" then
   total_stones_t4 = total_stones_t4 + 1
  end

  if name == "Mana Stone Tier 5" then
   total_stones_t5 = total_stones_t5 + 1
  end

  if name == "Mana Stone Tier 6" then
   total_stones_t6 = total_stones_t6 + 1
  end

  if name == "Mana Stone Tier 7" then
   total_stones_t7 = total_stones_t7 + 1
  end

  if name == "Mana Stone Tier 8" then
   total_stones_t8 = total_stones_t8 + 1
  end

  if name == "Mana Stone Tier 9" then
   total_stones_t9 = total_stones_t9 + 1
  end

  if name == "Mana Stone Tier 10" then
   total_stones_t10 = total_stones_t10 + 1
  end

  if name == "Gold-wrapped Belt" then
   total_items1 = total_items1 + 1
  end

  if name == "Purified Fusion Stone" then
   total_items2 = total_items2 + 1
  end

  if name == second_item_name then 
   total_itemstotrasmute = total_itemstotrasmute + 1;     
  end 
 end

 if total_stones_t3 > 2 or total_stones_t4 > 2 or total_stones_t5 > 2 or total_stones_t6 > 2 or total_stones_t7 > 2 or total_stones_t8 > 2 or total_stones_t9 > 2 or total_stones_t10 > 2 then
  DEFAULT_CHAT_FRAME:AddMessage("Jeszcze mielimy wyzsze kamyki")
  ExtFusion.func.QueueStartStop(true)
  WaitTimer.CallWait(1);
  WaitTimer.Call(tis_purestartbuy);
  return false
 end

 if total_items1 > 0 and total_items2 > 0 then
  DEFAULT_CHAT_FRAME:AddMessage("Jeszcze mielimy kamyki i paski")
  ExtFusion.func.QueueStartStop(true)
  WaitTimer.CallWait(1);
  WaitTimer.Call(tis_purestartbuy);
  return false
 end

 if total_itemstotrasmute > 0 then
  DEFAULT_CHAT_FRAME:AddMessage("Pozostalo do przerobienia: "..total_itemstotrasmute)

  needed = 8
  if total_itemstotrasmute < 8 then
   needed = total_itemstotrasmute
  end

  DEFAULT_CHAT_FRAME:AddMessage("Kupuje "..needed.." itemow")

  for i=1,needed do 
   StoreBuyItem(slot_no,1) 
  end
  WaitTimer.CallWait(2);
  ExtFusion.func.QueueStartStop(true)
  WaitTimer.CallWait(8);
  WaitTimer.Call(tis_purestartbuy);

 else

   DEFAULT_CHAT_FRAME:AddMessage("Koniec, otwieraj pakiet")

 end

end



function tis_starttransmutor()
 ExtFusion.func.max()

 if (UnitName("target") == "Montestaire" or UnitName("target") == "Odeley Prole") then
  transmutor_npc_name = UnitName("target")
 end
  
 WaitTimer.Call(tis_opennpc);

end

function tis_opennpc()
  
  WaitTimer.CallWait(1);

  DEFAULT_CHAT_FRAME:AddMessage("NPC: "..transmutor_npc_name)
  if transmutor_npc_name == "Odeley Prole" then
   slot_no = 8
   second_item_name = "Gold-wrapped Belt"
  else
   slot_no = 3
   second_item_name = "Random Fusion Stone"
  end

  WaitTimer.Call(tis_startbuy);

end

function tis_startbuy()

 local used,total=GetBagCount()
 if used == 180 then
  DEFAULT_CHAT_FRAME:AddMessage("Brak miejsca w plecaku!")
  return false;
 end

 total_itemstotrasmute = 0

 total_stones_t3 = 0
 total_stones_t4 = 0
 total_stones_t5 = 0
 total_stones_t6 = 0
 total_stones_t7 = 0
 total_stones_t8 = 0
 total_stones_t9 = 0
 total_stones_t10 = 0

 total_items1 = 0
 total_items2 = 0

 for i=1,180 do
  a,b,name,count = GetBagItemInfo(i) 
  if name == "Mana Stone Tier 3" then
   total_stones_t3 = total_stones_t3 + 1
  end

  if name == "Mana Stone Tier 4" then
   total_stones_t4 = total_stones_t4 + 1
  end

  if name == "Mana Stone Tier 5" then
   total_stones_t5 = total_stones_t5 + 1
  end

  if name == "Mana Stone Tier 6" then
   total_stones_t6 = total_stones_t6 + 1
  end

  if name == "Mana Stone Tier 7" then
   total_stones_t7 = total_stones_t7 + 1
  end

  if name == "Mana Stone Tier 8" then
   total_stones_t8 = total_stones_t8 + 1
  end

  if name == "Mana Stone Tier 9" then
   total_stones_t9 = total_stones_t9 + 1
  end

  if name == "Mana Stone Tier 10" then
   total_stones_t10 = total_stones_t10 + 1
  end

  if name == "Gold-wrapped Belt" then
   total_items1 = total_items1 + 1
  end

  if name == "Random Fusion Stone" then
   total_items2 = total_items2 + 1
  end

  if name == second_item_name then 
   total_itemstotrasmute = total_itemstotrasmute + 1;     
  end 
 end

 if total_stones_t3 > 2 or total_stones_t4 > 2 or total_stones_t5 > 2 or total_stones_t6 > 2 or total_stones_t7 > 2 or total_stones_t8 > 2 or total_stones_t9 > 2 or total_stones_t10 > 2 then
  DEFAULT_CHAT_FRAME:AddMessage("Jeszcze mielimy wyzsze kamyki")
  ExtFusion.func.QueueStartStop(true)
  WaitTimer.CallWait(1);
  WaitTimer.Call(tis_startbuy);
  return false
 end

 if total_items1 > 0 and total_items2 > 0 then
  DEFAULT_CHAT_FRAME:AddMessage("Jeszcze mielimy kamyki i paski")
  ExtFusion.func.QueueStartStop(true)
  WaitTimer.CallWait(1);
  WaitTimer.Call(tis_startbuy);
  return false
 end

 if total_itemstotrasmute > 0 then
  DEFAULT_CHAT_FRAME:AddMessage("Pozostalo do przerobienia: "..total_itemstotrasmute)

  needed = 8
  if total_itemstotrasmute < 8 then
   needed = total_itemstotrasmute
  end

  DEFAULT_CHAT_FRAME:AddMessage("Kupuje "..needed.." itemow")

  for i=1,needed do 
   StoreBuyItem(slot_no,1) 
  end
  WaitTimer.CallWait(2);
  ExtFusion.func.QueueStartStop(true)
  WaitTimer.CallWait(8);
  WaitTimer.Call(tis_startbuy);

 else
 
  local used,total=GetBagCount()
  if used < 162 then
   
   DEFAULT_CHAT_FRAME:AddMessage("Zasypujemy plecak")
   for i=1,8 do 
    StoreBuyItem(slot_no,1) 
   end
   WaitTimer.CallWait(2);
   WaitTimer.Call(tis_startbuy);

  else

   DEFAULT_CHAT_FRAME:AddMessage("Koniec, otwieraj pakieta")
   TargetUnit("")
   
   if transmutor_npc_name == "Montestaire" then
    TB_Teleport(0,46)
   end

   if transmutor_npc_name == "Odeley Prole" then
    TB_Teleport(0,47)
   end

   WaitTimer.CallWait(3);

  end

 end

end