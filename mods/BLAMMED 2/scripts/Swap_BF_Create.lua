function onCreatePost()

	addCharacterToList('bev-colors', 'bf')
	addCharacterToList('bevdead-colors', 'bf')
end
function onUpdate()
	if getProperty('boyfriend.curCharacter') == 'bf' then
			triggerEvent('Change Character', 'bf', 'bev-colors')
	end
end

function onSongStart()
	if getProperty('boyfriend.curCharacter') == 'bf' then
			triggerEvent('Change Character', 'bf', 'bev-colors')
	end
end