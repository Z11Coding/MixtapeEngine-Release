--[[
Description.
説明

lowQuality
で遊ぶと色のエフェクトが一色に統一されます
逆に使っていないと
BFとDADのカラーが参照されます

practiceモードでやるとlowQuality設定が無視され
リハーサルモードが適応されます
点滅が光らずカメラもズームアウトし、固定されます

lowQuality
the color effects are unified to one color
On the other hand, if you don't use it.
BF and DAD colors are referenced

If you do it in practice mode, the lowQuality setting is ignored and
Rehearsal mode is applied
The flashing light will not light up and the camera will zoom out and remain fixed.

最後に、フラッシュライトが苦手な方は
当MODを避けてくれると嬉しいです。
Finally, if you don't like flashlights
I hope you will avoid our mod.
]]
function onCreate()

	makeLuaSprite('clubback', 'background/club/clubback', 0, 0);
	scaleObject('clubback', 1.5, 1.5);
	setProperty('clubback.antialiasing', false);
	setObjectOrder('clubback', 1);

	makeLuaSprite('fix', 'background/club/clubback', 0, 0);
	scaleObject('fix', 1.5, 1.5);
	setProperty('fix.antialiasing', false);
	setObjectOrder('fix', 2);
	setProperty('fix.color', getColorFromHex('000000'))
	setProperty('fix.alpha', 0.5)

	makeLuaSprite('club', 'background/club/club', 0, 0);
	scaleObject('club', 1.5, 1.5);
	setScrollFactor('club', 1, 1);
	setProperty('club.antialiasing', false);
	setObjectOrder('club', 3);

	setScrollFactor('gfGroup', 1, 1);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 4);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 5);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 6);

	makeLuaSprite('blend', 'background/club/clubback', 0, 0);
	scaleObject('blend', 1.5, 1.5);
	setProperty('blend.antialiasing', false);
	setObjectOrder('blend', 7);
	setProperty('blend.alpha', 0.5)
	setBlendMode('blend','Add')
	--ver2 add point
	makeAnimatedLuaSprite('framebeat', 'background/club/anime_framebeat', 0, 0);
	addAnimationByPrefix('framebeat', 'beat', 'beat', 24, false);
	setProperty('framebeat.antialiasing', false);
	setObjectOrder('framebeat', 10);
	setProperty('framebeat.alpha', 0.0)
	setObjectCamera('framebeat', 'hud')
	--ver2 add point kokomade
	setProperty('clubback.color', getColorFromHex('000000'))
	setProperty('blend.color', getColorFromHex('000000'))
	if practice then
		--リハーサルモード rehearsalmode
		setProperty("defaultCamZoom",0.5)
		--cameraFade('other',getColorFromHex('000000'),5)
	end
end
--[[
function onCreatePost()

	local bfColor = getProperty("boyfriend.healthColorArray")
    local bfColorHex = rgbToHex(bfColor[1], bfColor[2], bfColor[3])

    local dadColor = getProperty("dad.healthColorArray")
    local dadColorHex = rgbToHex(dadColor[1], dadColor[2], dadColor[3])

end
]]
function rgbToHex(r,g,b)
    local rgb = (r * 0x10000) + (g * 0x100) + b
    return string.format("%x", rgb)
end
function onUpdate(elapsed)
	if practice then
		--リハーサルモード rehearsalmode
		triggerEvent('Camera Follow Pos',1920,1080)
		setProperty("defaultCamZoom",0.5)
		setProperty('clubback.color', getColorFromHex('000000'))
		setProperty('blend.alpha', 0)
	end

	bfColor = getProperty("boyfriend.healthColorArray")
	bfColorHex = rgbToHex(bfColor[1], bfColor[2], bfColor[3])

	dadColor = getProperty("dad.healthColorArray")
	dadColorHex = rgbToHex(dadColor[1], dadColor[2], dadColor[3])
end

function onSongStart()
	runTimer('eventtime',2,1)
end

function onBeatHit()
	--lowQualityがオンであるかつpracticeがオンだと作動します
	if not lowQuality and not practice then
		if FOCUS == true and not FOCUS == false then--カメラがBFに向いてるとき
			--debugPrint('1')
			setProperty('clubback.color', getColorFromHex(bfColorHex))
			doTweenColor('clubbackTween1', 'clubback', '000000', 1, 'ExpoOut')

			--setProperty('blend.color', getColorFromHex(bfColorHex))
			--doTweenColor('blendTween1', 'blend', '000000', 1, 'ExpoOut')

			setProperty('boyfriend.color', getColorFromHex(bfColorHex))
			doTweenColor('boyfriendTween', 'boyfriend', 'FFFFFF', 1, 'ExpoOut')
	
			setProperty('gf.color', getColorFromHex(bfColorHex))
			doTweenColor('gfTween', 'gf', 'FFFFFF', 1, 'ExpoOut')
	
			setProperty('dad.color', getColorFromHex(bfColorHex))
			doTweenColor('dadTween', 'dad', 'FFFFFF', 1, 'ExpoOut')
			--ver2 add point
			setProperty('framebeat.color', getColorFromHex(bfColorHex))
			--ver2 add point kokomade
		elseif FOCUS == false and not FOCUS == true then--カメラがBF以外にに向いてるとき
			--debugPrint('2')
			setProperty('clubback.color', getColorFromHex(dadColorHex))
			doTweenColor('clubbackTween2', 'clubback', '000000', 1, 'ExpoOut')

			--setProperty('blend.color', getColorFromHex(dadColorHex))
			--doTweenColor('blendTween2', 'blend', '000000', 1, 'ExpoOut')

			setProperty('boyfriend.color', getColorFromHex(dadColorHex))
			doTweenColor('boyfriendTween', 'boyfriend', 'FFFFFF', 1, 'ExpoOut')
	
			setProperty('gf.color', getColorFromHex(dadColorHex))
			doTweenColor('gfTween', 'gf', 'FFFFFF', 1, 'ExpoOut')
	
			setProperty('dad.color', getColorFromHex(dadColorHex))
			doTweenColor('dadTween', 'dad', 'FFFFFF', 1, 'ExpoOut')
			--ver2 add point
			setProperty('framebeat.color', getColorFromHex(dadColorHex))
			--ver2 add point kokomade
		end
		--ver2 add point
		playAnim('framebeat','beat',true)
		setProperty('framebeat.alpha', 0.75)
		--ver2 add point kokomade
	end
	
	--lowQualityがオンであるかつpracticeがオフだと作動します
	if lowQuality and not practice then
		setProperty('clubback.color', getColorFromHex('3300FF'))
		doTweenColor('clubbackTween', 'clubback', '000000', 1, 'ExpoOut')

		--setProperty('blend.color', getColorFromHex('3300FF'))
		--doTweenColor('blendTween', 'blend', '000000', 1, 'ExpoOut')

		setProperty('boyfriend.color', getColorFromHex('3300FF'))
		doTweenColor('boyfriendTween', 'boyfriend', 'FFFFFF', 1, 'ExpoOut')

		setProperty('gf.color', getColorFromHex('3300FF'))
		doTweenColor('gfTween', 'gf', 'FFFFFF', 1, 'ExpoOut')

		setProperty('dad.color', getColorFromHex('3300FF'))
		doTweenColor('dadTween', 'dad', 'FFFFFF', 1, 'ExpoOut')
		--ver2 add point
		setProperty('framebeat.color', getColorFromHex('3300FF'))
		setProperty('framebeat.alpha', 0.75)
		playAnim('framebeat','beat',true)
		--ver2 add point kokomade
	end
end
function onTweenCompleted(tag)
    if tag == 'zoomtw' then
        doTweenZoom('zoomtw2','camGame',getProperty('defaultCamZoom'),crochet/1000,'expoInOut')
        doTweenAlpha('alphatw2','camHUD',1,crochet/1000,'expoInOut')
        setProperty('camGame.angle',0)
    end
end
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'eventtime' then
        function onBeatHit()
            if curBeat %2 == 0 then
                setProperty('camGame.angle',2)
                setProperty('camHUD.angle',2)
                doTweenAngle('beatangle1','camGame',0,crochet/1000,'expoInOut')
                doTweenAngle('beatangle11','camHUD',0,crochet/1000,'expoInOut')
            end
        
        end
    end

end
function onTweenCompleted(tag)
    if tag == 'beatangle1' then
        setProperty('camGame.angle',-2)
        setProperty('camHUD.angle',-2)
        doTweenAngle('beatangle2','camGame',0,crochet/1000/2,'expoInOut')
        doTweenAngle('beatangle22','camHUD',0,crochet/1000,'expoInOut')
    elseif tag == 'zoomtw' then
        doTweenAlpha('alphatween2','camHUD',1,crochet/1000,'expoInOut')
        doTweenZoom('zoomtw2','camGame',getProperty('defaultCamZoom'),crochet/1000,'expoInOut')
        setProperty('camGame.angle',0)
    end

end
function onMoveCamera(focus)
	if focus == 'boyfriend' then
		FOCUS = true
		--debugPrint('1Go!')
	else
		FOCUS = false
		--debugPrint('2Go!')
	end
end

--if focus == 'dad' then