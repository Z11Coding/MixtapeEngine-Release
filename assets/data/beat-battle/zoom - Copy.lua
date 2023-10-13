function onCreatePost()
	luaDebugMode = false

	initLuaShader("zoom")
	makeLuaSprite("zoom")
	makeGraphic("zoom", screenWidth, screenHeight)
	setSpriteShader("zoom", "zoom")
	
	initLuaShader("barrel")
	makeLuaSprite("barrel")
	makeGraphic("barrel", screenWidth, screenHeight)
	setSpriteShader("barrel", "barrel")
	
	addHaxeLibrary("ShaderFilter", "openfl.filters")
	runHaxeCode([[
		game.camGame.setFilters([new ShaderFilter(game.getLuaObject("zoom").shader)]);
		game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("zoom").shader), new ShaderFilter(game.getLuaObject("barrel").shader)]);
		game.camOther.setFilters([new ShaderFilter(game.getLuaObject("zoom").shader), new ShaderFilter(game.getLuaObject("barrel").shader)]);
	]])

	setShaderFloat('barrel', 'chromaticIntensity', '0')
	--setShaderFloatArray('barrel', 'offset', {'0', '0'})
	setShaderFloat('barrel', 'angle', '0')
	setShaderBool('barrel', 'mirrorX', true)
	setShaderBool('barrel', 'mirrorY', true)
	setShaderFloat('barrel', 'zoom', '1.0')

	addBlankMod('multiScreenOffX', 0)
	addBlankMod('multiScreenOffY', 0)
	addBlankMod('multiScreenScale', 1)
	addBlankMod('multiScreenRot', 0)
	addBlankMod('distortionIntensity', 0)
end

function onSongStart()
	queueEase(130, 140, 'multiScreenRot', 360, 'elasticOut', -1, getValue('multiScreenRot'))
	queueEase(130, 140, 'multiScreenOffX', 0, 'elasticOut', -1, getValue('multiScreenOffX'))
	queueEase(130, 140, 'multiScreenOffY', 0, 'elasticOut', -1, getValue('multiScreenOffY'))
	queueEase(127, 138, 'distortionIntensity', 2, 'sineIn', -1, getValue('distortionIntensity'))
	queueEase(138, 140, 'distortionIntensity', 0, 'elasticInOut', -1, getValue('distortionIntensity'))
	queueEase(127, 133, 'multiScreenScale', 2, 'elasticInOut', -1, getValue('multiScreenScale'))
	queueEase(135, 140, 'multiScreenScale', 1, 'BounceInOut', -1, getValue('multiScreenScale'))
	queueEase(188, 189, 'distortionIntensity', -2, 'sineIn', -1, getValue('distortionIntensity'))
	queueEase(190, 191, 'distortionIntensity', 0, 'elasticOut', -1, getValue('distortionIntensity'))
	queueEase(764, 768, 'receptorScroll', 1, 'quadInOut', -1, getValue('receptorScroll'))
	queueEase(1120, 1136, 'infinite', 1, 'quadInOut', -1, getValue('infinite'))
end

time = 0
function onUpdatePost(elapsed)
	time = time + elapsed
	setShaderFloatArray("zoom", "renderOffset", {getValue('multiScreenOffX'), getValue('multiScreenOffY')})
	--setShaderFloatArray("barrel", "offset", {getValue('multiScreenOffX'), getValue('multiScreenOffY')})
	setShaderFloat("barrel", "distortionIntensity", getValue('distortionIntensity'))
	setShaderFloatArray("zoom", "renderScale", {getValue('multiScreenScale'), getValue('multiScreenScale')})
    --setShaderFloat("zoom", "renderRot", getValue('multiScreenRot'))
	setShaderFloat("barrel", "angle", (getValue('multiScreenRot')))
	if getValue('rotateX') > 0 then
		setValue('rotateX', getValue('rotateX') - 1)
	end
	if getValue('rotateX') < 0 then
		setValue('rotateX', getValue('rotateX') + 1)
	end
	if getValue('rotateY') > 0 then
		setValue('rotateY', getValue('rotateY') - 1)
	end
	if getValue('rotateY') < 0 then
		setValue('rotateY', getValue('rotateY') + 1)
	end
	if getValue('rotateZ') > 0 then
		setValue('rotateZ', getValue('rotateZ') - 1)
	end
	if getValue('rotateZ') < 0 then
		setValue('rotateZ', getValue('rotateZ') + 1)
	end
	if getValue('stretch') > 0 then
		setValue('stretch', getValue('stretch') - 0.1)
	end
	if getValue('squish') > 0 then
		setValue('squish', getValue('squish') - 0.1)
	end
	if getValue('tornado') > 0 then
		setValue('tornado', getValue('tornado') - 0.001)
	end
	if getValue('tornado') < 0 then
		setValue('tornado', getValue('tornado') + 0.001)
	end
end

function onBeatHit()
	--setValue('multiScreenOff', getValue('multiScreenOff') +0.1)
	if curBeat % 16 == 7 then
		queueEase(daStep, daStep+8, 'multiScreenOffX', getValue('multiScreenOffX') + 0.99999, 'elasticOut', -1, getValue('multiScreenOff'))
		queueEase(daStep, daStep+12, 'distortionIntensity', getValue('distortionIntensity')-0.1, 'elasticOut', -1, getValue('distortionIntensity'))
		if curBeat > 64 then
			queueEase(daStep, daStep+12, 'invert', 1, 'elasticOut', -1, getValue('invert'))
		end
		if curBeat > 128 then
			queueEase(daStep, daStep+12, 'opponentSwap', 1, 'elasticOut', -1, getValue('opponentSwap'))
		end
		if curBeat > 192 then
			queueEase(daStep, daStep+12, 'sawtooth', 1, 'elasticOut', -1, getValue('sawtooth'))
		end
	end
	if curBeat % 16 == 15 then
		queueEase(daStep, daStep+8, 'multiScreenOffY', getValue('multiScreenOffY') + 0.99999, 'elasticOut', -1, getValue('multiScreenOff'))
		queueEase(daStep, daStep+12, 'distortionIntensity', getValue('distortionIntensity')+0.1, 'elasticOut', -1, getValue('distortionIntensity'))
		if curBeat > 64 then
			queueEase(daStep, daStep+12, 'invert', 0, 'elasticOut', -1, getValue('invert'))
		end
		if curBeat > 128 then
			queueEase(daStep, daStep+12, 'opponentSwap', 0, 'elasticOut', -1, getValue('opponentSwap'))
		end
		if curBeat > 192 then
			queueEase(daStep, daStep+12, 'sawtooth', 0, 'elasticOut', -1, getValue('sawtooth'))
		end
	end
	if curBeat % 32 == 15 then
		queueEase(daStep, daStep+8, 'multiScreenRot', getValue('multiScreenRot') + 180, 'elasticOut', -1, getValue('multiScreenRot'))
	end
	if curBeat % 32 == 31 then
		queueEase(daStep, daStep+8, 'multiScreenRot', getValue('multiScreenRot') + 180, 'elasticOut', -1, getValue('multiScreenRot'))
	end
	if curBeat % 2 == 0 then
		queueEase(daStep, daStep+1, 'rotateX', 20, 'quadInOut', -1, getValue('rotateX'))
		queueEase(daStep, daStep+1, 'rotateY', 20, 'quadInOut', -1, getValue('rotateY'))
		queueEase(daStep, daStep+1, 'rotateZ', 20, 'quadInOut', -1, getValue('rotateZ'))
		queueEase(daStep, daStep+1, 'tornado', 0.01, 'quadInOut', -1, getValue('tornado'))
		queueEase(daStep, daStep+1, 'stretch', 0.5, 'quadInOut', -1, getValue('stretch'))
	end
	if curBeat % 2 == 1 then
		queueEase(daStep, daStep+1, 'rotateX', -20, 'quadInOut', -1, getValue('rotateX'))
		queueEase(daStep, daStep+1, 'rotateY', -20, 'quadInOut', -1, getValue('rotateY'))
		queueEase(daStep, daStep+1, 'rotateZ', -20, 'quadInOut', -1, getValue('rotateZ'))
		queueEase(daStep, daStep+1, 'squish', 0.5, 'quadInOut', -1, getValue('squish'))
		queueEase(daStep, daStep+1, 'tornado', -0.01, 'quadInOut', -1, getValue('tornado'))
	end
end

--[[function opponentNoteHit(a,b,c,d)
	if b == 0 then
		queueEase(daStep, daStep+0.2, 'multiScreenOffX', getValue('multiScreenOffX') + 1, 'quadInOut', -1, getValue('multiScreenOffX'))
	end
	if b == 1 then
		queueEase(daStep, daStep+0.2, 'multiScreenOffY', getValue('multiScreenOffY') + 1, 'quadInOut', -1, getValue('multiScreenOffY'))
	end
	if b == 2 then
		queueEase(daStep, daStep+0.2, 'multiScreenOffY', getValue('multiScreenOffY') - 1, 'quadInOut', -1, getValue('multiScreenOffY'))
	end
	if b == 3 then
		queueEase(daStep, daStep+0.2, 'multiScreenOffX', getValue('multiScreenOffX') - 1, 'quadInOut', -1, getValue('multiScreenOffX'))
	end
end]]

function onStepHit()
	daStep = curStep 
end