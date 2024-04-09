----------------------------------------------------------------------------------------------------------
-- Areon ChatChannel-Settings
--
-- written by PetraAreon for the Addons Lootomatic & ComeOnIn
-- released under the Creative Commons License By-Nc-Sa: http://creativecommons.org/licenses/by-nc-sa/3.0/
----------------------------------------------------------------------------------------------------------
local Sol = LibStub("Sol");

local Name = "AreonChatChannelSettings";
local ChatFrameID;

Sol.hooks.Hook(Name, "ChatChannelSetFrame_Open",              ACCS_ChatChannelSetFrame_Open);
Sol.hooks.Hook(Name, "ChatChannelSetFrameChannel_Update",     ACCS_ChatChannelSetFrameChannel_Update);
Sol.hooks.Hook(Name, "ChatChannelSetItemCheckButton_OnClick", ACCS_ChatChannelSetItemCheckButton_OnClick);
Sol.hooks.Hook(Name, "ChatChannelSetItemColorButton_OnClick", ACCS_ChatChannelSetItemColorButton_OnClick);

--ChatChannelSetFrame.addonsList = {};
--PanelTemplates_SetNumTabs(ChatChannelSetFrame, 3);

Sol.io.Print("test");

function ACCS_AddChannelSetting(entry)
	if (ChatChannelSetFrame.AddonList == nil) then
		ChatChannelSetFrame.AddonList = {};
	end;

	table.insert(ChatChannelSetFrame.AddonList,entry);
end;


function ACCS_ChatChannelSetFrame_Open(chatFrame, ...)
	Sol.io.Print("ChatChannelSetFrame.tab = "..ChatChannelSetFrame.tab);
	
	ChatFrameID = chatFrame:GetID();
	local abc = {};
	
	for n=1,table.maxn(ChatChannelSetFrame.AddonList) do
		abc[n] = {};
		abc[n].name		= ChatChannelSetFrame.AddonList[n].Name;
		abc[n].checked	= ChatChannelSetFrame.AddonList[n].GetValue(ChatFrameID);
		abc[n].value	= ChatFrameID;
		abc[n].disabled	= false;

		local r,g,b = ChatChannelSetFrame.AddonList[n].GetColor();
		abc[n].r		= r;
		abc[n].g		= g;
		abc[n].b		= b;
	end;
	
	Sol.io.Print("1: "..abc[1].name);
	
	table.insert(ChatChannelSetFrame.addonsList,abc);
	
	Sol.io.Print("2: "..ChatChannelSetFrame.addonsList[1].name);
	
	Sol.hooks.GetOriginalFn(Name, "ChatChannelSetFrame_Open") (chatFrame, ...)
end;
function ACCS_ChatChannelSetFrameChannel_Update()
	if ( ChatChannelSetFrame.tab == 3 ) then
		ChatChannelSetFrame.currentList = ChatChannelSetFrame.addonsList;
	end
	
	Sol.hooks.GetOriginalFn(Name, "ChatChannelSetFrameChannel_Update") ()
end;


function ACCS_ChatChannelSetItemCheckButton_OnClick(this)
	local id = this:GetParent():GetID();
	if (ChatChannelSetFrame.tab == 3) then
		ChatChannelSetFrame.AddonList[id].SetValue(ChatFrameID,this:IsChecked());
	else
		Sol.hooks.GetOriginalFn(Name, "ChatChannelSetItemCheckButton_OnClick") (this)
	end;
end;
function ACCS_ChatChannelSetItemColorButton_OnClick(this)
	local id = this:GetParent():GetID();
	if (ChatChannelSetFrame.tab == 3) then
		if (type(ChatChannelSetFrame.AddonList[id].SetColor)=="function") then
			OpenColorPickerFrame(function() ACCS_ChatChannelSetItemColorButton_Set(id); end, nil, nil, ChatChannelSetFrame.currentList[id].r, ChatChannelSetFrame.currentList[id].g, ChatChannelSetFrame.currentList[id].b, 1, ChatChannelSetFrame);
		end;
	else
		Sol.hooks.GetOriginalFn(Name, "ChatChannelSetItemColorButton_OnClick") (this)
	end;
end;
function ACCS_ChatChannelSetItemColorButton_Set(id)
	ChatChannelSetFrame.AddonList[id].SetColor(ColorPickerFrame.r,ColorPickerFrame.g,ColorPickerFrame.b);
	getglobal("ChatChannelSetFrame"..id.."ColorButtonBlock"):SetColor(ColorPickerFrame.r, ColorPickerFrame.g, ColorPickerFrame.b);
end;