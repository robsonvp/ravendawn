--[[
    Question 5
    A spell that creates ice falling from sky to a small circle area
]]


local spell = Spell("instant")

-- Delay between animations.
local animationDelay = 1200

-- Defining areas in a dynamic way
local areas = {
    createCombatArea(AREA_CIRCLE4X4),
    createCombatArea(AREA_CIRCLE1X1),
    createCombatArea(AREA_CIRCLE3X3),
    createCombatArea(AREA_CIRCLE2X2)
}

-- Combat config for each area
local combats = {}
for _, area in ipairs(areas) do
    local combat = Combat()
    combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
    combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
    combat:setArea(area)
    table.insert(combats, combat)
end

-- Function to execute combat in the right place
function executeCombat(creature, var, combat)
    combat:execute(creature, var)
end

-- Function to execute spell
function spell.onCastSpell(creature, var)
    local level = creature:getLevel()
    local maglevel = creature:getMagicLevel()
    local min = (level / 5) + (maglevel * 6)
    local max = (level / 5) + (maglevel * 12)

    for _, combat in ipairs(combats) do
        for i = 1, 5 do
            addEvent(function()
                combat:setFormula(COMBAT_FORMULA_LEVELMAGIC, 0, -min, 0, -max)
                combat:execute(creature, var)
            end, (i - 1) * animationDelay)
        end
    end

    return true
end

spell:group("attack", "focus")
spell:id(118)
spell:name("Raven Winter")
spell:words("frigo")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_ETERNAL_WINTER)
spell:level(60)
spell:mana(1050)
spell:isPremium(true)
spell:range(5)
spell:isSelfTarget(true)
spell:cooldown(40 * 1000)
spell:groupCooldown(4 * 1000, 40 * 1000)
spell:needLearn(false)
spell:vocation("druid;true", "elder druid;true")
spell:register()
