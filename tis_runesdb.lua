_G.tis = tis

local Nyx = LibStub("Nyx")
local Sol = LibStub("Sol");
local WaitTimer = LibStub("WaitTimer");

local MAX_BAG_SLOTS = 180
local TRANS_START_SLOT = 51
local TRANS_END_SLOT = 55

local rune_recipes = {
    --t1
    ["Excite"] = {
        ["Vigor"] = 1,
        ["Vitality"] = 1,
    },
    ["Triumph"] = {
        ["Endurance"] = 1,
        ["Mind"] = 1,
    },
    ["Guts"] = {
        ["Magic"] = 1,
        ["Resistance"] = 1,
    },
    ["Rouse"] = {
        ["Endurance"] = 1,
        ["Quickness"] = 1,
    },
    --t2
    ["Anger"] = {
        ["Excite"] = 1,
        ["Triumph"] = 1,
    },
    ["Mayhem"] = {
        ["Excite"] = 1,
        ["Guts"] = 1
    },
    ["Resistor"] = {
        ["Guts"] = 1,
        ["Rouse"] = 1
    },
    ["Barrier"] = {
        ["Guts"] = 1,
        ["Triumph"] = 1,
    },
    ["Capability"] = {
        ["Guts"] = 2,
        ["Magic"] = 1,
        ["Resistance"] = 1
    },
    ["Grasp"] = {
        ["Excite"] = 2,
        ["Vigor"] = 1,
        ["Vitality"] = 1
    },
    ["Keenness"] = {
        ["Rouse"] = 2,
        ["Endurance"] = 1,
        ["Quickness"] = 1
    },
    ["Comprehension"] = {
        ["Triumph"] = 2,
        ["Endurance"] = 1,
        ["Mind"] = 1
    },
    --t3
    ["Destruction"] = {
        ["Mayhem"] = 2,
        ["Excite"] = 1,
        ["Guts"] = 1
    },
    ["Passion"] = {
        ["Anger"] = 1,
        ["Barrier"] = 1,
    },
    ["Fountain"] = {
        ["Mayhem"] = 1,
        ["Resistor"] = 1,
    },
    ["Fearless"] = {
        ["Barrier"] = 1,
        ["Resistor"] = 1,
    },
    ["Dauntlessness"] = {
        ["Capability"] = 1,
        ["Comprehension"] = 1,
    },
    ["Madness"] = {
        ["Grasp"] = 1,
        ["Comprehension"] = 1,
    },
    ["Enchantment"] = {
        ["Capability"] = 1,
        ["Keenness"] = 1,
    },
    --t4
    ["Agile"] = {
        ["Fountain"] = 1,
        ["Passion"] = 1,
    },
    ["Might"] = {
        ["Fearless"] = 1,
        ["Passion"] = 1,
    },
    ["Accuracy"] = {
        ["Dauntlessness"] = 1,
        ["Enchantment"] = 1,
    },
    ["Raid"] = {
        ["Madness"] = 1,
        ["Dauntlessness"] = 1
    },
    ["Curse"] = {
        ["Destruction"] = 1,
        ["Enchantment"] = 1,
    },
    --t5
    ["Tyrant"] = {
        ["Accuracy"] = 1,
        ["Raid"] = 1,
    },
    ["Assassin"] = {
        ["Raid"] = 1,
        ["Curse"] = 1,
    }

}

local base_runes = {"Vitality", "Resistance", "Endurance", "Quickness", "Mind", "Magic", "Vigor", "Harm", "Shell", "Defense", "Strike"}


function find_rune_in_inventory(rune, tier)
    for i = 1, 180 do
        local inventory_index, icon, name, item_count, locked, quality = GetBagItemInfo(i)
        if name == rune.." "..tier then
            DEFAULT_CHAT_FRAME:AddMessage("Found "..count.." "..rune.." "..tier.." at index "..inv_idx..".")
            return {inventory_index, item_count}  -- we stop at 1st found rune stack
        end
    end

    DEFAULT_CHAT_FRAME:AddMessage("Didn't find any "..rune.." "..tier..".")
    return {0, 0}
end

function is_base_rune(rune)
    for _, value in ipairs(base_runes) do
        if value == rune then
            return true
        end
    end
    return false
end

function put_back_into_inventory()
    for i = TRANS_START_SLOT, TRANS_END_SLOT do
        PickupBagItem(i)
        for j = 1, MAX_BAG_SLOTS do
            local inventoryIndex, _, name, _, _, _ = GetBagItemInfo(j)
            if name == "" then
                index = inventoryIndex
                break
            end
        end
        PickupBagItem(index)
        WaitTimer.CallWait(0.3)
    end
end


function craft_rune(rune)
    local tier = _G_tier
    DEFAULT_CHAT_FRAME:AddMessage("Crafting "..rune.." "..tier..".")
    local transmutor_slot_idx = TRANS_START_SLOT

    for component, reciepe_count in pairs(rune_recipes[rune]) do
        for i = 1, reciepe_count do
            DEFAULT_CHAT_FRAME:AddMessage("Looking for "..reciepe_count.." "..component.." "..tier..".")
            local inv_idx, count = unpack(find_rune_in_inventory(component, tier))
            local is_base = is_base_rune(rune)
            DEFAULT_CHAT_FRAME:AddMessage("inv_idx"..inv_idx.." "..count)

            if count == 0 then
                if is_base then
                    DEFAULT_CHAT_FRAME:AddMessage("Didn't find any "..rune.." "..tier.."."..is_base)
                    error()
                else
                    DEFAULT_CHAT_FRAME:AddMessage("Tutaj")

                    craft_rune(component)
                end
            elseif count < reciepe_count and not is_base then
                craft_rune(component)
            end
        end
    end
    for component, reciepe_count in pairs(rune_recipes[rune]) do
        for i = 1, reciepe_count do
            local inv_idx, count = unpack(find_rune_in_inventory(component, tier))
            if count == 1 then
                PickupBagItem(inv_idx)
            elseif count > 1 then
                SplitBagItem(inv_idx, 1)
            end
            PickupBagItem(transmutor_slot_idx) 
            transmutor_slot_idx = transmutor_slot_idx + 1
            WaitTimer.CallWait(0.3)
        end
    end
    MagicBoxRequest()
    WaitTimer.CallWait(0.3)
    for i = TRANS_START_SLOT, TRANS_END_SLOT do
        PickupBagItem(i)
        local index = 0
        for j = 1, 180 do
            local inventoryIndex, icon, name, itemCount, locked, quality = GetBagItemInfo(j)
            if name == "" then
                index = inventoryIndex
                break
            end
        end
        PickupBagItem(index)
        WaitTimer.CallWait(0.3)
    end
end

--/run RuneMaker("Excite")
function RuneMaker(rune, tier)
    _G_tier = tier or "III"
    WaitTimer.Call(craft_rune, rune)
end

function Pick()
    WaitTimer.Call(put_back_into_inventory)
end
