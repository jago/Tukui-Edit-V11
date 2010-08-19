--[[

	Credits:
	Telroth (Darth Android) - Concept and code reference.
	
	Edited and rewritten by: Eclípsé
	
]]

if not TukuiCF["Others"].spincam then return end

local cam = CreateFrame("Frame")

local OnEvent = function(self, event, unit)
	local afk = UnitIsAFK("player")
	
	if (event == "PLAYER_FLAGS_CHANGED") then
		if afk then
			SpinStart()
		else
			SpinStop()
		end
	elseif (event == "PLAYER_LEAVING_WORLD") then
		SpinStop()
	end
end
cam:RegisterEvent("PLAYER_ENTERING_WORLD")
cam:RegisterEvent("PLAYER_LEAVING_WORLD")
cam:RegisterEvent("PLAYER_FLAGS_CHANGED")
cam:SetScript("OnEvent", OnEvent)

function SpinStart()
	ResetView(5)
	SetView(5)
	MoveViewRightStart(.04)
end

function SpinStop()
	MoveViewRightStop()
end
