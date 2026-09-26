-- -----------------------------------------------------------------------------
-- FluentTaskbarWidget - Audio Visualizer Lua Controller
-- Smooth audio falloff interpolation, peak decay physics, and dynamic shapes
-- -----------------------------------------------------------------------------

local bandMeasures = {}
local currentValues = {}
local barCount = 16          -- matches BarCount=16 in Variables.inc (was 20, bug)
local barMaxHeight = 24
local attackRate = 0.40
local decayRate = 0.08       -- slightly faster decay for snappier feel
local minHeight = 2.0

function Initialize()
    barCount      = tonumber(SKIN:GetVariable('BarCount',    '16')) or 16
    barMaxHeight  = tonumber(SKIN:GetVariable('BarMaxHeight','24')) or 24
    attackRate    = tonumber(SKIN:GetVariable('AttackRate',  '0.40')) or 0.40
    decayRate     = tonumber(SKIN:GetVariable('DecayRate',   '0.08')) or 0.08

    bandMeasures  = {}
    currentValues = {}

    for i = 0, barCount - 1 do
        bandMeasures[i]  = SKIN:GetMeasure('MeasureBand' .. i)
        currentValues[i] = 0.0
    end
end

function Update()
    for i = 0, barCount - 1 do
        local raw = 0.0
        if bandMeasures[i] then
            raw = bandMeasures[i]:GetValue() or 0.0
            -- Guard against NaN / non-number results
            if raw ~= raw then raw = 0.0 end
        end

        -- Clamp raw value between 0 and 1
        if raw < 0 then raw = 0 end
        if raw > 1 then raw = 1 end

        local cur = currentValues[i] or 0.0
        if raw > cur then
            -- Fast attack: lerp toward raw
            cur = cur + (raw - cur) * attackRate
        else
            -- Smooth decay: lerp toward raw (avoids undershooting below raw)
            cur = cur + (raw - cur) * decayRate
        end

        if cur < 0 then cur = 0 end
        currentValues[i] = cur
    end

    return 0
end

-- Export function callable from Rainmeter inline: [&MeasureScript:GetBarHeight(0)]
function GetBarHeight(index)
    local idx = tonumber(index) or 0
    local val = currentValues[idx] or 0.0
    local h = val * barMaxHeight
    if h < minHeight then
        h = minHeight
    end
    return string.format('%.1f', h)
end

-- Export function to get bar Y position for bottom-anchored alignment
function GetBarY(index)
    local idx = tonumber(index) or 0
    local val = currentValues[idx] or 0.0
    local h = val * barMaxHeight
    if h < minHeight then
        h = minHeight
    end
    local y = barMaxHeight - h
    return string.format('%.1f', y)
end
