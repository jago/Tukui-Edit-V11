TukuiCF["General"] = {
	["autoscale"] = true, 							-- Auto-scale the UI?
	["uiscale"] = 0.71, 								-- If no auto-scale, set your own scale here
	["overridelowtohigh"] = false, 			-- Allows you to use high resolution setup on low resolution
	["multisampleprotect"] = true, 				-- Forces multisample to 1x
}	

TukuiCF["Others"] = {
	["spincam"] = true, 								-- Nah, you don't want to disable this :)!
	["pvpautorelease"] = true,					-- I'm not even gonna..
}

TukuiCF["Actionbars"] = {
	["enable"] = true, 								-- Yeah...
	
	["buttonsize"] = 26, 							-- Size of your buttons?
	["stancesize"] = 24,							-- Size of your stance bar buttons?
	["petsize"] = 26, 									-- Size of your pet bar buttons?! :D
	["buttonspacing"] = 3,							-- Spacing inbetween all buttons, yes I'm lazy
	
	["bottomrows"] = 2, 							-- Number of actionbars at the bottom
	["rightbars"] = 1,	 								-- Number of right action bars
	["splitbar"] = true, 								-- Takes a right bar and splits it around the bottom actionbars, this is cool
	["verticalrightbars"] = false, 				-- What can I say? Up or down? Whatever floats your boat
	
	["hotkey"] = false, 								-- Show your hotkeys?
	["showgrid"] = true, 							-- Show the panel/grid of empty buttons
	
	["rightbarmouseover"] = false, 			-- Mouse over on right action bars
	["shapeshiftmouseover"] = false,		-- Mouse over on shapeshift/stance bars
	["hideshapeshift"] = false, 					-- Hide shapeshift/stance bars
}	

TukuiCF["Arena"] = {
	["enable"] = true, 								-- Enable Tukui arena frames
}

TukuiCF["Bags"] = {
	["enable"] = true, 								-- Enable Tukui bags
	["soulbag"] = true, 								-- Show your soul bag? No one plays a Warlock... ;)
}

TukuiCF["BuffReminder"] = {
	["enable"] = true, 								-- Heey! You forgot to buff yourself!
	["warningsound"] = false, 					-- NOT ADDED YET -- It's going to annoy the shit out of you
}

TukuiCF["Chat"] = {
	["enable"] = true, 								-- Enable Tukui chat
	["justifyright"] = false, 						-- Justify your right chatframe text to the ugh, right hand side...? Really? Wow
	
	["font"] = TukuiCF["Fonts"].font,			-- Change the chat font!
}

TukuiCF["Classtimers"] = {
	["enable"] = true, 								-- Enable Tukui classtimers
	["icons"] = true, 									-- Enable icons
	["classcolored"] = false, 					-- Class colored bars?
}

TukuiCF["Cooldown"] = {
	["enable"] = false, 								-- Enable cooldown timer on actionbars
}

TukuiCF["Datatext"] = {
	["armor"] = 1,
	["arp"] = 2, 
	["avoidance"] = 3, 
	["bags"] = 4, 
	["crit"] = 0, 
	["durability"] = 0, 
	["fps"] = 7, 
	["friends"] = 8, 
	["gold"] = 9, 
	["guild"] = 10, 
	["haste"] = 11, 
	["memory"] = 12, 
	["power"] = 13, 
	["wowtime"] = 14, 
	["tracker"] = 5, 
	["wintergrasp"] = 6, 
	
	["localtime"] = true,								-- Don't you own a clock?
	["time24"] = true,									-- I'm not normal
	["font"] = TukuiCF["Fonts"].font,			-- Change the datatext font!
	["fontsize"] = 12,									-- And the font size?! RIDICULOUS!
}

TukuiCF["Error"] = {
	["enable"] = true,									-- Enable Tukui errors
}

TukuiCF["ExpRepBar"] = {
	["enable"] = true,									-- Enable my exp and rep bar addon, it's integrated!
	["shortvalues"] = true,							-- Short values? Admit it, you like small things
	["lowlevelshowrep"] = true,				-- Maybe you want to see rep while leveling? That's cool
}

TukuiCF["Invite"] = {
	["autoaccept"] = true, 							-- Auto accept invites from friends/guildies 
}

TukuiCF["Loot"] = {
	["lootframe"] = true,								-- Skin lootframe like Tukui
	["lootrollframe"] = true,						-- Tukui lootroll frame!
	["autogreed"] = true,							-- Hey cool, autogreed!
}

TukuiCF["Map"] = {
	["enable"] = true,									-- Enable Tukui map
}	

TukuiCF["Merchant"] = {
	["enable"] = true,									-- Merchant crap
}

TukuiCF["Nameplates"] = {
	["enable"] = true, 								-- Enable Tukui nameplates!
}

TukuiCF["Panels"] = {
	["infowidth"] = 370, 							-- Size of some panels...maybe :P
	["infoheight"] = 20, 								-- Height of some panels?!
	["shadows"] = true, 							-- Do you want to turn off shadows? :(
}

TukuiCF["Tooltip"] = {
	["enable"] = true,									-- Enable Tukui tooltip
	["cursor"] = false, 								-- Tooltips on yo cursor, sup?
	["hideuf"] = false,								-- Hide unitframe tooltips?
	["hidecombat"] = false,						-- Hide tooltips in combat?
	["hidebuttons"] = false,						-- Hide tooltips from actionbar buttons?
}

TukuiCF["Unitframes"] = {
	["enable"] = true, 								-- Oh come on you should've worked this out by now...
	["healermode"] = false, 						-- EXPERIMENTAL -- Really, a lot asked for this so I'm testing it out
	
	["unitcastbar"] = true, 							-- Enable Tukui castbars
	["cblatency"] = true, 							-- Got latency?
	["cbicons"] = true, 								-- Like icons?
	["cbinside"] = false, 							-- Different castbar style, inside the unitframes!
	
	["auratimer"] = true, 							-- Auras! I choose you!
	["auraspiral"] = true,							-- Want that spiral thing on your auras?
	["auratextscale"] = 11,						-- Aura timer text size...
	
	["playerauras"] = false, 						-- Do you really need this?
	["targetauras"] = true, 						-- This is tré cool
	
	["highThreshold"] = 80, 						-- High threshold for low mana warning..
	["lowThreshold"] = 20, 						-- Low threshold for...oh wait
	
	["targetpowerpvponly"] = false, 		-- Show power values on pvp targets only
	
	["totdebuffs"] = true, 							-- ToT debuffs
	["focusdebuffs"] = false, 					-- Focus debuffs
	["playerdebuffsonly"] = false, 			-- Player-Debuffs-Only, really?
	
	["showfocustarget"] = false, 				-- You really need this, don't you?
	["showtotalhpmp"] = false, 				-- Other text style
	["showsmooth"] = true, 						-- Smooth bars are cool
	["showthreat"] = true, 						--
	
	["charportrait"] = true, 						-- I CAN HAZ SEE MY CHARAKTERZ?!
	
	["combatfeedback"] = false, 				-- Add combat text to your unitframes
	["classcolor"] = false, 						-- This is so bad, don't enable!
	["playeraggro"] = false,						-- 
	
	["ws_show_player"] = true,				-- Show weakened soul debuff on player
	["ws_show_target"] = true,				-- Show weakened soul debuff on target?
	

	["runebar"] = true, 								-- Enable deathknight rune bar!
	["totembar"] = true, 								-- Enable shaman totem bar!
	
	
	["showplayerinparty"] = true, 			-- Tunnel vision healers :D
	["showsymbols"] = true,						-- Ooooo pretty!!
	["aggro"] = true,									-- Shows aggro warnings on group/raid frames!
	["raidgroups"] = 5, 								-- How many raid groups would you like to see?
	
	["positionbychar"] = false, 					-- Position unitframes by character....
	
	["showrange"] = true,							-- Want your frames to fade in/out depending on range? That's cool
	["ooralpha"] = 0.5, 								-- Change the alpha value of it!
	
	["debuffhighlight"] = true, 					-- Enable debuff highlight for group/raid frames
	["debuff_filter"] = false, 						-- Want to filter your debuffs for class only?
	
	["aurawatch"] = true, 							-- Enable aurawatch! That's those little icons and the debuff, you know what I'm talking about
	["auraspiral"] = true, 							-- Want cool spirals on them!?
	["auradebuff"] = false, 						-- Don't want to see the debuff? No problem, turn it off!
		
	["showboss"] = true, 							-- NEEDS TESTING -- Show boss frames
	["maintank"] = true,								-- Show main tank frames
	["mainassist"] = true, 							-- Show main assist frames
}