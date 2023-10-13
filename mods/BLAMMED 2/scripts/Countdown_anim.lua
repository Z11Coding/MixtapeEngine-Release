function onCountdownTick(counter)
	if counter == 0 then
		playAnim('boyfriend', '3', true)
	end  
	if counter == 1 then
		playAnim('boyfriend', '2', true)
	end
	if counter == 2 then
		playAnim('boyfriend', '1', true)
	end
	if counter == 3 then
		playAnim('boyfriend', 'hey', true)
	end
end
function onCreatePost()
    playAnim('boyfriend', '3', true)
        setProeprty('boyriend.specialAnim', true)
end