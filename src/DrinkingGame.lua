DrinkingGame = DrinkingGame or {}
local DG = DrinkingGame

DG.name = "DrinkingGame"
DG.displayName = "Drinking Game"
DG.version = "0.1"

local HEROISM_ID = 61708
local POTION_COOLDOWN_ID = 91

function DG.HasPotionCooldown()
	local slots = {
		EQUIP_SLOT_NECK,
		EQUIP_SLOT_RING1,
		EQUIP_SLOT_RING2
	}
	
	local glyphCount = 0
	
	for _, slot in ipairs(slots) do
		local itemLink = GetItemLink(BAG_WORN, slot, LINK_STYLE_DEFAULT)
		if GetItemLinkAppliedEnchantId(itemLink) == POTION_COOLDOWN_ID then
			glyphCount = glyphCount + 1
		end
	end
	
	return glyphCount > 0
end

function DG.OnCombatChange(_, inCombat)
	if not DG.HasPotionCooldown() then return end
	if not inCombat then SetCurrentQuickslot(DG.settings.heroismPotionSlot) end
end

function DG.OnHeroismEffect(_, changeType)
	if not DG.HasPotionCooldown() then return end
	if changeType == EFFECT_RESULT_GAINED then
		SetCurrentQuickslot(DG.settings.otherPotionSlot)
	elseif changeType == EFFECT_RESULT_FADED then
		SetCurrentQuickslot(DG.settings.heroismPotionSlot)
	end
end

function DG.OnAddOnLoaded(_, addonName)
	if addonName ~= DG.name then return end
	
	DG.InitSV()
	DG.InitAM()
	
	EVENT_MANAGER:RegisterForEvent(DG.name, EVENT_PLAYER_COMBAT_STATE, DG.OnCombatChange)
	
	EVENT_MANAGER:RegisterForEvent(DG.name, EVENT_EFFECT_CHANGED, DG.OnHeroismEffect)
	EVENT_MANAGER:AddFilterForEvent(DG.name, EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG, "player")
	EVENT_MANAGER:AddFilterForEvent(DG.name, EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID, HEROISM_ID)
end

EVENT_MANAGER:RegisterForEvent(DG.name, EVENT_ADD_ON_LOADED, DG.OnAddOnLoaded)