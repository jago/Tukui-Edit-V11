local Unitframes = TukuiCF["Unitframes"]

if not Unitframes.enable then return end

------------------------------------------------------------------------
--	Variables
------------------------------------------------------------------------

local font = TukuiCF["Fonts"].font
local empath = TukuiCF["Textures"].empath

------------------------------------------------------------------------
--	Layout
------------------------------------------------------------------------
local Shared = function(self, unit)
	self.colors = TukuiDB.oUF_colors
	
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self.menu = TukuiDB.SpawnMenu
	self:SetAttribute('type2', 'menu')
	
	self.Backdrop = CreateFrame("Frame", nil, self)
	TukuiDB.CreateUFBackdrop(self.Backdrop, 1, 1, "TOPLEFT", 0, 0)
	self.Backdrop:SetPoint("TOPLEFT", -TukuiDB.mult, TukuiDB.mult)
	self.Backdrop:SetPoint("BOTTOMRIGHT", TukuiDB.mult, -TukuiDB.mult)

	------------------------------------------------------------------------
	--	Player and Target Layout
	------------------------------------------------------------------------
	
	if (unit == "player" or unit == "target") then
		self:SetAttribute("initial-height", TukuiDB.Scale(35))
		self:SetAttribute("initial-width", TukuiDB.Scale(197))

		local health = CreateFrame("StatusBar", nil, self)
		health:SetHeight(TukuiDB.Scale(28))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(empath)

		local healthBg = health:CreateTexture(nil, "BORDER")
		healthBg:SetAllPoints()
		healthBg:SetTexture(empath)
		healthBg:SetVertexColor(.05, .05, .05)

		local healthBorder = CreateFrame("Frame", nil, health)
		TukuiDB.CreateUFBorder(healthBorder, 1, 1, "TOPLEFT", 0, 0)
		healthBorder:SetAllPoints()

		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(4))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(empath)

		local powerBg = power:CreateTexture(nil, "BORDER")
		powerBg:SetAllPoints()
		powerBg:SetTexture(empath)
		powerBg:SetVertexColor(.05, .05, .05)
		powerBg.multiplier = 0.3

		local powerBorder = CreateFrame("Frame", nil, power)
		TukuiDB.CreateUFBorder(powerBorder, 1, 1, "TOPLEFT", 0, 0)
		powerBorder:SetAllPoints()

		health.frequentUpdates = true
		power.frequentUpdates = true
		if (Unitframes.showsmooth) then
			health.Smooth = true
			power.Smooth = true
		end
		if (Unitframes.classcolor) then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClass = true
			healthBg.multiplier = 0.3
			
			power.colorPower = true
			powerBg.multiplier = 0.4
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false			
			health:SetStatusBarColor(.15, .15, .15)
			
			power.colorTapping = true
			power.colorDisconnected = true
			power.colorClass = true
			power.colorReaction = true
		end
		
		self.Health = health
		self.Health.bg = healthBg
		self.Health.border = healthBorder

		self.Power = power
		self.Power.bg = powerBg
		self.Power.border = powerBorder

		local panel = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(panel, 1, 1, "CENTER", self, 0, 0)
		panel:ClearAllPoints()
		panel:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -TukuiDB.Scale(3))
		panel:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, -TukuiDB.Scale(22))
		self.panel = panel

		health.value = TukuiDB.SetFontString(panel, font, 12)
		health.value:SetPoint("RIGHT", panel, "RIGHT", -TukuiDB.Scale(4), 0)

		power.value = TukuiDB.SetFontString(panel, font, 12)
		power.value:SetPoint("LEFT", panel, "LEFT", TukuiDB.Scale(4), 0)
		
		health.PostUpdate = TukuiDB.PostUpdateHealth
		power.PreUpdate = TukuiDB.PreUpdatePower
		power.PostUpdate = TukuiDB.PostUpdatePower
		
		if unit == "target" then
			name = TukuiDB.SetFontString(panel, font, 12)
			name:SetPoint("CENTER", panel, "CENTER", 0, 0)
			self:Tag(name, '[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]')
			self.Name = name
		end
		
		if (Unitframes.charportrait) then			
			local portrait = CreateFrame("PlayerModel", nil, self)
			portrait:SetFrameLevel(1)
			portrait:SetAlpha(1)
			portrait:SetHeight(57)
			portrait:SetWidth(60)
			if unit == "player" then
				portrait:SetPoint("TOPRIGHT", self, "TOPLEFT", -TukuiDB.Scale(3), 0)
			elseif unit == "target" then
				portrait:SetPoint("TOPLEFT", self, "TOPRIGHT", TukuiDB.Scale(3), 0)
			end
			
			local pBg = CreateFrame("Frame", nil, portrait)
			pBg:SetFrameLevel(0)
			pBg:SetAllPoints()
			TukuiDB.SetTemplate(pBg)
			pBg:SetBackdropColor(unpack(TukuiCF["Colors"].fadedbackdropcolor))
			pBg:SetBackdropBorderColor(0, 0, 0, 0)

			local pFrame = CreateFrame("Frame", nil, portrait)
			TukuiDB.SkinFadedPanel(pFrame)
			pFrame:SetAllPoints()
			pFrame:SetFrameLevel(20)
			pFrame:SetBackdropColor(0, 0, 0, 0)

			local pBorder = CreateFrame("Frame", nil, portrait)
			TukuiDB.CreateUFBorder(pBorder)
			pBorder:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
			pBorder:SetPoint("BOTTOMRIGHT", -TukuiDB.mult, TukuiDB.mult)
			pBorder:SetFrameLevel(20)
			pBorder:SetBackdropColor(0, 0, 0, 0)

			table.insert(self.__elements, TukuiDB.HidePortrait)
			self.Portrait = portrait
		end
		
		if (unit == "target" and Unitframes.targetauras) or (unit == "player" and Unitframes.playerauras) then
			local buffs = CreateFrame("Frame", nil, self)
			local debuffs = CreateFrame("Frame", nil, self)

			if unit == "player" then
				if (TukuiDB.myclass == "SHAMAN" and Unitframes.totembar) or (TukuiDB.myclass == "DEATHKNIGHT" and Unitframes.runebar) and Unitframes.playerauras then
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, TukuiDB.Scale(37))
				else
					buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, TukuiDB.Scale(25))
				end
			else
				buffs:SetPoint("TOPLEFT", self, "TOPLEFT", 0, TukuiDB.Scale(25))
			end
			
			buffs:SetHeight(22)
			buffs:SetWidth(195)
			buffs.size = 22
			buffs.num = 8
		
			debuffs:SetHeight(22)
			debuffs:SetWidth(195)
			debuffs:SetPoint("BOTTOMLEFT", buffs, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(3))
			debuffs.size = 22
			debuffs.num = 24
			
			buffs.spacing = 3
			buffs.initialAnchor = 'TOPLEFT'
			self.Buffs = buffs	
			
			debuffs.spacing = 3
			debuffs.initialAnchor = 'TOPRIGHT'
			debuffs["growth-y"] = "UP"
			debuffs["growth-x"] = "LEFT"
			debuffs.onlyShowPlayer = Unitframes.playerdebuffsonly
			self.Debuffs = debuffs
			
			buffs.PostCreateIcon = TukuiDB.PostCreateAura
			buffs.PostUpdateIcon = TukuiDB.PostUpdateAura
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
		end		

		if unit == "player" then
			if (TukuiDB.myclass == "DEATHKNIGHT" and Unitframes.runebar) then
				local runes = CreateFrame("Frame", nil, self)
				TukuiDB.CreateUFBackdrop(runes, 1, 1, "TOPLEFT", 0, 0)
				runes:SetPoint("TOPLEFT", self, "TOPLEFT", -TukuiDB.mult, TukuiDB.Scale(13))
				runes:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", TukuiDB.mult, TukuiDB.Scale(2))
				
				for i = 1, 6 do
					runes[i] = CreateFrame("StatusBar", self:GetName().."_Runes"..i, self)
					runes[i]:SetHeight(TukuiDB.Scale(7))
					runes[i]:SetWidth(TukuiDB.Scale(190) / 6)
					if (i == 1) then
						runes[i]:SetPoint("TOPLEFT", runes, "TOPLEFT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
					else
						runes[i]:SetPoint("TOPLEFT", runes[i-1], "TOPRIGHT", TukuiDB.mult, 0)
					end
					runes[i]:SetStatusBarTexture(empath)
					
					local runeBg = runes[i]:CreateTexture(nil, "BORDER")
					runeBg:SetAllPoints()
					runeBg:SetTexture(empath)
					runeBg:SetVertexColor(.15, .15, .15)

					local runeBorder = CreateFrame("Frame", nil, runes[i])
					TukuiDB.CreateUFBorder(runeBorder, 1, 1, "TOPLEFT", 0, 0)
					runeBorder:SetAllPoints()
				end
				self.Runes = runes
			end
			
			if TukuiDB.myclass == "SHAMAN" and Unitframes.totembar then
				local TotemBar = {}
				TotemBar.Destroy = true
				
				local totems = CreateFrame("Frame", nil, self)
				TukuiDB.CreateUFBackdrop(totems, 1, 1, "TOPLEFT", 0, 0)
				totems:SetPoint("TOPLEFT", self, "TOPLEFT", -TukuiDB.mult, TukuiDB.Scale(13))
				totems:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", TukuiDB.mult, TukuiDB.Scale(2))

				for i = 1, 4 do
					TotemBar[i] = CreateFrame("StatusBar", self:GetName().."_TotemBar"..i, totems)
					TotemBar[i]:SetHeight(TukuiDB.Scale(7))
					TotemBar[i]:SetWidth(TukuiDB.Scale(192) / 4)
					if (i == 1) then
						TotemBar[i]:SetPoint("TOPLEFT", totems, "TOPLEFT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
					else
					   TotemBar[i]:SetPoint("TOPLEFT", TotemBar[i-1], "TOPRIGHT", TukuiDB.mult, 0)
					end
					TotemBar[i]:SetStatusBarTexture(empath)
					TotemBar[i]:SetMinMaxValues(0, 1)
					
					TotemBar[i].bg = TotemBar[i]:CreateTexture(nil, "BORDER")
					TotemBar[i].bg:SetAllPoints(TotemBar[i])
					TotemBar[i].bg:SetTexture(empath)
					TotemBar[i].bg.multiplier = 0.3
					
					local totemBorder = CreateFrame("Frame", nil, TotemBar[i])
					TukuiDB.CreateUFBorder(totemBorder, 1, 1, "TOPLEFT", 0, 0)
					totemBorder:SetAllPoints()

				end
				self.TotemBar = TotemBar
			end
		
			local flashInfo = CreateFrame("Frame", "FlashInfo", self)
			flashInfo:SetScript("OnUpdate", TukuiDB.UpdateManaLevel)
			flashInfo.parent = self
			flashInfo:SetToplevel(true)
			flashInfo:SetAllPoints(panel)
			flashInfo.ManaLevel = TukuiDB.SetFontString(flashInfo, font, 12)
			flashInfo.ManaLevel:SetPoint("CENTER", panel, "CENTER", 0, 0)
			self.FlashInfo = flashInfo
			
			local status = TukuiDB.SetFontString(panel, font, 12)
			status:SetPoint("CENTER", panel, "CENTER", 0, 0)
			status:SetTextColor(0.69, 0.31, 0.31, 0)
			self.Status = status
			self:Tag(status, "[pvp]")
			
			self:SetScript("OnEnter", function(self) FlashInfo.ManaLevel:Hide() status:SetAlpha(1) UnitFrame_OnEnter(self) end)
			self:SetScript("OnLeave", function(self) FlashInfo.ManaLevel:Show() status:SetAlpha(0) UnitFrame_OnLeave(self) end)

			if TukuiDB.myclass == "DRUID" then
				CreateFrame("Frame"):SetScript("OnUpdate", function() TukuiDB.UpdateDruidMana(self) end)
				local druidMana = TukuiDB.SetFontString(panel, font, 12)
				druidMana:SetTextColor(1, 0.49, 0.04)
				self.DruidMana = druidMana
			end
		end

		-- setup castbar for player and target
		if (Unitframes.unitcastbar) then
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetStatusBarTexture(empath)

			if not Unitframes.cbinside then
				if unit == "player" then
					castbar:SetHeight(TukuiDB.Scale(22))
						if (Unitframes.cbicons) then
							castbar:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", TukuiDB.Scale(31), TukuiDB.Scale(5))
						else
							castbar:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", TukuiDB.Scale(2), TukuiDB.Scale(5))
						end
					castbar:SetPoint("BOTTOMRIGHT", MultiBarBottomLeftButton12, "TOPRIGHT", -TukuiDB.Scale(2), TukuiDB.Scale(5))
				
					local castbarBg = CreateFrame("Frame", nil, castbar)
					castbarBg:SetPoint("TOPLEFT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
					castbarBg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
					castbarBg:SetFrameLevel(castbar:GetFrameLevel() - 1)
					TukuiDB.SkinPanel(castbarBg)
				elseif unit == "target" then
					if Unitframes.healermode then
						castbar:SetPoint("TOPLEFT", panel, "TOPLEFT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
						castbar:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
						castbar:SetFrameLevel(4)
						
						local castbarBg = CreateFrame("Frame", nil, castbar)
						castbarBg:SetPoint("TOPLEFT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
						castbarBg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
						castbarBg:SetFrameLevel(castbar:GetFrameLevel() - 1)
						TukuiDB.SetTemplate(castbarBg)
					else
						castbar:SetHeight(TukuiDB.Scale(22))
						castbar:SetWidth(TukuiDB.Scale(141))
						castbar:SetPoint("BOTTOM", TukuiDataBottom, "TOP", 0, TukuiDB.Scale(178))
						
						local castbarBg = CreateFrame("Frame", nil, castbar)
						castbarBg:SetPoint("TOPLEFT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
						castbarBg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
						castbarBg:SetFrameLevel(castbar:GetFrameLevel() - 1)
						TukuiDB.SkinPanel(castbarBg)
					end
				end
			else
				castbar:SetPoint("TOPLEFT", panel, "TOPLEFT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
				castbar:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
				castbar:SetFrameLevel(4)
				
				local castbarBg = CreateFrame("Frame", nil, castbar)
				castbarBg:SetPoint("TOPLEFT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
				castbarBg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
				castbarBg:SetFrameLevel(castbar:GetFrameLevel() - 1)
				TukuiDB.SetTemplate(castbarBg)
			end
			
			castbar.time = TukuiDB.SetFontString(castbar, font, 12)
			castbar.time:SetPoint("RIGHT", castbar, "RIGHT", -TukuiDB.Scale(4), 0)
			castbar.time:SetTextColor(1, 1, 1)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = TukuiDB.SetFontString(castbar, font, 12)
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", TukuiDB.Scale(4), 0)
			castbar.Text:SetTextColor(1, 1, 1)
			
			if (Unitframes.cbicons) then
				castbar.button = CreateFrame("Frame", nil, castbar)
				if Unitframes.cbinside then
					if not Unitframes.healermode then
						if unit == "player" then
							castbar.button:SetHeight(TukuiDB.Scale(26))
							castbar.button:SetWidth(TukuiDB.Scale(26))
							castbar.button:SetPoint("LEFT", self, "RIGHT", TukuiDB.Scale(5), 0)
						elseif unit == "target" then
							castbar.button:SetHeight(TukuiDB.Scale(26))
							castbar.button:SetWidth(TukuiDB.Scale(26))
							castbar.button:SetPoint("RIGHT", self, "LEFT", -TukuiDB.Scale(5), 0)
						end
					end
				else
					if unit == "player" then
						castbar.button:SetHeight(TukuiDB.Scale(26))
						castbar.button:SetWidth(TukuiDB.Scale(26))
						castbar.button:SetPoint("RIGHT", castbar, "LEFT", -TukuiDB.Scale(5), 0)
					elseif unit == "target" then
						if not Unitframes.healermode then
							castbar.button:SetHeight(TukuiDB.Scale(26))
							castbar.button:SetWidth(TukuiDB.Scale(26))
							castbar.button:SetPoint("TOP", castbar, "BOTTOM", 0, -TukuiDB.Scale(7))
						end
					end
				end
				TukuiDB.SkinPanel(castbar.button)

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:SetPoint("TOPLEFT", castbar.button, TukuiDB.Scale(2), -TukuiDB.Scale(2))
				castbar.icon:SetPoint("BOTTOMRIGHT", castbar.button, -TukuiDB.Scale(2), TukuiDB.Scale(2))
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
				
				castbar.CustomTimeText = TukuiDB.CustomCastTimeText
				castbar.CustomDelayText = TukuiDB.CustomCastDelayText
				castbar.PostCastStart = TukuiDB.PostCastStart
				castbar.PostChannelStart = TukuiDB.PostCastStart
				castbar:RegisterEvent('UNIT_SPELLCAST_INTERRUPTABLE', TukuiDB.SpellCastInterruptable)
				castbar:RegisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTABLE', TukuiDB.SpellCastInterruptable)
			end
			
			if (unit == "player" and Unitframes.cblatency) then
				castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
				castbar.safezone:SetTexture(empath)
				castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
				castbar.SafeZone = castbar.safezone
			end
			
			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
		end
		
		if (Unitframes.combatfeedback) then
			local CombatFeedbackText = TukuiDB.SetFontString(health, font, 16)
			CombatFeedbackText:SetPoint("CENTER", 0, TukuiDB.mult)
			CombatFeedbackText.colors = {
				DAMAGE = {0.69, 0.31, 0.31},
				CRUSHING = {0.69, 0.31, 0.31},
				CRITICAL = {0.69, 0.31, 0.31},
				GLANCING = {0.69, 0.31, 0.31},
				STANDARD = {0.84, 0.75, 0.65},
				IMMUNE = {0.84, 0.75, 0.65},
				ABSORB = {0.84, 0.75, 0.65},
				BLOCK = {0.84, 0.75, 0.65},
				RESIST = {0.84, 0.75, 0.65},
				MISS = {0.84, 0.75, 0.65},
				HEAL = {0.33, 0.59, 0.33},
				CRITHEAL = {0.33, 0.59, 0.33},
				ENERGIZE = {0.31, 0.45, 0.63},
				CRITENERGIZE = {0.31, 0.45, 0.63},
			}
			self.CombatFeedbackText = CombatFeedbackText
		end
		
		-- fixing vehicle/player frame when exiting an instance while on a vehicle
		self:RegisterEvent("UNIT_PET", TukuiDB.updateAllElements)
	end

	------------------------------------------------------------------------
	--	Target of Target Layout
	------------------------------------------------------------------------

	if unit == "targettarget" then
		self:SetAttribute("initial-height", TukuiDB.Scale(28))
		if Unitframes.healermode or not Unitframes.charportrait then
			self:SetAttribute("initial-width", TukuiDB.Scale(127))
		else
			self:SetAttribute("initial-width", TukuiDB.Scale(130))
		end

		local health = CreateFrame("StatusBar", nil, self)
		health:SetHeight(TukuiDB.Scale(22))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(empath)

		local healthBg = health:CreateTexture(nil, "BORDER")
		healthBg:SetAllPoints()
		healthBg:SetTexture(empath)
		healthBg:SetVertexColor(.05, .05, .05)

		local healthBorder = CreateFrame("Frame", nil, health)
		TukuiDB.CreateUFBorder(healthBorder, 1, 1, "TOPLEFT", 0, 0)
		healthBorder:SetAllPoints()

		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(3))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(empath)

		local powerBg = power:CreateTexture(nil, "BORDER")
		powerBg:SetAllPoints()
		powerBg:SetTexture(empath)
		powerBg:SetVertexColor(.05, .05, .05)
		powerBg.multiplier = 0.3

		local powerBorder = CreateFrame("Frame", nil, power)
		TukuiDB.CreateUFBorder(powerBorder, 1, 1, "TOPLEFT", 0, 0)
		powerBorder:SetAllPoints()

		local name = TukuiDB.SetFontString(health, font, 12)
		name:SetPoint("CENTER", health, "CENTER", 0, 0)
		self.Name = name

		health.frequentUpdates = true
		power.frequentUpdates = true
		if (Unitframes.showsmooth) then
			health.Smooth = true
			power.Smooth = true
		end
		if (Unitframes.classcolor) then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClass = true
			healthBg.multiplier = 0.3
			
			power.colorPower = true
			powerBg.multiplier = 0.4
			
			self:Tag(name, '[Tukui:namelong]')
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.15, .15, .15)
			
			power.colorTapping = true
			power.colorDisconnected = true
			power.colorClass = true
			power.colorReaction = true
			
			self:Tag(name, '[Tukui:getnamecolor][Tukui:namelong]')
		end
		
		self.Health = health
		self.Health.bg = healthBg
		self.Health.border = healthBorder

		self.Power = power
		self.Power.bg = powerBg
		self.Power.border = powerBorder
		
		if Unitframes.totdebuffs then
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs:SetHeight(23)
			debuffs:SetWidth(129)
			if Unitframes.healermode or not Unitframes.charportrait then
				debuffs:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", 0, -TukuiDB.Scale(3))
			else
				debuffs:SetPoint("TOPRIGHT", self, "TOPLEFT", -TukuiDB.Scale(3), 0)
			end
			debuffs.size = 23
			debuffs.num = 5
			debuffs.spacing = 3
			debuffs.initialAnchor = 'TOPRIGHT'
			debuffs["growth-y"] = "DOWN"
			debuffs["growth-x"] = "LEFT"
			self.Debuffs = debuffs
			
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
		end
	end
	
	------------------------------------------------------------------------
	--	Focus Layout
	------------------------------------------------------------------------

	if unit == "focus" then
		self:SetAttribute("initial-height", TukuiDB.Scale(28))
		if Unitframes.healermode or not Unitframes.charportrait then
			self:SetAttribute("initial-width", TukuiDB.Scale(127))
		else
			self:SetAttribute("initial-width", TukuiDB.Scale(130))
		end

		local health = CreateFrame("StatusBar", nil, self)
		health:SetHeight(TukuiDB.Scale(22))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(empath)

		local healthBg = health:CreateTexture(nil, "BORDER")
		healthBg:SetAllPoints()
		healthBg:SetTexture(empath)
		healthBg:SetVertexColor(.05, .05, .05)

		local healthBorder = CreateFrame("Frame", nil, health)
		TukuiDB.CreateUFBorder(healthBorder, 1, 1, "TOPLEFT", 0, 0)
		healthBorder:SetAllPoints()

		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(3))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(empath)

		local powerBg = power:CreateTexture(nil, "BORDER")
		powerBg:SetAllPoints()
		powerBg:SetTexture(empath)
		powerBg:SetVertexColor(.05, .05, .05)
		powerBg.multiplier = 0.3

		local powerBorder = CreateFrame("Frame", nil, power)
		TukuiDB.CreateUFBorder(powerBorder, 1, 1, "TOPLEFT", 0, 0)
		powerBorder:SetAllPoints()

		local name = TukuiDB.SetFontString(health, font, 12)
		name:SetPoint("CENTER", health, "CENTER", 0, 0)
		self.Name = name

		health.frequentUpdates = true
		power.frequentUpdates = true
		if (Unitframes.showsmooth) then
			health.Smooth = true
			power.Smooth = true
		end
		if (Unitframes.classcolor) then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClass = true
			healthBg.multiplier = 0.3
			
			power.colorPower = true
			powerBg.multiplier = 0.4
			
			self:Tag(name, '[Tukui:namelong]')
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.15, .15, .15)
			
			power.colorTapping = true
			power.colorDisconnected = true
			power.colorClass = true
			power.colorReaction = true
			
			self:Tag(name, '[Tukui:getnamecolor][Tukui:namelong]')
		end
		
		self.Health = health
		self.Health.bg = healthBg
		self.Health.border = healthBorder

		self.Power = power
		self.Power.bg = powerBg
		self.Power.border = powerBorder
		
		if (Unitframes.unitcastbar) then
			local castbar = CreateFrame("StatusBar", self:GetName().."_Castbar", self)
			castbar:SetStatusBarTexture(empath)
			castbar:SetHeight(TukuiDB.Scale(20))
			castbar:SetWidth(TukuiDB.Scale(240))
			castbar:SetPoint("CENTER", UIParent, "CENTER", 0, TukuiDB.Scale(160))
			
			castbar.bg = CreateFrame("Frame", nil, castbar)
			TukuiDB.SkinPanel(castbar.bg)
			castbar.bg:SetPoint("TOPLEFT", -TukuiDB.Scale(2), TukuiDB.Scale(2))
			castbar.bg:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), -TukuiDB.Scale(2))
			castbar.bg:SetFrameLevel(castbar:GetFrameLevel() - 1)
			
			castbar.time = TukuiDB.SetFontString(castbar, font, 12)
			castbar.time:SetPoint("RIGHT", castbar, "RIGHT", -TukuiDB.Scale(4), 0)
			castbar.time:SetTextColor(1, 1, 1)
			castbar.time:SetJustifyH("RIGHT")

			castbar.Text = TukuiDB.SetFontString(castbar, font, 12)
			castbar.Text:SetPoint("LEFT", castbar, "LEFT", TukuiDB.Scale(4), 0)
			castbar.Text:SetTextColor(1, 1, 1)
			
			if (Unitframes.cbicons) then
				castbar.button = CreateFrame("Frame", nil, castbar)
				castbar.button:SetHeight(TukuiDB.Scale(30))
				castbar.button:SetWidth(TukuiDB.Scale(30))
				castbar.button:SetPoint("BOTTOM", castbar, "TOP", 0, TukuiDB.Scale(7))
				TukuiDB.SkinPanel(castbar.button)

				castbar.icon = castbar.button:CreateTexture(nil, "ARTWORK")
				castbar.icon:SetPoint("TOPLEFT", castbar.button, TukuiDB.Scale(2), -TukuiDB.Scale(2))
				castbar.icon:SetPoint("BOTTOMRIGHT", castbar.button, -TukuiDB.Scale(2), TukuiDB.Scale(2))
				castbar.icon:SetTexCoord(0.08, 0.92, 0.08, .92)
			end
			
			if (unit == "player" and Unitframes.cblatency) then
				castbar.safezone = castbar:CreateTexture(nil, "ARTWORK")
				castbar.safezone:SetTexture(empath)
				castbar.safezone:SetVertexColor(0.69, 0.31, 0.31, 0.75)
				castbar.SafeZone = castbar.safezone
			end
			
			self.Castbar = castbar
			self.Castbar.Time = castbar.time
			self.Castbar.Icon = castbar.icon
			
			castbar.CustomTimeText = TukuiDB.CustomCastTimeText
			castbar.CustomDelayText = TukuiDB.CustomCastDelayText
			castbar.PostCastStart = TukuiDB.PostCastStart
			castbar.PostChannelStart = TukuiDB.PostCastStart
			castbar:RegisterEvent('UNIT_SPELLCAST_INTERRUPTABLE', TukuiDB.SpellCastInterruptable)
			castbar:RegisterEvent('UNIT_SPELLCAST_NOT_INTERRUPTABLE', TukuiDB.SpellCastInterruptable)
		end

		if Unitframes.focusdebuffs then
			local debuffs = CreateFrame("Frame", nil, self)
			debuffs:SetHeight(23)
			debuffs:SetWidth(129)
			if Unitframes.healermode or not Unitframes.charportrait then
				debuffs:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -TukuiDB.Scale(3))
			else
				debuffs:SetPoint("TOPLEFT", self, "TOPRIGHT", TukuiDB.Scale(3), 0)
			end
			debuffs.size = 23
			debuffs.num = 5
			debuffs.spacing = 3
			debuffs.initialAnchor = "TOPLEFT"
			debuffs["growth-y"] = "DOWN"
			debuffs["growth-x"] = "RIGHT"
			self.Debuffs = debuffs
			
			debuffs.PostCreateIcon = TukuiDB.PostCreateAura
			debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
		end
	end
	
	------------------------------------------------------------------------
	--	Pet Layout
	------------------------------------------------------------------------

	if unit == "pet" then
		self:SetAttribute("initial-height", TukuiDB.Scale(22))
		self:SetAttribute("initial-width", TukuiDB.Scale(60))

		local health = CreateFrame("StatusBar", nil, self)
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("BOTTOMRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(empath)

		local healthBg = health:CreateTexture(nil, "BORDER")
		healthBg:SetAllPoints()
		healthBg:SetTexture(empath)
		healthBg:SetVertexColor(.05, .05, .05)

		local healthBorder = CreateFrame("Frame", nil, health)
		TukuiDB.CreateUFBorder(healthBorder, 1, 1, "TOPLEFT", 0, 0)
		healthBorder:SetAllPoints()

		health.frequentUpdates = true
		if (Unitframes.showsmooth) then
			health.Smooth = true
		end
		if (Unitframes.classcolor) then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClassPet = true    
			health.colorClass = true
			healthBg.multiplier = 0.3
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClassPet = false
			health.colorClass = false
			health:SetStatusBarColor(.15, .15, .15)
		end
		
		self.Health = health
		self.Health.bg = healthBg
		self.Health.border = healthBorder
		
		local name = TukuiDB.SetFontString(health, font, 12)
		name:SetPoint("CENTER", health, "CENTER", 0, 0)
		self:Tag(name, '[Tukui:getnamecolor][Tukui:nameshort]')
		self.Name = name
		
		-- update pet name, this should fix "UNKNOWN" pet names on pet unit.
		self:RegisterEvent("UNIT_PET", TukuiDB.UpdatePetInfo)
	end
	
	------------------------------------------------------------------------
	--	Focus Target Layout
	------------------------------------------------------------------------

	if unit == "focustarget" then
		if Unitframes.healermode or not Unitframes.charportrait then
			self:SetAttribute("initial-height", TukuiDB.Scale(24))
			self:SetAttribute("initial-width", TukuiDB.Scale(67))
		else
			self:SetAttribute("initial-height", TukuiDB.Scale(24))
			self:SetAttribute("initial-width", TukuiDB.Scale(67))
		end
		
		local health = CreateFrame("StatusBar", nil, self)
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("BOTTOMRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(empath)

		local healthBg = health:CreateTexture(nil, "BORDER")
		healthBg:SetAllPoints()
		healthBg:SetTexture(empath)
		healthBg:SetVertexColor(.05, .05, .05)

		local healthBorder = CreateFrame("Frame", nil, health)
		TukuiDB.CreateUFBorder(healthBorder, 1, 1, "TOPLEFT", 0, 0)
		healthBorder:SetAllPoints()

		local name = TukuiDB.SetFontString(health, font, 12)
		name:SetPoint("CENTER", health, "CENTER", 0, 0)
		self:Tag(name, '[Tukui:getnamecolor][Tukui:nameshort]')
		self.Name = name

		health.frequentUpdates = true
		if (Unitframes.showsmooth) then
			health.Smooth = true
		end
		if (Unitframes.classcolor) then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClassPet = true    
			health.colorClass = true
			healthBg.multiplier = 0.3
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClassPet = false
			health.colorClass = false
			health:SetStatusBarColor(.15, .15, .15)
		end
		
		self.Health = health
		self.Health.bg = healthBg
		self.Health.border = healthBorder
	end

	------------------------------------------------------------------------
	--	Arena Layout
	------------------------------------------------------------------------
	
	if (unit and unit:find("arena%d") and TukuiCF["Arena"].enable) then
		self:SetAttribute("initial-height", TukuiDB.Scale(33))
		self:SetAttribute("initial-width", TukuiDB.Scale(190))
		
		local health = CreateFrame("StatusBar", self:GetName().."_Health", self)
		health:SetHeight(TukuiDB.Scale(26))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(empath)

		local healthBg = health:CreateTexture(nil, "BORDER")
		healthBg:SetAllPoints()
		healthBg:SetTexture(empath)
		healthBg:SetVertexColor(.05, .05, .05)

		local healthBorder = CreateFrame("Frame", nil, health)
		TukuiDB.CreateUFBorder(healthBorder, 1, 1, "TOPLEFT", 0, 0)
		healthBorder:SetAllPoints()
			
		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(4))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(empath)
	
		local powerBg = power:CreateTexture(nil, "BORDER")
		powerBg:SetAllPoints()
		powerBg:SetTexture(empath)
		powerBg:SetVertexColor(.05, .05, .05)
		powerBg.multiplier = 0.3

		local powerBorder = CreateFrame("Frame", nil, power)
		TukuiDB.CreateUFBorder(powerBorder, 1, 1, "TOPLEFT", 0, 0)
		powerBorder:SetAllPoints()

		health.frequentUpdates = true
		power.frequentUpdates = true
		if (Unitframes.showsmooth) then
			health.Smooth = true
			power.Smooth = true
		end
		if (Unitframes.classcolor) then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = false
			health.colorClass = true
			healthBg.multiplier = 0.3
			
			power.colorPower = true
			powerBg.multiplier = 0.4
		else
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.15,.15,.15)
			
			power.colorClass = true
		end

		self.Health = health
		self.Health.bg = healthBg
		self.Health.border = healthBorder

		self.Power = power
		self.Power.bg = powerBg
		self.Power.border = powerBorder
		
		local panel = CreateFrame("Frame", nil, self)
		TukuiDB.CreatePanel(panel, 1, 1, "CENTER", self, 0, 0)
		panel:ClearAllPoints()
		panel:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 0, -TukuiDB.Scale(3))
		panel:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 0, -TukuiDB.Scale(22))
		self.panel = panel

		health.value = TukuiDB.SetFontString(panel, font, 12)
		health.value:SetPoint("LEFT", panel, "LEFT", TukuiDB.Scale(4), 0)

		power.value = TukuiDB.SetFontString(panel, font, 12)
		power.value:SetPoint("RIGHT", panel, "RIGHT", -TukuiDB.Scale(4), 0)
		
		health.PostUpdate = TukuiDB.PostUpdateHealth
		power.PreUpdate = TukuiDB.PreUpdatePower
		power.PostUpdate = TukuiDB.PostUpdatePower
		
		local name = TukuiDB.SetFontString(panel, font, 12)
		name:SetPoint("CENTER", panel, "CENTER", 0, 0)
		self:Tag(name, '[Tukui:getnamecolor][Tukui:namemedium]')
		self.Name = name

		local debuffs = CreateFrame("Frame", nil, self)
		debuffs:SetHeight(26)
		debuffs:SetWidth(200)
		debuffs:SetPoint("TOPLEFT", self, "TOPRIGHT", TukuiDB.Scale(3), 0)
		debuffs.size = 26
		debuffs.num = 5
		debuffs.spacing = 2
		debuffs.initialAnchor = "TOPLEFT"
		debuffs["growth-x"] = "RIGHT"
		debuffs.PostCreateIcon = TukuiDB.PostCreateAura
		debuffs.PostUpdateIcon = TukuiDB.PostUpdateAura
		debuffs.onlyShowPlayer = Unitframes.playerdebuffsonly
		self.Debuffs = debuffs	

		if not IsAddOnLoaded("Gladius") then
			if (unit and unit:find('arena%d') and (not unit:find("arena%dtarget"))) then
				local Trinketbg = CreateFrame("Frame", nil, self)
				Trinketbg:SetHeight(33)
				Trinketbg:SetWidth(33)
				Trinketbg:SetPoint("TOPRIGHT", self, "TOPLEFT", -TukuiDB.Scale(3), 0)				
				TukuiDB.SkinPanel(Trinketbg)
				Trinketbg:SetFrameLevel(0)
				self.Trinketbg = Trinketbg
				
				local Trinket = CreateFrame("Frame", nil, Trinketbg)
				Trinket:SetAllPoints(Trinketbg)
				Trinket:SetPoint("TOPLEFT", Trinketbg, TukuiDB.Scale(2), -TukuiDB.Scale(2))
				Trinket:SetPoint("BOTTOMRIGHT", Trinketbg, -TukuiDB.Scale(2), TukuiDB.Scale(2))
				Trinket:SetFrameLevel(1)
				Trinket.trinketUseAnnounce = true
				self.Trinket = Trinket
			end
		end
	end
	
	------------------------------------------------------------------------
	--	Boss Layout (Needs testing)
	------------------------------------------------------------------------

	if (unit and unit:find("boss%d") and Unitframes.showboss) then
		self:SetAttribute("initial-height", TukuiDB.Scale(28))
		self:SetAttribute("initial-width", TukuiDB.Scale(130))

		local health = CreateFrame("StatusBar", nil, self)
		health:SetHeight(TukuiDB.Scale(22))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(empath)

		local healthBg = health:CreateTexture(nil, "BORDER")
		healthBg:SetAllPoints()
		healthBg:SetTexture(empath)
		healthBg:SetVertexColor(.05, .05, .05)

		local healthBorder = CreateFrame("Frame", nil, health)
		TukuiDB.CreateUFBorder(healthBorder, 1, 1, "TOPLEFT", 0, 0)
		healthBorder:SetAllPoints()

		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(3))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(empath)

		local powerBg = power:CreateTexture(nil, "BORDER")
		powerBg:SetAllPoints()
		powerBg:SetTexture(empath)
		powerBg:SetVertexColor(.05, .05, .05)
		powerBg.multiplier = 0.3

		local powerBorder = CreateFrame("Frame", nil, power)
		TukuiDB.CreateUFBorder(powerBorder, 1, 1, "TOPLEFT", 0, 0)
		powerBorder:SetAllPoints()

		name = TukuiDB.SetFontString(health, font, 12)
		name:SetPoint("CENTER", health, "CENTER", 0, 0)
		self:Tag(name, '[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]')
		self.Name = name

		health.frequentUpdates = true
		power.frequentUpdates = true
		if (Unitframes.showsmooth) then
			health.Smooth = true
			power.Smooth = true
		end
		if (Unitframes.classcolor) then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClass = true
			healthBg.multiplier = 0.3
			
			power.colorPower = true
			powerBg.multiplier = 0.4
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.15, .15, .15)
			
			power.colorTapping = true
			power.colorDisconnected = true
			power.colorClass = true
			power.colorReaction = true
		end
		
		self.Health = health
		self.Health.bg = healthBg
		self.Health.border = healthBorder

		self.Power = power
		self.Power.bg = powerBg
		self.Power.border = powerBorder
	end
	
	------------------------------------------------------------------------
	--	Maintank and Mainassist Layout
	------------------------------------------------------------------------

	if (self:GetParent():GetName():match"oUF_MainTank" or self:GetParent():GetName():match"oUF_MainAssist") then
		self:SetAttribute("initial-height", TukuiDB.Scale(28))
		self:SetAttribute("initial-width", TukuiDB.Scale(100))

		local health = CreateFrame("StatusBar", nil, self)
		health:SetHeight(TukuiDB.Scale(22))
		health:SetPoint("TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		health:SetPoint("TOPRIGHT", -TukuiDB.mult, TukuiDB.mult)
		health:SetStatusBarTexture(empath)

		local healthBg = health:CreateTexture(nil, "BORDER")
		healthBg:SetAllPoints()
		healthBg:SetTexture(empath)
		healthBg:SetVertexColor(.05, .05, .05)

		local healthBorder = CreateFrame("Frame", nil, health)
		TukuiDB.CreateUFBorder(healthBorder, 1, 1, "TOPLEFT", 0, 0)
		healthBorder:SetAllPoints()

		local power = CreateFrame("StatusBar", nil, self)
		power:SetHeight(TukuiDB.Scale(3))
		power:SetPoint("TOPLEFT", health, "BOTTOMLEFT", 0, -TukuiDB.mult)
		power:SetPoint("TOPRIGHT", health, "BOTTOMRIGHT", 0, -TukuiDB.mult)
		power:SetStatusBarTexture(empath)

		local powerBg = power:CreateTexture(nil, "BORDER")
		powerBg:SetAllPoints()
		powerBg:SetTexture(empath)
		powerBg:SetVertexColor(.05, .05, .05)
		powerBg.multiplier = 0.3

		local powerBorder = CreateFrame("Frame", nil, power)
		TukuiDB.CreateUFBorder(powerBorder, 1, 1, "TOPLEFT", 0, 0)
		powerBorder:SetAllPoints()

		local name = TukuiDB.SetFontString(health, font, 12)
		name:SetPoint("CENTER", health, "CENTER", 0, 0)
		self:Tag(name, '[Tukui:getnamecolor][Tukui:nameshort]')
		self.Name = name

		health.frequentUpdates = true
		power.frequentUpdates = true
		if (Unitframes.showsmooth) then
			health.Smooth = true
			power.Smooth = true
		end
		if (Unitframes.classcolor) then
			health.colorTapping = true
			health.colorDisconnected = true
			health.colorReaction = true
			health.colorClass = true
			healthBg.multiplier = 0.3
			
			power.colorPower = true
			powerBg.multiplier = 0.4
		else
			health.colorTapping = false
			health.colorDisconnected = false
			health.colorClass = false
			health:SetStatusBarColor(.15, .15, .15)
			
			power.colorTapping = true
			power.colorDisconnected = true
			power.colorClass = true
			power.colorReaction = true
		end
		
		self.Health = health
		self.Health.bg = healthBg
		self.Health.border = healthBorder

		self.Power = power
		self.Power.bg = powerBg
		self.Power.border = powerBorder
	end

	------------------------------------------------------------------------
	--	Features we want for all units at the same time
	------------------------------------------------------------------------
	
	-- here we create an invisible frame for all element we want to show over health/power.
	-- because we can only use self here, and self is under all elements.
	local InvFrame = CreateFrame("Frame", nil, self)
	InvFrame:SetFrameStrata("HIGH")
	InvFrame:SetFrameLevel(5)
	InvFrame:SetAllPoints()
	
	-- symbols, now put the symbol on the frame we created above.
	local RaidIcon = InvFrame:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetHeight(14)
	RaidIcon:SetWidth(14)
	RaidIcon:SetPoint("TOP", 0, 8)
	self.RaidIcon = RaidIcon
	
	return self
end

------------------------------------------------------------------------
--	Default position of Tukui unitframes
------------------------------------------------------------------------

-- for lower reso
local adjustXY = 0
local totdebuffs = 0
if TukuiDB.lowversion then adjustXY = 24 end
if Unitframes.totdebuffs then totdebuffs = 24 end

oUF:RegisterStyle('Tukz', Shared)
oUF:SetActiveStyle('Tukz')

if Unitframes.healermode then
	oUF:Spawn("player", "oUF_Tukz_player"):SetPoint("BOTTOM", TukuiDataBottom, "TOP", -TukuiDB.Scale(300), TukuiDB.Scale(167)) -- 281
	oUF:Spawn("target", "oUF_Tukz_target"):SetPoint("BOTTOM", TukuiDataBottom, "TOP", TukuiDB.Scale(300), TukuiDB.Scale(167))
elseif not Unitframes.charportrait then
	oUF:Spawn("player", "oUF_Tukz_player"):SetPoint("BOTTOM", TukuiDataBottom, "TOP", -TukuiDB.Scale(205), TukuiDB.Scale(167))
	oUF:Spawn("target", "oUF_Tukz_target"):SetPoint("BOTTOM", TukuiDataBottom, "TOP", TukuiDB.Scale(205), TukuiDB.Scale(167))
else
	oUF:Spawn("player", "oUF_Tukz_player"):SetPoint("BOTTOM", TukuiDataBottom, "TOP", -TukuiDB.Scale(180), TukuiDB.Scale(167))
	oUF:Spawn("target", "oUF_Tukz_target"):SetPoint("BOTTOM", TukuiDataBottom, "TOP", TukuiDB.Scale(180), TukuiDB.Scale(167))
end

if Unitframes.charportrait then
	oUF:Spawn("targettarget", "oUF_Tukz_targettarget"):SetPoint("TOPRIGHT", oUF_Tukz_target, "BOTTOMRIGHT", TukuiDB.Scale(63), -TukuiDB.Scale(25))
else
	oUF:Spawn("targettarget", "oUF_Tukz_targettarget"):SetPoint("TOPRIGHT", oUF_Tukz_target, "BOTTOMRIGHT", 0, -TukuiDB.Scale(25))
end

if Unitframes.charportrait then
	oUF:Spawn("pet", "oUF_Tukz_pet"):SetPoint("BOTTOMLEFT", oUF_Tukz_player, "TOPLEFT", -TukuiDB.Scale(63), TukuiDB.Scale(3))
else
	oUF:Spawn("pet", "oUF_Tukz_pet"):SetPoint("TOPRIGHT", oUF_Tukz_player, "TOPLEFT", -TukuiDB.Scale(3), 0)
end

if Unitframes.charportrait then
	oUF:Spawn("focus", "oUF_Tukz_focus"):SetPoint("TOPLEFT", oUF_Tukz_player, "BOTTOMLEFT", -TukuiDB.Scale(63), -TukuiDB.Scale(25))
else
	oUF:Spawn("focus", "oUF_Tukz_focus"):SetPoint("TOPLEFT", oUF_Tukz_player, "BOTTOMLEFT", 0, -TukuiDB.Scale(25))
end

if Unitframes.showfocustarget then 
	if Unitframes.healermode or not Unitframes.charportrait then
		oUF:Spawn("focustarget", "oUF_Tukz_focustarget"):SetPoint("TOPLEFT", oUF_Tukz_focus, "TOPRIGHT", TukuiDB.Scale(3), 0)
	else
		oUF:Spawn("focustarget", "oUF_Tukz_focustarget"):SetPoint("TOPLEFT", oUF_Tukz_focus, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
	end
end


if not IsAddOnLoaded("Gladius") then
	local arena = {}
	for i = 1, 5 do
		arena[i] = oUF:Spawn("arena"..i, "oUF_Arena"..i)
		if i == 1 then
			arena[i]:SetPoint("TOP", UIParent, "BOTTOM", TukuiDB.Scale(380), TukuiDB.Scale(550))
		else
			arena[i]:SetPoint("TOP", arena[i-1], "BOTTOM", 0, TukuiDB.Scale(-28))
		end
	end
end

if not IsAddOnLoaded("DXE") then
	for i = 1,MAX_BOSS_FRAMES do
		local t_boss = _G["Boss"..i.."TargetFrame"]
		t_boss:UnregisterAllEvents()
		t_boss.Show = TukuiDB.dummy
		t_boss:Hide()
		_G["Boss"..i.."TargetFrame".."HealthBar"]:UnregisterAllEvents()
		_G["Boss"..i.."TargetFrame".."ManaBar"]:UnregisterAllEvents()
	end

	local boss = {}
	for i = 1, MAX_BOSS_FRAMES do
		boss[i] = oUF:Spawn("boss"..i, "oUF_Boss"..i)
		if i == 1 then
			boss[i]:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		else
			boss[i]:SetPoint('BOTTOM', boss[i-1], 'TOP', 0, 10)             
		end
	end
end

if Unitframes.maintank then
	local tank = oUF:SpawnHeader("oUF_MainTank", nil, 'raid, party, solo', 
		"showRaid", true, "groupFilter", "MAINTANK", "yOffset", 3, "point" , "BOTTOM",
		"template", "oUF_tukzMtt"
	)
	tank:SetPoint("TOPLEFT", UIParent, 14, -300)
end

if Unitframes.mainassist then
	local assist = oUF:SpawnHeader("oUF_MainAssist", nil, 'raid, party, solo', 
		"showRaid", true, "groupFilter", "MAINASSIST", "yOffset", 5, "point" , "BOTTOM",
		"template", "oUF_tukzMtt"
	)
	assist:SetPoint("TOPLEFT", UIParent, 14, -400)
end

local party = oUF:SpawnHeader("oUF_noParty", nil, "showParty", false)

------------------------------------------------------------------------
--	Just a command to test buffs/debuffs alignment
------------------------------------------------------------------------

local testui = TestUI or function() end
TestUI = function()
	testui()
	UnitAura = function()
		-- name, rank, texture, count, dtype, duration, timeLeft, caster
		return 'penancelol', 'Rank 2', 'Interface\\Icons\\Spell_Holy_Penance', random(5), 'Magic', 0, 0, "player"
	end
	if(oUF) then
		for i, v in pairs(oUF.units) do
			if(v.UNIT_AURA) then
				v:UNIT_AURA("UNIT_AURA", v.unit)
			end
		end
	end
end
SlashCmdList.TestUI = TestUI
SLASH_TestUI1 = "/testui"

------------------------------------------------------------------------
--	Right-Click on unit frames menu.
------------------------------------------------------------------------

do
	UnitPopupMenus["SELF"] = { "PVP_FLAG", "LOOT_METHOD", "LOOT_THRESHOLD", "OPT_OUT_LOOT_TITLE", "LOOT_PROMOTE", "DUNGEON_DIFFICULTY", "RAID_DIFFICULTY", "RESET_INSTANCES", "RAID_TARGET_ICON", "LEAVE", "CANCEL" };
	UnitPopupMenus["PET"] = { "PET_PAPERDOLL", "PET_RENAME", "PET_ABANDON", "PET_DISMISS", "CANCEL" };
	UnitPopupMenus["PARTY"] = { "MUTE", "UNMUTE", "PARTY_SILENCE", "PARTY_UNSILENCE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "PROMOTE", "PROMOTE_GUIDE", "LOOT_PROMOTE", "VOTE_TO_KICK", "UNINVITE", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["PLAYER"] = { "WHISPER", "INSPECT", "INVITE", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["RAID_PLAYER"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "WHISPER", "INSPECT", "ACHIEVEMENTS", "TRADE", "FOLLOW", "DUEL", "RAID_TARGET_ICON", "RAID_LEADER", "RAID_PROMOTE", "RAID_DEMOTE", "LOOT_PROMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "RAF_SUMMON", "RAF_GRANT_LEVEL", "CANCEL" }
	UnitPopupMenus["RAID"] = { "MUTE", "UNMUTE", "RAID_SILENCE", "RAID_UNSILENCE", "BATTLEGROUND_SILENCE", "BATTLEGROUND_UNSILENCE", "RAID_LEADER", "RAID_PROMOTE", "RAID_MAINTANK", "RAID_MAINASSIST", "LOOT_PROMOTE", "RAID_DEMOTE", "RAID_REMOVE", "PVP_REPORT_AFK", "CANCEL" }
	UnitPopupMenus["VEHICLE"] = { "RAID_TARGET_ICON", "VEHICLE_LEAVE", "CANCEL" }
	UnitPopupMenus["TARGET"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["ARENAENEMY"] = { "CANCEL" }
	UnitPopupMenus["FOCUS"] = { "RAID_TARGET_ICON", "CANCEL" }
	UnitPopupMenus["BOSS"] = { "RAID_TARGET_ICON", "CANCEL" }
end

