--Created By RamenDominoes (https://gamebanana.com/members/2135195)
--If you use this please credit me yo (pretty good for an amatuer if i say so myself)
--Thanks for using <3



--incase you want to move the gradient png to a folder or something
--if you fuck it up the script will function as normal, don't worry
local gradientDirectory = 'Gradient'

------------------------------------------------------------------------------
--I wouldn't mess with anything below here unless you know what you're doin'--
------------------------------------------------------------------------------


--all the color shit
local paletteColors = {
	Default = {'FED636','1FFEB2','FF2BB2','FE3636','9F2121'},
	Malke = {'FF0040','863D53','4E425F','5E5E5E','420707'},
	Funkin_Logo = {'FFFFFF','FF3FAC','AC77CC','3841BB','2321C5'},
	Funkin_Menu = {'E1E1E1','FDE871','FD719B','9271FD','5C29FD'},
	Etterna = {'99CCFF','14CC8F','FF1AB3','E67617','CC2929'},
	Kade_Engine = {'00FDFD','00FD00','FD0000','8A0000','570000'},
	Camellia = {'D65F57','F7FD5B','006DFD','FD7607','570000'},
	FNB = {'2BCEFF','44FF30','FFF238','6501B6','FF0000'},
	Pastel = {'9BF6FF','CAFFBF','FDFFB6','FFC6FF','A0C4FF'},
	CMYKW = {'FFFFFF','FFFF00','00FFFF','FF00FF','190033'},
	Sunrise = {'FFBE0B','FB5607','FF006E','8338EC','3A86FF'},
	Sunset = {'4CC9F0','4361EE','3A0CA3','7209B7','F72585'},
	Rainbow = {'FFCA3A','8AC926','FF595E','1982C4','6A4C93'}
}
local paletteQuotes = {
	Default = '"Made by yours truly."\n-RamenDominoes',
	Malke = '"Mommy kinky..."\n-Malke',
	Funkin_Logo = "There are two shades of blue, I'm sorry.",
	Funkin_Menu = 'There is a random 5th color, I failed you.',
	Etterna = 'Play Etterna!!!',
	Kade_Engine = 'Our founding father.',
	Camellia = 'Our founding child.',
	FNB = 'Funky Friday kinda mid smh.',
	Pastel = 'For the white women out there.',
	CMYKW = 'I lied, there is no black.',
	Sunrise = 'A personal favorite.',
	Sunset = 'Like Sunrise, but cooler. (literally)',
	Rainbow = 'I LOVE gay people!!!'
}
local paletteLinks = {
	Default = 'https://gamebanana.com/members/2135195',
	Malke = 'https://gamebanana.com/members/2149015',
	Funkin_Logo = nil,
	Funkin_Menu = nil,
	Etterna = nil,
	Kade_Engine = nil,
	Camellia = nil,
	FNB = nil,
	Pastel = nil,
	CMYKW = nil,
	Sunrise = nil,
	Sunset = nil,
	Rainbow = nil
}

--for the scrolling function
local listOfPalettes = {'Default','Malke','Funkin_Logo','Funkin_Menu','Etterna','Kade_Engine','Camellia','FNB','Pastel','CMYKW','Sunrise','Sunset','Rainbow'}
local allowPaletteScroll = true
local paletteSelection = ''
local curPaletteSelected = 1
--shows the options screen
local allowCountdown = false
local showOptionsScreen = true
local allowConfirmation = false


--results screen stuff
local openedSubstate = false --for allowing the menu music to play upon week completion
local allowSongEnd = false
local curCombo = 0
local maxCombo = 0
local curNPS = 0
local maxNPS = 0
local tick = 0
local mean = 0
local accuracy = 0
local noteCount = 0 --trust the process bru



--for the selection screen
function onCreate()

	initSaveData('SelectedPalette')

	showOptionsScreen = getDataFromSave('SelectedPalette', 'showOptions?')
	paletteSelection = getDataFromSave('SelectedPalette', 'colorPalette?')

	debugPrint('Color Palette Active: '..string.gsub(getDataFromSave('SelectedPalette', 'colorPalette?'), '_', ' '))

	if showOptionsScreen then

		playMusic('breakfast', 0, true)
		musicFadeIn(5, 0, 0.4)

		--for the bg
		luaGraphic('optionsBGWhite', 0, 0, screenWidth, screenHeight, 'FFFFFF', 'other')
		luaGraphic('optionsBGBlack', 10, 10, 1260, 700, '000000', 'other')

		--text for the screen
		luaText('hintText', '(To re-enter this screen, press [F1] on your keyboard.)', screenWidth, 0, 30, 30, 2, '000000', 'FFFFFF', 'center', 'other')
			setProperty('hintText.alpha', 0.4)
		luaText('selectedPaletteText', 'Select a Color Palette.', screenWidth, 0, 70, 60, 3, '000000', 'FFFFFF', 'center', 'other')
		luaText('navText', '(Navigate using the arrow keys.)', screenWidth, 15, 675, 25, 2, '000000', 'FFFFFF', 'left', 'other')
		setProperty('navText.alpha', 0.4)

		luaText('linkText', '(Press [ENTER] to view the link.)', screenWidth, 0, 512, 20, 1, '000000', 'FFFFFF', 'center', 'other')
			setProperty('linkText.alpha', 0.4)
		luaText('leftText', '<', 60, 340, 0, 60, 3, '000000', 'FFFFFF', 'center', 'other')
			screenCenter('leftText', 'y')
		luaText('rightText', '>', 60, 880, 0, 60, 3, '000000', 'FFFFFF', 'center', 'other')
			screenCenter('rightText', 'y')

		--color palette
		luaGraphic('colorPaletteBG', 0, 0, 430, 275, 'FFFFFF', 'other')
			screenCenter('colorPaletteBG', 'xy')
		luaBox('colorPaletteBoxA', getProperty('colorPaletteBG.x')+5, 0, 80, 265, 1, '000000', 'FFFFFF', 1, 'other', 'y')
		luaBox('colorPaletteBoxB', getProperty('colorPaletteBoxA1.x')+85, 0, 80, 265, 1, '000000', 'FFFFFF', 1, 'other', 'y')
		luaBox('colorPaletteBoxC', getProperty('colorPaletteBoxB1.x')+85, 0, 80, 265, 1, '000000', 'FFFFFF', 1, 'other', 'y')
		luaBox('colorPaletteBoxD', getProperty('colorPaletteBoxC1.x')+85, 0, 80, 265, 1, '000000', 'FFFFFF', 1, 'other', 'y')
		luaBox('colorPaletteBoxE', getProperty('colorPaletteBoxD1.x')+85, 0, 80, 265, 1, '000000', 'FFFFFF', 1, 'other', 'y')

		luaBox('paletteLabel', 0, getProperty('colorPaletteBG.y')+235, 430, 40, 5, 'FFFFFF', '000000', 0.8, 'other', 'x')
		luaText('paletteSick', 'Sick', 80, getProperty('colorPaletteBoxA1.x')-1, getProperty('paletteLabel1.y')+8, 20, 1, '000000', 'FFFFFF', 'center', 'other')
		luaText('paletteGood', 'Good', 80, getProperty('colorPaletteBoxB1.x')-1, getProperty('paletteLabel1.y')+8, 20, 1, '000000', 'FFFFFF', 'center', 'other')
		luaText('paletteBad', 'Bad', 80, getProperty('colorPaletteBoxC1.x')-1, getProperty('paletteLabel1.y')+8, 20, 1, '000000', 'FFFFFF', 'center', 'other')
		luaText('paletteShit', 'Shit', 80, getProperty('colorPaletteBoxD1.x')-1, getProperty('paletteLabel1.y')+8, 20, 1, '000000', 'FFFFFF', 'center', 'other')
		luaText('paletteMiss', 'Miss', 80, getProperty('colorPaletteBoxE1.x')-1, getProperty('paletteLabel1.y')+8, 20, 1, '000000', 'FFFFFF', 'center', 'other')

		luaText('colorPaletteName', 'If you can see this, oopsies!', screenWidth, 0, getProperty('colorPaletteBG.y')-60, 40, 2, '000000', 'FFFFFF', 'center', 'other')
		luaText('colorPaletteDesc', 'If you can see this, oopsies!\nIf you can see this, oopsies!\nIf you can see this, oopsies!', screenWidth, 0, getProperty('colorPaletteBG.y')+320, 30, 2, '000000', 'FFFFFF', 'center', 'other')
		--confirm button
		luaGraphic('confirmBGWhite', 0, 640, 220, 80, 'FFFFFF', 'other')
			screenCenter('confirmBGWhite', 'x')
		luaGraphic('confirmBGBlack', 0, 650, 200, 60, '000000', 'other')
			screenCenter('confirmBGBlack', 'x')
			luaText('confirmText', 'CONFIRM', screenWidth-3, 0, 660, 40, 2, '000000', 'FFFFFF', 'center', 'other')
			luaText('confirmNav', 'Press [ENTER] to confirm selection.', screenWidth, -13, 678, 20, 1, '000000', 'FFFFFF', 'right', 'other')
				setProperty('confirmNav.alpha', 0.4)

			function onUpdatePost()
			--selects the color
			paletteSelection = listOfPalettes[curPaletteSelected]

			--for the color scrolling
			if flixelKeyPress('LEFT') and allowPaletteScroll then
				doTweenX('leftTextScaleX', 'leftText.scale', 0.8, 0.1, 'linear')
				doTweenY('leftTextScaleY', 'leftText.scale', 0.8, 0.1, 'linear')
				changeItem(-1)
			elseif flixelKeyPress('RIGHT') and allowPaletteScroll then
				doTweenX('rightTextScaleX', 'rightText.scale', 0.8, 0.1, 'linear')
				doTweenY('rightTextScaleY', 'rightText.scale', 0.8, 0.1, 'linear')
				changeItem(1)
			end

			--for the confirmation
			if flixelKeyPress('DOWN') and allowPaletteScroll then
				playSound('scrollMenu', 0.4)
				allowPaletteScroll = false
				allowConfirmation = true
			elseif flixelKeyPress('UP') and allowConfirmation then
				playSound('scrollMenu', 0.4)
				allowConfirmation = false
				allowPaletteScroll = true
			end

			if flixelKeyPress('ENTER') and allowConfirmation then
				playSound('confirmMenu', 0.4)
				setDataFromSave('SelectedPalette', 'showOptions?', false)
				setDataFromSave('SelectedPalette', 'colorPalette?', paletteSelection)
				flushSaveData('SelectedPalette')
				restartSong()
			end

			--text stuff
			setTextString('colorPaletteName', string.gsub(paletteSelection, '_', ' '))
			setTextString('colorPaletteDesc', paletteQuotes[paletteSelection])
			if allowPaletteScroll then
				setProperty('colorPaletteName.alpha', 1)
				setProperty('colorPaletteDesc.alpha', 1)
			else
				setProperty('colorPaletteName.alpha', 0.4)
				setProperty('colorPaletteDesc.alpha', 0.4)
			end
			if allowConfirmation then
				setProperty('confirmText.alpha', 1)
				setProperty('confirmNav.visible', true)
			else
				setProperty('confirmText.alpha', 0.4)
				setProperty('confirmNav.visible', false)
			end

			--color stuff
			setProperty('colorPaletteBoxA1.color', getColorFromHex(paletteColors[paletteSelection][1]))
			setProperty('colorPaletteBoxB1.color', getColorFromHex(paletteColors[paletteSelection][2]))
			setProperty('colorPaletteBoxC1.color', getColorFromHex(paletteColors[paletteSelection][3]))
			setProperty('colorPaletteBoxD1.color', getColorFromHex(paletteColors[paletteSelection][4]))
			setProperty('colorPaletteBoxE1.color', getColorFromHex(paletteColors[paletteSelection][5]))

			--for the custom links
			if paletteLinks[paletteSelection] ~= nil and allowPaletteScroll then
				setProperty("linkText.visible", true)
				if flixelKeyPress('ENTER') then
					os.execute("start "..paletteLinks[paletteSelection])
				end
			else
				setProperty("linkText.visible", false)
			end
		end
		--for button pressin
		function onTweenCompleted(tag)
			if tag == 'leftTextScaleX' then
				setProperty('leftText.scale.x', 1)
				setProperty('leftText.scale.y', 1)
			elseif tag == 'rightTextScaleX' then
				setProperty('rightText.scale.x', 1)
				setProperty('rightText.scale.y', 1)
			end
		end
		--stops Countdown
		function onStartCountdown()
			if not allowCountdown then
				return Function_Stop
			end
			if allowCountdown then
				return Function_Continue
			end
		end
	end
end



--all the technical shit
function onCreatePost()
	if not botPlay then
		setProperty('scoreTxt.text', 'Score: 0 | NPS: 0 (0) | Combo: 0 (0) | Misses: 0 | Rating: ?')
		setProperty('scoreTxt.size', 16)
	elseif botPlay then --they are probably testing shit if they got botplay on
		setProperty('scoreTxt.text', 'NPS: 0 (0) | Combo: 0 (0)')
	end

	if not downscroll then
		luaText('curHitTime', '', 200, 0, 200, 35, 2, 'FFFFFF', '000000', 'center', 'HUD')
			setProperty('curHitTime.alpha', 0)
	elseif downscroll then
		luaText('curHitTime', '', 200, 0, 500, 35, 2, 'FFFFFF', '000000', 'center', 'HUD')
			setProperty('curHitTime.alpha', 0)
	end

	function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)

		local time = (getPropertyFromClass('Conductor', 'songPosition')/songLength)*100
		local strumTime = getPropertyFromGroup('notes', membersIndex, 'strumTime')
		local songPosition = getPropertyFromClass('Conductor', 'songPosition')
		local playerOffset = getPropertyFromClass('ClientPrefs','ratingOffset')
		local rawMilliseconds = strumTime - songPosition + playerOffset
		local simpleMilliseconds = roundNumber(rawMilliseconds, 2)
		local simpleMilliseconds = -(simpleMilliseconds)
		--for accuracy (idk if there's an easier way lol)
		accuracy = roundNumber((rating*100), 2)

		if not isSustainNote then
			mean = mean + simpleMilliseconds
			curCombo = curCombo + 1
			curNPS = curNPS + 1
			noteCount = noteCount + 1
			if curCombo > maxCombo then
				maxCombo = maxCombo + 1
			end
			if curNPS > maxNPS then
				maxNPS = maxNPS + 1
			end

			--for the Hit Times
			cancelTween('curHitTimeFade')
			setProperty('curHitTime.alpha', 1)
			setTextString('curHitTime', simpleMilliseconds..'ms')
			runTimer('curHitTimeFadeTimer', 0.5)

			--makes the little dots in the graph and changes the hit time text color too
			if math.abs(simpleMilliseconds) <= 45 then
				setTextColor('curHitTime', paletteColors[paletteSelection][1])
				luaGraphic(noteCount, 700+(roundNumber(time,2)*4.85), 549-(simpleMilliseconds/2.19), 3, 3, paletteColors[paletteSelection][1], 'Other')
					setObjectOrder(noteCount, 100)
					setProperty(noteCount..'.visible',false)
			elseif math.abs(simpleMilliseconds) <= 90 then
				setTextColor('curHitTime', paletteColors[paletteSelection][2])
				luaGraphic(noteCount, 700+(roundNumber(time,2)*4.85), 549-(simpleMilliseconds/2.19), 3, 3, paletteColors[paletteSelection][2], 'Other')
					setObjectOrder(noteCount, 100)
					setProperty(noteCount..'.visible',false)
			elseif math.abs(simpleMilliseconds) <= 135 then
				setTextColor('curHitTime', paletteColors[paletteSelection][3])
				luaGraphic(noteCount, 700+(roundNumber(time,2)*4.85), 549-(simpleMilliseconds/2.19), 3, 3, paletteColors[paletteSelection][3], 'Other')
					setObjectOrder(noteCount, 100)
					setProperty(noteCount..'.visible',false)
			else
				setTextColor('curHitTime', paletteColors[paletteSelection][4])
				luaGraphic(noteCount, 700+(roundNumber(time,2)*4.85), 549-(simpleMilliseconds/2.19), 3, 3, paletteColors[paletteSelection][4], 'Other')
					setObjectOrder(noteCount, 100)
					setProperty(noteCount..'.visible',false)
			end
		end
		if not botPlay then
			setProperty('scoreTxt.text', 'Score: '..score..' | NPS: '..curNPS..' ('..maxNPS..') | Combo: '..curCombo..' ('..maxCombo..') | Misses: '..misses..' | Rating: '..ratingName..' ('..accuracy..'%) - '..ratingFC)
		elseif botPlay then
			setProperty('scoreTxt.text', 'NPS: '..curNPS..' ('..maxNPS..') | Combo: '..curCombo..' ('..maxCombo..')')
		end
	end
	function noteMiss(membersIndex, noteData, noteType, isSustainNote)
		local time = (getPropertyFromClass('Conductor', 'songPosition')/songLength)*100
		accuracy = roundNumber((rating*100), 2)
		curCombo = 0
		if not botPlay then
			setProperty('scoreTxt.text', 'Score: '..score..' | NPS: '..curNPS..' ('..maxNPS..') | Combo: '..curCombo..' ('..maxCombo..') | Misses: '..misses..' | Rating: '..ratingName..' ('..accuracy..'%) - '..ratingFC)
		elseif botPlay then
			setProperty('scoreTxt.text', 'NPS: '..curNPS..' ('..maxNPS..') | Combo: '..curCombo..' ('..maxCombo..')')
		end
		if not isSustainNote then
			mean = mean + 181 --lmao you fucking suck ass
			noteCount = noteCount + 1

			--makes the little dots in the graph and changes the hit time text color too
			luaGraphic(noteCount, 700+(roundNumber(time,2)*4.85), 465, 3, 3, paletteColors[paletteSelection][5], 'Other')
				setObjectOrder(noteCount, 100)
				setProperty(noteCount..'.visible',false)
		end
	end

	function onTimerCompleted(tag)
		if tag == 'curHitTimeFadeTimer' then
			doTweenAlpha('curHitTimeFade', 'curHitTime', 0, 0.5)
		end
	end
end

function onUpdate()
	if flixelKeyPress('F1') and not showOptions then
		debugPrint('The options screen will appear on the next loaded song.')
		setDataFromSave('SelectedPalette', 'showOptions?', true)
		flushSaveData('SelectedPalette')
	end
	--for the xPos of the hitTimeText
	setProperty('curHitTime.x', getPropertyFromGroup('playerStrums',1,'x')+10)

	--for NPS
	tick = tick + 1
	if tick%framerate == 0 then
		curNPS = 0
	end
end

--prevents song events from looping while in results screen
function onCustomSubstateCreate(Results)--for creating the assets

	--for allowing the menu music to play upon week completion
	openedSubstate = true

	--for the fancy "animations"
	local notesCounted = 0
	local sicksCounted = 0
	local goodsCounted = 0
	local badsCounted = 0
	local shitsCounted = 0
	local missesCounted = 0

	--it was a little cleaner like this
	local sicks = getProperty('sicks')
	local goods = getProperty('goods')
	local bads = getProperty('bads')
	local shits = getProperty('shits')

	--generic variables *yawns*
	local camera = 'other'
	local bfColor = RGBtoHex(getProperty('boyfriend.healthColorArray'))
	local dadColor = RGBtoHex(getProperty('dad.healthColorArray'))
	local pColor = 'FFFFFF'
	local sColor = '000000'

	local allowKeyPress = false
	allowSongEnd = true -- lets the script actually work

	--makes the menu feel nice lol
	playMusic('breakfast', 0, true)
	soundFadeIn(5, 0, 0.4)--WHY IS THIS DEPRECATED, WHATS THE ALTERNATIVE FUCK

	function onCustomSubstateCreatePost(Results)--for triggering tweens
		--starting tween
		luaGraphic('bg', 0, 0, 1, 1, pColor, camera)
			screenCenter('bg','xy')
		doTweenX('bgTweenXScale', 'bg.scale', screenWidth, 0.25, 'SineOut')

		function onCustomSubstateUpdate(Results)--for keyPresses
			if flixelKeyPress('SPACE') and allowKeyPress then
				allowKeyPress = false
				playSound('confirmMenu', 0.5)
				runTimer('endSongTimer', 2, 1)
				cameraFade(camera, sColor, 1.75)
				soundFadeIn(1.5, 0)
			end
		end
		function onTweenCompleted(tag)

			local tweenSpeed = 1.5

			--background tweens
			if tag == 'bgTweenXScale' then
				doTweenY('bgTweenYScale', 'bg.scale', screenHeight, 0.5, 'SineOut')
			elseif tag == 'bgTweenYScale' then
				luaSprite('topGrad', gradientDirectory, 0, -screenHeight, camera)
					setProperty('topGrad.flipY', true)
					setProperty('topGrad.color', getColorFromHex(bfColor))
				luaSprite('botGrad', gradientDirectory, 0, screenHeight, camera)
					setProperty('botGrad.alpha',0.8)
					setProperty('botGrad.color', getColorFromHex(dadColor))

				doTweenY('topGradTween', 'topGrad', 0, tweenSpeed, 'SineOut')
				doTweenY('botGradTween', 'botGrad', 0, tweenSpeed, 'SineOut')

				if getProperty('topGrad.width') ~= screenWidth or getProperty('botGrad.width') ~= screenWidth then

					cancelTween('topGradTween')
					cancelTween('botGradTween')
					removeLuaSprite('topGrad')
					removeLuaSprite('botGrad')

					luaGraphic('backupBG', 0, 0, screenWidth, screenHeight, dadColor, camera)
						setProperty('backupBG.alpha', 0)
					doTweenAlpha('backupBGAlphaTween', 'backupBG', 1, tweenSpeed)
				end

				luaBox('bgBorder', 0, 0, screenWidth, screenHeight, 10, pColor, sColor, 0, camera)
			end

			if tag == 'topGradTween' or tag == 'backupBGAlphaTween' then
				--Song name and difficulty tweens
				luaBox('boxA', 0, -100, 1100, 100, 10, pColor, sColor, 0.4, camera, 'x')
					luaText('boxAText', '"'..songName..'" ['..difficultyName..']', 1110, getProperty('boxA1.x'), -100, 40, 2, sColor, pColor, 'center', camera)
				doTweenY('boxATween', 'boxA1', 30, tweenSpeed, 'QuartOut')

				--Song Stats tweens
				luaBox('boxB1', -535, 145, 535, 460, 10, pColor, sColor, 0.4, camera)
				luaBox('boxB2', getProperty('boxB11.x')+57, getProperty('boxB11.y')+65, 420, 7, 2, pColor, sColor, 1, camera)

					if not botPlay then
						luaText('boxBTextA', 'Song Cleared!', 535, getProperty('boxB11.x'), getProperty('boxB11.y')+20, 40, 2, sColor, pColor, 'center', camera)
					elseif botPlay then
						luaText('boxBTextA', 'Botplay!', 535, getProperty('boxB11.x'), getProperty('boxB11.y')+20, 40, 2, sColor, pColor, 'center', camera)
					end
					luaText('boxBTextB', 'Score:\n\nAccuracy\n\nRating:\n\nTotal Hits:\n\nMax Combo:\n\nMax NPS:\n\nMean:', 420, getProperty('boxB21.x'), getProperty('boxB21.y')+18, 30, 2, sColor, pColor, 'left', camera)

					if not botPlay then
						luaText('boxBTextC', score..'\n\n'..accuracy..'%\n\n['..ratingFC..']\n\n'..hits..'/'..getProperty('totalPlayed')..'\n\n'..maxCombo..'\n\n'..maxNPS..'\n\n'..roundNumber(mean/noteCount,2)..'ms', 420, getProperty('boxB21.x'), getProperty('boxB21.y')+18, 30, 2, sColor, pColor, 'right', camera)
					elseif botPlay then
						luaText('boxBTextC', 'N/A\n\nN/A\n\nN/A\n\nN/A\n\n'..maxCombo..'\n\n'..maxNPS..'\n\n'..roundNumber(mean/noteCount,2)..'ms', 420, getProperty('boxB21.x'), getProperty('boxB21.y')+18, 30, 2, sColor, pColor, 'right', camera)
					end
				doTweenX('boxB1Tween', 'boxB11', 70, tweenSpeed, 'QuartOut')

				--Watermark/Hit Windows tweens
				luaBox('boxC', 37.5, 720, 600, 70, 10, pColor, sColor, 0.4, camera)
				--if you change the name i WILL kill you
				luaText('boxCText', 'Script by: RamenDominoes\n(Sick:45ms,Good:90ms,Bad:135ms)', 600, getProperty('boxC1.x'), getProperty('boxC1.y')+14, 20, 1, sColor, pColor, 'center', camera)
				doTweenY('boxCTween', 'boxC1', 620, tweenSpeed, 'QuartOut')

				--Judgements Bar Graph tweens
				luaBox('boxD', 1280, 145, 535, 280, 10, pColor, sColor, 0.4, camera)
				--Sicks Bar
				luaBox('boxDBarA', getProperty('boxD1.x')+81, getProperty('boxD1.y')+48, 80, 182, 1, sColor, 'BCBCBC', 1, camera)
					luaText('barATextA', 0, 80, getProperty('boxDBarA1.x'), getProperty('boxDBarA1.y')-30, 18, 1, sColor, pColor, 'center', camera)
					luaText('barATextB', 'Sicks', 80, getProperty('boxDBarA1.x'), getProperty('boxDBarA1.y')+190, 18, 1, sColor, pColor, 'center', camera)
					luaGraphic('boxDSicksBar', getProperty('boxDBarA1.x')+1, 375, 78, 1, paletteColors[paletteSelection][1], camera)
					luaText('SicksBarPercent', roundNumber(((sicks/noteCount)*100), 2)..'%', 78, getProperty('boxDSicksBar.x'), getProperty('boxDSicksBar.y')-10, 15, 1, sColor, pColor, 'center', camera)
						setProperty('SicksBarPercent.alpha', false)
				--Goods Bar
				luaBox('boxDBarB', getProperty('boxDBarA1.x')+85, getProperty('boxDBarA1.y'), 80, 182, 1, sColor, 'BCBCBC', 1, camera)
					luaText('barBTextA', 0, 80, getProperty('boxDBarB1.x'), getProperty('boxDBarB1.y')-30, 18, 1, sColor, pColor, 'center', camera)
					luaText('barBTextB', 'Goods', 80, getProperty('boxDBarB1.x'), getProperty('boxDBarB1.y')+190, 18, 1, sColor, pColor, 'center', camera)
					luaGraphic('boxDGoodsBar', getProperty('boxDBarB1.x')+1, 375, 78, 1, paletteColors[paletteSelection][2], camera)
					luaText('GoodsBarPercent', roundNumber(((goods/noteCount)*100), 2)..'%', 78, getProperty('boxDGoodsBar.x'), getProperty('boxDGoodsBar.y')-10, 15, 1, sColor, pColor, 'center', camera)
						setProperty('GoodsBarPercent.alpha', false)
				--Bads Bar
				luaBox('boxDBarC', getProperty('boxDBarB1.x')+85, getProperty('boxDBarA1.y'), 80, 182, 1, sColor, 'BCBCBC', 1, camera)
					luaText('barCTextA', 0, 80, getProperty('boxDBarC1.x'), getProperty('boxDBarC1.y')-30, 18, 1, sColor, pColor, 'center', camera)
					luaText('barCTextB', 'Bads', 80, getProperty('boxDBarC1.x'), getProperty('boxDBarC1.y')+190, 18, 1, sColor, pColor, 'center', camera)
					luaGraphic('boxDBadsBar', getProperty('boxDBarC1.x')+1, 375, 78, 1, paletteColors[paletteSelection][3], camera)
					luaText('BadsBarPercent', roundNumber(((bads/noteCount)*100), 2)..'%', 78, getProperty('boxDBadsBar.x'), getProperty('boxDBadsBar.y')-10, 15, 1, sColor, pColor, 'center', camera)
						setProperty('BadsBarPercent.alpha', false)
				--Shits Bar
				luaBox('boxDBarD', getProperty('boxDBarC1.x')+85, getProperty('boxDBarA1.y'), 80, 182, 1, sColor, 'BCBCBC', 1, camera)
					luaText('barDTextA', 0, 80, getProperty('boxDBarD1.x'), getProperty('boxDBarD1.y')-30, 18, 1, sColor, pColor, 'center', camera)
					luaText('barDTextB', 'Shits', 80, getProperty('boxDBarD1.x'), getProperty('boxDBarD1.y')+190, 18, 1, sColor, pColor, 'center', camera)
					luaGraphic('boxDShitsBar', getProperty('boxDBarD1.x')+1, 375, 78, 1, paletteColors[paletteSelection][4], camera)
					luaText('ShitsBarPercent', roundNumber(((shits/noteCount)*100), 2)..'%', 78, getProperty('boxDShitsBar.x'), getProperty('boxDShitsBar.y')-10, 15, 1, sColor, pColor, 'center', camera)
						setProperty('ShitsBarPercent.alpha', false)
				--Misses Bar
				luaBox('boxDBarE', getProperty('boxDBarD1.x')+85, getProperty('boxDBarA1.y'), 80, 182, 1, sColor, 'BCBCBC', 1, camera)
					luaText('barETextA', 0, 80, getProperty('boxDBarE1.x'), getProperty('boxDBarE1.y')-30, 18, 1, sColor, pColor, 'center', camera)
					luaText('barETextB', 'Misses', 80, getProperty('boxDBarE1.x'), getProperty('boxDBarE1.y')+190, 18, 1, sColor, pColor, 'center', camera)
					luaGraphic('boxDMissesBar', getProperty('boxDBarE1.x')+1, 375, 78, 1, paletteColors[paletteSelection][5], camera)
					luaText('MissesBarPercent', roundNumber(((misses/noteCount)*100), 2)..'%', 78, getProperty('boxDMissesBar.x'), getProperty('boxDMissesBar.y')-10, 15, 1, sColor, pColor, 'center', camera)
						setProperty('MissesBarPercent.alpha', false)
				--Graph Markings
				luaGraphic('boxDGraphicA', getProperty('boxDBarA1.x')-11, getProperty('boxDBarA1.y')+1, 1, 181, pColor, camera)
					luaGraphic('GraphicAMarkA', getProperty('boxDGraphicA.x')-8, getProperty('boxDGraphicA.y'), 17, 1, pColor, camera)
						luaText('GraphicATextA', '100%', 40, getProperty('GraphicAMarkA.x')-48, getProperty('GraphicAMarkA.y')-10, 16, 1, sColor, pColor, 'center', camera)
					luaGraphic('GraphicAMarkB', getProperty('boxDGraphicA.x')-8, getProperty('GraphicAMarkA.y')+45, 17, 1, pColor, camera)
						luaText('GraphicATextB', '75%', 40, getProperty('GraphicAMarkB.x')-48, getProperty('GraphicAMarkB.y')-10, 16, 1, sColor, pColor, 'center', camera)
					luaGraphic('GraphicAMarkC', getProperty('boxDGraphicA.x')-8, getProperty('GraphicAMarkB.y')+45, 17, 1, pColor, camera)
						luaText('GraphicATextC', '50%', 40, getProperty('GraphicAMarkC.x')-48, getProperty('GraphicAMarkC.y')-10, 16, 1, sColor, pColor, 'center', camera)
					luaGraphic('GraphicAMarkD', getProperty('boxDGraphicA.x')-8, getProperty('GraphicAMarkC.y')+45, 17, 1, pColor, camera)
						luaText('GraphicATextD', '25%', 40, getProperty('GraphicAMarkD.x')-48, getProperty('GraphicAMarkD.y')-10, 16, 1, sColor, pColor, 'center', camera)
					luaGraphic('GraphicAMarkE', getProperty('boxDGraphicA.x')-8, getProperty('GraphicAMarkD.y')+45, 17, 1, pColor, camera)
						luaText('GraphicATextE', '0%', 40, getProperty('GraphicAMarkE.x')-48, getProperty('GraphicAMarkE.y')-10, 16, 1, sColor, pColor, 'center', camera)
				luaGraphic('boxDGraphicB', getProperty('boxDGraphicA.x'), getProperty('boxDGraphicA.y')+180, 446, 5, pColor, camera)
				doTweenX('boxDTween', 'boxD1', 675, tweenSpeed, 'QuartOut')

				--Hit Timings Graph tweens
				luaGraphic('boxE1a', 1280, 440, 285, 250, sColor, camera)
					setProperty('boxE1a.alpha', 0.4)
				luaGraphic('boxE1b', getProperty('boxE1a.x')+285, getProperty('boxE1a.y'), 250, 250, sColor, camera)
					setProperty('boxE1b.alpha', 0.4)
				luaGraphic('boxE2', getProperty('boxE1a.x'), getProperty('boxE1a.y'), 10, 250, pColor, camera)--left
				luaGraphic('boxE3', getProperty('boxE1a.x'), getProperty('boxE1a.y'), 535, 10, pColor, camera)--top
				luaGraphic('boxE4', (getProperty('boxE1a.x')+535-10), getProperty('boxE1a.y'), 10, 250, pColor, camera)--right
				luaGraphic('boxE5', getProperty('boxE1a.x'), (getProperty('boxE1a.y')+250-10), 535, 10, pColor, camera)--bottom
					luaBox('boxEGraph', getProperty('boxE1a.x')+20, getProperty('boxE1a.y')+20, 495, 180, 5, pColor, sColor, 0.6, camera)
						luaText('boxETextA', 'Late(+180ms)', 495, getProperty('boxEGraph1.x')+5, getProperty('boxEGraph1.y')+4, 15, 1, sColor, pColor, 'left', camera)
							setProperty('boxETextA.alpha', 0.2)
						luaText('boxETextB', 'Early(-180ms)', 495, getProperty('boxEGraph1.x')+5, getProperty('boxEGraph1.y')+156, 15, 1, sColor, pColor, 'left', camera)
							setProperty('boxETextB.alpha', 0.2)
							luaGraphic('boxESick', getProperty('boxEGraph1.x')+5, getProperty('boxEGraph1.y')+90, 485, 1, paletteColors[paletteSelection][1], camera)
								setProperty('boxESick.alpha', 0.4)
							luaGraphic('boxEGoodEarly', getProperty('boxEGraph1.x')+5, getProperty('boxESick.y')-21, 485, 1, paletteColors[paletteSelection][2], camera)
								setProperty('boxEGoodEarly.alpha', 0.4)
							luaGraphic('boxEGoodLate', getProperty('boxEGraph1.x')+5, getProperty('boxESick.y')+21, 485, 1, paletteColors[paletteSelection][2], camera)
								setProperty('boxEGoodLate.alpha', 0.4)
							luaGraphic('boxEBadEarly', getProperty('boxEGraph1.x')+5, getProperty('boxEGoodEarly.y')-20.5, 485, 1, paletteColors[paletteSelection][3], camera)
								setProperty('boxEBadEarly.alpha', 0.4)
							luaGraphic('boxEBadLate', getProperty('boxEGraph1.x')+5, getProperty('boxEGoodLate.y')+20.5, 485, 1, paletteColors[paletteSelection][3], camera)
								setProperty('boxEBadLate.alpha', 0.4)
							luaGraphic('boxEShitEarly', getProperty('boxEGraph1.x')+5, getProperty('boxEBadEarly.y')-20.5, 485, 1, paletteColors[paletteSelection][4], camera)
								setProperty('boxEShitEarly.alpha', 0.4)
							luaGraphic('boxEShitLate', getProperty('boxEGraph1.x')+5, getProperty('boxEBadLate.y')+20.5, 485, 1, paletteColors[paletteSelection][4], camera)
								setProperty('boxEShitLate.alpha', 0.4)
				doTweenX('boxETween', 'boxE1a', 675, tweenSpeed, 'QuartOut')
			end

			--Exit Button Tween
			if tag == 'boxETween' then

				--for the bar graph "animations"
				doTweenY('sicksBarScaleTween', 'boxDSicksBar.scale', (180*(sicks/noteCount))+1, 1, 'QuartOut')
				doTweenY('sicksBarTween', 'boxDSicksBar', ((getProperty('boxDBarA1.y')+1)+180)-(180*(sicks/noteCount)), 1, 'QuartOut')
				runTimer('sicksCountTimer', 1/sicks, 1)
				doTweenAlpha('SicksBarPercentAlphaTween', 'SicksBarPercent', 1, 1)

				doTweenY('goodsBarScaleTween', 'boxDGoodsBar.scale', (180*(goods/noteCount))+1, 1, 'QuartOut')
				doTweenY('goodsBarTween', 'boxDGoodsBar', ((getProperty('boxDBarB1.y')+1)+180)-(180*(goods/noteCount)), 1, 'QuartOut')
				runTimer('goodsCountTimer', 1/goods, 1)
				doTweenAlpha('GoodsBarPercentAlphaTween', 'GoodsBarPercent', 1, 1)

				doTweenY('badsBarScaleTween', 'boxDBadsBar.scale', (180*(bads/noteCount))+1, 1, 'QuartOut')
				doTweenY('badsBarTween', 'boxDBadsBar', ((getProperty('boxDBarC1.y')+1)+180)-(180*(bads/noteCount)), 1, 'QuartOut')
				runTimer('badsCountTimer', 1/bads, 1)
				doTweenAlpha('BadsBarPercentAlphaTween', 'BadsBarPercent', 1, 1)

				doTweenY('shitsBarScaleTween', 'boxDShitsBar.scale', (180*(shits/noteCount))+1, 1, 'QuartOut')
				doTweenY('shitsBarTween', 'boxDShitsBar', ((getProperty('boxDBarD1.y')+1)+180)-(180*(shits/noteCount)), 1, 'QuartOut')
				runTimer('shitsCountTimer', 1/shits, 1)
				doTweenAlpha('ShitsBarPercentAlphaTween', 'ShitsBarPercent', 1, 1)

				doTweenY('missesBarScaleTween', 'boxDMissesBar.scale', (180*(misses/noteCount))+1, 1, 'QuartOut')
				doTweenY('missesBarTween', 'boxDMissesBar', ((getProperty('boxDBarE1.y')+1)+180)-(180*(misses/noteCount)), 1, 'QuartOut')
				runTimer('missesCountTimer', 1/misses, 1)
				doTweenAlpha('MissesBarPercentAlphaTween', 'MissesBarPercent', 1, 1)

				--show the hit times on the graph
				runTimer('showHitsTimer', 1/noteCount, 1)

				luaBox('boxF', 960, 720, 320, 70, 10, pColor, sColor, 0.4, camera)
					luaText('boxFText', "'SPACE' to Continue", 320, getProperty('boxF1.x'), getProperty('boxF1.y')+21, 25, 2, sColor, pColor, 'center', camera)
				doTweenY('boxFTween', 'boxF1', 650, 1, 'QuartOut')
				doTweenY('boxE1bTweenScale', 'boxE1b.scale', 0.88, 0.8, 'SineOut')
				doTweenY('boxE4TweenScale', 'boxE4.scale', 0.88, 0.8, 'SineOut')
			end

			--allows space to be press
			if tag == 'boxFTween' then
				allowKeyPress = true
			end
		end
		function onCustomSubstateUpdatePost(Results)--for tweens
			--I deserve this for wanting to make things pretty :(
			--The comically large wall of text lul

			--for the scale tweens
			updateHitbox('boxE1b')
			updateHitbox('boxE4')

			updateHitbox('boxDSicksBar')
			updateHitbox('boxDGoodsBar')
			updateHitbox('boxDBadsBar')
			updateHitbox('boxDShitsBar')
			updateHitbox('boxDMissesBar')

			--boxA tween shit
			setProperty('boxA2.y', getProperty('boxA1.y'))
			setProperty('boxA3.y', getProperty('boxA1.y'))
			setProperty('boxA4.y', getProperty('boxA1.y'))
			setProperty('boxA5.y', (getProperty('boxA1.y')+100)-10)
			setProperty('boxAText.y', getProperty('boxA1.y')+28)

			--boxB1 tween shit
			setProperty('boxB12.x', getProperty('boxB11.x'))
			setProperty('boxB13.x', getProperty('boxB11.x'))
			setProperty('boxB14.x', (getProperty('boxB11.x')+535-10))
			setProperty('boxB15.x', getProperty('boxB11.x'))
				setProperty('boxB21.x', getProperty('boxB11.x')+57)
				setProperty('boxB22.x', getProperty('boxB21.x'))
				setProperty('boxB23.x', getProperty('boxB21.x'))
				setProperty('boxB24.x', (getProperty('boxB21.x')+420)-2)
				setProperty('boxB25.x', getProperty('boxB21.x'))
			setProperty('boxBTextA.x', getProperty('boxB11.x'))
			setProperty('boxBTextB.x', getProperty('boxB21.x'))
			setProperty('boxBTextC.x', getProperty('boxB21.x'))

			--boxC tween Shit
			setProperty('boxC2.y', getProperty('boxC1.y'))
			setProperty('boxC3.y', getProperty('boxC1.y'))
			setProperty('boxC4.y', getProperty('boxC1.y'))
			setProperty('boxC5.y', (getProperty('boxC1.y')+70)-10)
			setProperty('boxCText.y', getProperty('boxC1.y')+14)

			--boxD tween shit
			setProperty('boxD2.x', getProperty('boxD1.x'))
			setProperty('boxD3.x', getProperty('boxD1.x'))
			setProperty('boxD4.x', (getProperty('boxD1.x')+535)-10)
			setProperty('boxD5.x', getProperty('boxD1.x'))
				--Sick Bar
				setProperty('boxDBarA1.x', getProperty('boxD1.x')+81)
				setProperty('boxDBarA2.x', getProperty('boxDBarA1.x'))
				setProperty('boxDBarA3.x', getProperty('boxDBarA1.x'))
				setProperty('boxDBarA4.x', (getProperty('boxDBarA1.x')+80)-1)
				setProperty('boxDBarA5.x', getProperty('boxDBarA1.x'))
					setProperty('barATextA.x', getProperty('boxDBarA1.x'))
					setProperty('barATextB.x', getProperty('boxDBarA1.x'))
					setProperty('boxDSicksBar.x', getProperty('boxDBarA1.x')+1)
					setProperty('SicksBarPercent.x', getProperty('boxDSicksBar.x'))
					setProperty('SicksBarPercent.y', getProperty('boxDSicksBar.y')-10)
				--Goods Bar
				setProperty('boxDBarB1.x', getProperty('boxDBarA1.x')+85)
				setProperty('boxDBarB2.x', getProperty('boxDBarA1.x')+85)
				setProperty('boxDBarB3.x', getProperty('boxDBarA1.x')+85)
				setProperty('boxDBarB4.x', ((getProperty('boxDBarA1.x')+85)+80)-1)
				setProperty('boxDBarB5.x', getProperty('boxDBarA1.x')+85)
					setProperty('barBTextA.x', getProperty('boxDBarB1.x'))
					setProperty('barBTextB.x', getProperty('boxDBarB1.x'))
					setProperty('boxDGoodsBar.x', getProperty('boxDBarB1.x')+1)
					setProperty('GoodsBarPercent.x', getProperty('boxDGoodsBar.x'))
					setProperty('GoodsBarPercent.y', getProperty('boxDGoodsBar.y')-10)
				--Bads Bar
				setProperty('boxDBarC1.x', getProperty('boxDBarB1.x')+85)
				setProperty('boxDBarC2.x', getProperty('boxDBarB1.x')+85)
				setProperty('boxDBarC3.x', getProperty('boxDBarB1.x')+85)
				setProperty('boxDBarC4.x', ((getProperty('boxDBarB1.x')+85)+80)-1)
				setProperty('boxDBarC5.x', getProperty('boxDBarB1.x')+85)
					setProperty('barCTextA.x', getProperty('boxDBarC1.x'))
					setProperty('barCTextB.x', getProperty('boxDBarC1.x'))
					setProperty('boxDBadsBar.x', getProperty('boxDBarC1.x')+1)
					setProperty('BadsBarPercent.x', getProperty('boxDBadsBar.x'))
					setProperty('BadsBarPercent.y', getProperty('boxDBadsBar.y')-10)
				--Shits Bar
				setProperty('boxDBarD1.x', getProperty('boxDBarC1.x')+85)
				setProperty('boxDBarD2.x', getProperty('boxDBarC1.x')+85)
				setProperty('boxDBarD3.x', getProperty('boxDBarC1.x')+85)
				setProperty('boxDBarD4.x', ((getProperty('boxDBarC1.x')+85)+80)-1)
				setProperty('boxDBarD5.x', getProperty('boxDBarC1.x')+85)
					setProperty('barDTextA.x', getProperty('boxDBarD1.x'))
					setProperty('barDTextB.x', getProperty('boxDBarD1.x'))
					setProperty('boxDShitsBar.x', getProperty('boxDBarD1.x')+1)
					setProperty('ShitsBarPercent.x', getProperty('boxDShitsBar.x'))
					setProperty('ShitsBarPercent.y', getProperty('boxDShitsBar.y')-10)
				--Misses Bar
				setProperty('boxDBarE1.x', getProperty('boxDBarD1.x')+85)
				setProperty('boxDBarE2.x', getProperty('boxDBarD1.x')+85)
				setProperty('boxDBarE3.x', getProperty('boxDBarD1.x')+85)
				setProperty('boxDBarE4.x', ((getProperty('boxDBarD1.x')+85)+80)-1)
				setProperty('boxDBarE5.x', getProperty('boxDBarD1.x')+85)
					setProperty('barETextA.x', getProperty('boxDBarE1.x'))
					setProperty('barETextB.x', getProperty('boxDBarE1.x'))
					setProperty('boxDMissesBar.x', getProperty('boxDBarE1.x')+1)
					setProperty('MissesBarPercent.x', getProperty('boxDMissesBar.x'))
					setProperty('MissesBarPercent.y', getProperty('boxDMissesBar.y')-10)

				--Graph Markings
				setProperty('boxDGraphicA.x', getProperty('boxDBarA1.x')-11)
					setProperty('GraphicAMarkA.x', getProperty('boxDGraphicA.x')-8)
						setProperty('GraphicATextA.x', getProperty('GraphicAMarkA.x')-48)
					setProperty('GraphicAMarkB.x', getProperty('boxDGraphicA.x')-8)
						setProperty('GraphicATextB.x', getProperty('GraphicAMarkB.x')-48)
					setProperty('GraphicAMarkC.x', getProperty('boxDGraphicA.x')-8)
						setProperty('GraphicATextC.x', getProperty('GraphicAMarkC.x')-48)
					setProperty('GraphicAMarkD.x', getProperty('boxDGraphicA.x')-8)
						setProperty('GraphicATextD.x', getProperty('GraphicAMarkD.x')-48)
					setProperty('GraphicAMarkE.x', getProperty('boxDGraphicA.x')-8)
						setProperty('GraphicATextE.x', getProperty('GraphicAMarkE.x')-48)
				setProperty('boxDGraphicB.x', getProperty('boxDGraphicA.x'))

			--boxE tween shit
			setProperty('boxE1b.x', getProperty('boxE1a.x')+285)
			setProperty('boxE2.x', getProperty('boxE1a.x'))
			setProperty('boxE3.x', getProperty('boxE1a.x'))
			setProperty('boxE4.x', (getProperty('boxE1a.x')+535-10))
			setProperty('boxE5.x', getProperty('boxE1a.x'))
				setProperty('boxEGraph1.x', getProperty('boxE1a.x')+20)
				setProperty('boxEGraph2.x', getProperty('boxEGraph1.x'))
				setProperty('boxEGraph3.x', getProperty('boxEGraph1.x'))
				setProperty('boxEGraph4.x', (getProperty('boxEGraph1.x')+495)-5)
				setProperty('boxEGraph5.x', getProperty('boxEGraph1.x'))
					setProperty('boxETextA.x', getProperty('boxEGraph1.x')+5)
					setProperty('boxETextB.x', getProperty('boxEGraph1.x')+5)
						setProperty('boxESick.x', getProperty('boxEGraph1.x')+5)
						setProperty('boxEGoodEarly.x', getProperty('boxEGraph1.x')+5)
						setProperty('boxEGoodLate.x', getProperty('boxEGraph1.x')+5)
						setProperty('boxEBadEarly.x', getProperty('boxEGraph1.x')+5)
						setProperty('boxEBadLate.x', getProperty('boxEGraph1.x')+5)
						setProperty('boxEShitEarly.x', getProperty('boxEGraph1.x')+5)
						setProperty('boxEShitLate.x', getProperty('boxEGraph1.x')+5)

			--boxF tween Shit
			setProperty('boxF2.y', getProperty('boxF1.y'))
			setProperty('boxF3.y', getProperty('boxF1.y'))
			setProperty('boxF4.y', getProperty('boxF1.y'))
			setProperty('boxF5.y', (getProperty('boxF1.y')+70)-10)
			setProperty('boxFText.y', getProperty('boxF1.y')+21)
			if getProperty('boxF1.y') <= 680 then
				makeGraphic('boxE5', 295, 10, pColor)
			end
		end
	end
	function onTimerCompleted(tag, loops, loopsLeft)
		if tag == 'endSongTimer' then
			closeCustomSubstate(Results)
		end

		--for the hit time graph
		if tag == 'showHitsTimer' and notesCounted ~= noteCount then
			notesCounted = notesCounted + 1
			runTimer('showHitsTimer', 1/noteCount, 1)
			for Numbers = 1, notesCounted do
				setProperty(Numbers..'.visible', true)
			end
		end

		--for the sicks bar graph
		if tag == 'sicksCountTimer' and sicksCounted ~= sicks then
			sicksCounted = sicksCounted + 1
			setTextString('barATextA', sicksCounted)
			runTimer('sicksCountTimer', 1/sicks, 1)
		end

		--for the goods bar graph
		if tag == 'goodsCountTimer' and goodsCounted ~= goods then
			goodsCounted = goodsCounted + 1
			setTextString('barBTextA', goodsCounted)
			runTimer('goodsCountTimer', 1/goods, 1)
		end

		--for the bads bar graph
		if tag == 'badsCountTimer' and badsCounted ~= bads then
			badsCounted = badsCounted + 1
			setTextString('barCTextA', badsCounted)
			runTimer('badsCountTimer', 1/bads, 1)
		end

		--for the shits bar graph
		if tag == 'shitsCountTimer' and shitsCounted ~= shits then
			shitsCounted = shitsCounted + 1
			setTextString('barDTextA', shitsCounted)
			runTimer('shitsCountTimer', 1/shits, 1)
		end

		--for the misses bar graph
		if tag == 'missesCountTimer' and missesCounted ~= misses then
			missesCounted = missesCounted + 1
			setTextString('barETextA', missesCounted)
			runTimer('missesCountTimer', 1/misses, 1)
		end
	end
	function onCustomSubstateDestroy(Results)--for ending the song
		endSong()
	end
end
function onEndSong()--blocks song from ending
	
	if not openedSubstate then
		openCustomSubstate(Results,true)
	end

	if not allowSongEnd then
        return Function_Stop
    end
    if allowSongEnd then
        return Function_Continue
    end
end


--Custom Functions
function flixelKeyPress(key)
	return getPropertyFromClass('flixel.FlxG', 'keys.justPressed.'..key)
end
function roundNumber(Int,shownDecimalPlaces)
	local mult = 10^(shownDecimalPlaces or 0)
	return math.floor(Int * mult + 0.5) / mult
end
function luaSprite(tag,image,xPos,yPos,camera)
	makeLuaSprite(tag, image, xPos, yPos)
	setObjectCamera(tag, camera)
	addLuaSprite(tag)
end
function luaGraphic(tag,xPos,yPos,width,height,color,camera)
	makeLuaSprite(tag, '', xPos, yPos)
	makeGraphic(tag, width, height, color)
	setObjectCamera(tag, camera)
	addLuaSprite(tag)
end
function changeItem(Int)--only works for this script, unless you change it
	playSound('scrollMenu', 0.4)
	curPaletteSelected = curPaletteSelected + Int
	if curPaletteSelected > #listOfPalettes then
		curPaletteSelected = 1
	elseif curPaletteSelected < 1 then
		curPaletteSelected = #listOfPalettes
	end
end
function luaText(tag,text,width,xPos,yPos,size,thickness,color1,color2,alignment,camera)
	makeLuaText(tag, text, width, xPos, yPos)
	setTextSize(tag, size)
	setTextColor(tag, color1)
	setTextBorder(tag, thickness, color2)
	setTextAlignment(tag, alignment)
	setObjectCamera(tag, camera)
	addLuaText(tag)
end
function RGBtoHex(RGB)
    LetterValues = 'ABCDEF'
    hex = ''
    for i = 1, 3 do
        Decimal1 = math.floor(RGB[i]/16)
        Decimal2 = ((RGB[i]/16)%1)*16

        hex = hex..(Decimal1 < 10 and tostring(Decimal1) or string.sub(LetterValues, Decimal1-9,Decimal1-9))
        hex = hex..(Decimal2 < 10 and tostring(Decimal2) or string.sub(LetterValues, Decimal2-9,Decimal2-9))
    end
    return hex
end
function luaBox(tag,xPos,yPos,width,height,thickness,color1,color2,alpha,camera,center)--lol
	if center == nil then
		luaGraphic(tag..'1', xPos, yPos, width, height, color2, camera)
			setProperty(tag..'1.alpha', alpha)
		luaGraphic(tag..'2', getProperty(tag..'1.x'), getProperty(tag..'1.y'), thickness, height, color1, camera)--left
		luaGraphic(tag..'3', getProperty(tag..'1.x'), getProperty(tag..'1.y'), width, thickness, color1, camera)--top
		luaGraphic(tag..'4', (getProperty(tag..'1.x')+width)-thickness, getProperty(tag..'1.y'), thickness, height, color1, camera)--right
		luaGraphic(tag..'5', getProperty(tag..'1.x'), (getProperty(tag..'1.y')+height)-thickness, width, thickness, color1, camera)--bottom
	elseif center == 'x' then
		luaGraphic(tag..'1', (screenWidth/2)-(width/2), yPos, width, height, color2, camera)
			setProperty(tag..'1.alpha', alpha)
		luaGraphic(tag..'2', getProperty(tag..'1.x'), getProperty(tag..'1.y'), thickness, height, color1, camera)--left
		luaGraphic(tag..'3', getProperty(tag..'1.x'), getProperty(tag..'1.y'), width, thickness, color1, camera)--top
		luaGraphic(tag..'4', (getProperty(tag..'1.x')+width)-thickness, getProperty(tag..'1.y'), thickness, height, color1, camera)--right
		luaGraphic(tag..'5', getProperty(tag..'1.x'), (getProperty(tag..'1.y')+height)-thickness, width, thickness, color1, camera)--bottom
	elseif center == 'y' then
		luaGraphic(tag..'1', xPos, (screenHeight/2)-(height/2), width, height, color2, camera)
			setProperty(tag..'1.alpha', alpha)
		luaGraphic(tag..'2', getProperty(tag..'1.x'), getProperty(tag..'1.y'), thickness, height, color1, camera)--left
		luaGraphic(tag..'3', getProperty(tag..'1.x'), getProperty(tag..'1.y'), width, thickness, color1, camera)--top
		luaGraphic(tag..'4', (getProperty(tag..'1.x')+width)-thickness, getProperty(tag..'1.y'), thickness, height, color1, camera)--right
		luaGraphic(tag..'5', getProperty(tag..'1.x'), (getProperty(tag..'1.y')+height)-thickness, width, thickness, color1, camera)--bottom
	elseif center == 'xy' then
		luaGraphic(tag..'1', (screenWidth/2)-(width/2), (screenHeight/2)-(height/2), width, height, color2, camera)
			setProperty(tag..'1.alpha', alpha)
		luaGraphic(tag..'2', getProperty(tag..'1.x'), getProperty(tag..'1.y'), thickness, height, color1, camera)--left
		luaGraphic(tag..'3', getProperty(tag..'1.x'), getProperty(tag..'1.y'), width, thickness, color1, camera)--top
		luaGraphic(tag..'4', (getProperty(tag..'1.x')+width)-thickness, getProperty(tag..'1.y'), thickness, height, color1, camera)--right
		luaGraphic(tag..'5', getProperty(tag..'1.x'), (getProperty(tag..'1.y')+height)-thickness, width, thickness, color1, camera)--bottom
	end
end