function onUpdate()
	if getProperty('boyfriend.curCharacter') == 'bev' then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bevdead'); --Character json file for the death animation
	end
	if getProperty('boyfriend.curCharacter') == 'bev-colors' then
		setPropertyFromClass('substates.GameOverSubstate', 'characterName', 'bevdead-colors'); --Character json file for the death animation
	end
end

