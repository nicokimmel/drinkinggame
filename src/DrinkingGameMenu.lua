DrinkingGame = DrinkingGame or {}
local DG = DrinkingGame

function DG.InitSV()
	DG.settings = ZO_SavedVars:NewCharacterIdSettings("DrinkingGameSV", 1, nil, {
		heroismPotionSlot = 4,
		otherPotionSlot = 3,
	})
end

function DG.InitAM()
	
	local panelData = {
		type = "panel",
		name = DG.displayName,
		displayName = DG.displayName:upper(),
		author = "ownedbynico",
		version = DG.version,
		registerForRefresh = true,
	}
	
	local optionData = {
		{
			type = "description",
			text = "Heroism Potion Swap Addon",
		},
		{
			type = "custom",
			createFunc = function(customControl)
				local icon = WINDOW_MANAGER:CreateControl(nil, customControl, CT_TEXTURE)
				icon:SetTexture("/DrinkingGame/assets/slots.dds")
				icon:SetDimensions(250, 250)
			icon:SetAnchor(LEFT, customControl, LEFT, 0, 0)
			end,
			width = "full",
			maxHeight = 300,
		},
		{
			type = "header",
			name = "Settings",
		},
		{
			type = "slider",
			name = "Heroism Potion Slot",
			getFunc = function() return DG.settings.heroismPotionSlot end,
			setFunc = function(value) DG.settings.heroismPotionSlot = value end,
			min = 1,
			max = 8,
			step = 1,
			width = "full"
		},
		{
			type = "slider",
			name = "Other Potion Slot",
			getFunc = function() return DG.settings.otherPotionSlot end,
			setFunc = function(value) DG.settings.otherPotionSlot = value end,
			min = 1,
			max = 8,
			step = 1,
			width = "full"
		}
	}
	
	LibAddonMenu2:RegisterAddonPanel("DrinkingGameMenu", panelData)
	LibAddonMenu2:RegisterOptionControls("DrinkingGameMenu", optionData)
end