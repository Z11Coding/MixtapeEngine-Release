local curBop = 0
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

	initLuaShader("grey")
	makeLuaSprite("grey")
	makeGraphic("grey", screenWidth, screenHeight)
	setSpriteShader("grey", "grey")
	
	addHaxeLibrary("ShaderFilter", "openfl.filters")
	runHaxeCode([[
		game.camGame.setFilters([new ShaderFilter(game.getLuaObject("zoom").shader), new ShaderFilter(game.getLuaObject("barrel").shader), new ShaderFilter(game.getLuaObject("grey").shader)]);
		game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("zoom").shader), new ShaderFilter(game.getLuaObject("barrel").shader), new ShaderFilter(game.getLuaObject("grey").shader)]);
		game.camOther.setFilters([new ShaderFilter(game.getLuaObject("zoom").shader), new ShaderFilter(game.getLuaObject("barrel").shader), new ShaderFilter(game.getLuaObject("grey").shader)]);
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
	addBlankMod('distortionIntensity',0)
	addBlankMod('chromaticIntensity', 0)
	addBlankMod('greyScale', 0)

	addBlankMod('noteAngle', 0)
end

function onSongStart()
	queueEase(6, 16, 'multiScreenScale', 2, 'sineInOut', -1, getValue('multiScreenScale'))
	queueEase(8, 16, 'distortionIntensity', -0.1, 'sineInOut', -1, getValue('distortionIntensity'))
	queueEase(8, 16, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))
	queueEase(16, 256, 'chromaticIntensity', getValue('chromaticIntensity') + 1, 'sineInOut', -1, getValue('chromaticIntensity'))
	queueEase(16, 256, 'multiScreenScale', 1, 'sineInOut', -1, getValue('multiScreenScale'))
	queueEase(16, 256, 'multiScreenOffX', -5, 'sineInOut', -1, getValue('multiScreenOffX'))
	queueEase(16, 256, 'multiScreenOffY', 5, 'sineInOut', -1, getValue('multiScreenOffY'))
	queueEase(256, 257, 'chromaticIntensity', 0, 'sineInOut', -1, getValue('chromaticIntensity'))
	queueEase(256, 257, 'distortionIntensity', -0.3, 'sineInOut', -1, getValue('distortionIntensity'))
	queueEase(256, 257, 'greyScale', -2, 'sineInOut', -1, getValue('greyScale'))
	queueEase(271, 272, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
	queueEase(271, 282, 'distortionIntensity', 0, 'elasticOut', -1, getValue('distortionIntensity'))
end

time = 0
function onUpdate(e)
	for i = 0, getProperty("strumLineNotes.length") - 1 do
		setPropertyFromGroup('strumLineNotes', i, 'angle', e)
	end
end
function onUpdatePost(elapsed)
	time = time + elapsed
	setShaderFloatArray("zoom", "renderOffset", {getValue('multiScreenOffX'), getValue('multiScreenOffY')})
	--setShaderFloatArray("barrel", "offset", {getValue('multiScreenOffX'), getValue('multiScreenOffY')})
	setShaderFloat("barrel", "distortionIntensity", getValue('distortionIntensity'))
	setShaderFloatArray("zoom", "renderScale", {getValue('multiScreenScale'), getValue('multiScreenScale')})
    --setShaderFloat("zoom", "renderRot", getValue('multiScreenRot'))
	setShaderFloat("barrel", "angle", (getValue('multiScreenRot')))
	setShaderFloat("grey", "strength", getValue('greyScale'))
	setShaderFloat('barrel', 'chromaticIntensity', getValue('chromaticIntensity'))
	if getValue('centerrotateX') > 0 then
		setValue('centerrotateX', getValue('centerrotateX') - 1)
	end
	if getValue('centerrotateX') < 0 then
		setValue('centerrotateX', getValue('centerrotateX') + 1)
	end
	if getValue('centerrotateY') > 0 then
		setValue('centerrotateY', getValue('centerrotateY') - 1)
	end
	if getValue('centerrotateY') < 0 then
		setValue('centerrotateY', getValue('centerrotateY') + 1)
	end
	if getValue('centerrotateZ') > 0 then
		setValue('centerrotateZ', getValue('centerrotateZ') - 1)
	end
	if getValue('centerrotateZ') < 0 then
		setValue('centerrotateZ', getValue('centerrotateZ') + 1)
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

function Bop()
	if curBop == 0 then
		curBop = 2
		setValue('cmode', getValue('cmod') - 1)
		queueEase(daStep, daStep+4, 'cmode', 0, 'quadInOut', -1, getValue('cmode'))
		setValue('greyScale', getValue('greyScale') - 1)
		queueEase(daStep, daStep+4, 'greyScale', 0, 'quadInOut', -1, getValue('greyScale'))
		queueEase(daStep, daStep+4, 'rotateZ', 15, 'quadInOut', -1, getValue('rotateX'))
		queueEase(daStep, daStep+0.2, 'centerrotateX', 20, 'quadInOut', -1, getValue('centerrotateX'))
		queueEase(daStep, daStep+0.2, 'centerrotateY', 20, 'quadInOut', -1, getValue('centerrotateY'))
		queueEase(daStep, daStep+0.2, 'centerrotateZ', 20, 'quadInOut', -1, getValue('centerrotateZ'))
		queueEase(daStep, daStep+0.2, 'tornado', 0.01, 'quadInOut', -1, getValue('tornado'))
		queueEase(daStep, daStep+0.2, 'stretch', 0.5, 'quadInOut', -1, getValue('stretch'))
		queueEase(daStep, daStep+0.2, 'noteAngle', 25, 'quadInOut', -1, getValue('noteAngle'))
	else if curBop == 2 then
		curBop = 0
		setValue('cmod', getValue('cmod') + 3)
		queueEase(daStep, daStep+4, 'cmod', 0, 'quadInOut', -1, getValue('cmod'))
		setValue('greyScale', getValue('greyScale') - 1)
		queueEase(daStep, daStep+4, 'greyScale', 0, 'quadInOut', -1, getValue('greyScale'))
		queueEase(daStep, daStep+4, 'rotateZ', -15, 'quadInOut', -1, getValue('rotateX'))
		queueEase(daStep, daStep+0.2, 'centerrotateX', -20, 'quadInOut', -1, getValue('centerrotateX'))
		queueEase(daStep, daStep+0.2, 'centerrotateY', -20, 'quadInOut', -1, getValue('centerrotateY'))
		queueEase(daStep, daStep+0.2, 'centerrotateZ', -20, 'quadInOut', -1, getValue('centerrotateZ'))
		queueEase(daStep, daStep+0.2, 'squish', 0.5, 'quadInOut', -1, getValue('squish'))
		queueEase(daStep, daStep+0.2, 'tornado', -0.01, 'quadInOut', -1, getValue('tornado'))
		queueEase(daStep, daStep+0.2, 'noteAngle', -25, 'quadInOut', -1, getValue('noteAngle'))
	end
	end
end

bopArray = {272, 292, 304, 316, 324, 336, 356, 368, 380, 388, 420, 432, 444, 452, 464, 484, 496, 508, 516, 528, 592, 600, 608, 616, 624, 628, 632, 636, 640, 644, 656, 676, 688, 700, 708, 720, 740, 752, 764, 772, 784, 804, 816, 828, 836, 848, 868, 880, 892, 912, 932, 944, 956, 964, 976, 996, 1008, 1020, 1028, 1060, 1072, 1084, 1092, 1104, 1124, 1136, 1148, 1156}

function onBeatHit()
	--setValue('multiScreenOff', getValue('multiScreenOff') +0.1)
	--[[if curBeat % 2 == 0 then
		queueEase(daStep, daStep+1, 'centerrotateX', 20, 'quadInOut', -1, getValue('centerrotateX'))
		queueEase(daStep, daStep+1, 'centerrotateY', 20, 'quadInOut', -1, getValue('centerrotateY'))
		queueEase(daStep, daStep+1, 'centerrotateZ', 20, 'quadInOut', -1, getValue('centerrotateZ'))
		queueEase(daStep, daStep+1, 'tornado', 0.01, 'quadInOut', -1, getValue('tornado'))
		queueEase(daStep, daStep+1, 'stretch', 0.5, 'quadInOut', -1, getValue('stretch'))
		queueEase(daStep, daStep+1, 'noteAngle', 25, 'quadInOut', -1, getValue('noteAngle'))
	end
	if curBeat % 2 == 1 then
		queueEase(daStep, daStep+1, 'centerrotateX', -20, 'quadInOut', -1, getValue('centerrotateX'))
		queueEase(daStep, daStep+1, 'centerrotateY', -20, 'quadInOut', -1, getValue('centerrotateY'))
		queueEase(daStep, daStep+1, 'centerrotateZ', -20, 'quadInOut', -1, getValue('centerrotateZ'))
		queueEase(daStep, daStep+1, 'squish', 0.5, 'quadInOut', -1, getValue('squish'))
		queueEase(daStep, daStep+1, 'tornado', -0.01, 'quadInOut', -1, getValue('tornado'))
		queueEase(daStep, daStep+1, 'noteAngle', -25, 'quadInOut', -1, getValue('noteAngle'))
	end]]
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

	for i = 0, 300 do
		if bopArray[i] == curStep then
			Bop()
		end
	end
end