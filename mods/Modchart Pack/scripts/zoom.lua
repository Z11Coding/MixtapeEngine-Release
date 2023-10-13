local curBop = 0
local curBop2 = 0
local allowBright = false
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
    addBlankMod('camGameX', 0)
    addBlankMod('camHUDX', 0)
    addBlankMod('camHUDZoom', 1)
    addBlankMod('camHUDAngle', 0)

	addBlankMod('noteAngle', 0)
end

function onSongStart()
	queueEase(0, 1, 'greyScale', -2, 'sineInOut', -1, getValue('greyScale'))
    queueEase(1, 4, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueEase(4, 5, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))

    queueEase(68, 69, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueEase(70, 72, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))
    queueEase(76, 77, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueEase(78, 80, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))
    queueEase(84, 85, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueEase(86, 88, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))
    queueEase(92, 93, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueEase(94, 96, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))
    queueEase(99, 100, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueEase(101, 103, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))
    queueEase(108, 109, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueEase(110, 112, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))
    queueEase(116, 117, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueEase(118, 121, 'greyScale', 1, 'sineInOut', -1, getValue('greyScale'))
    queueEase(124, 128, 'greyScale', 0, 'sineInOut', -1, getValue('greyScale'))
    queueSet(128, 'greyScale', 0 -1)
    queueSet(129, 'greyScale', 1 -1)
    queueSet(130, 'greyScale', 0 -1)
    queueSet(131, 'greyScale', 1 -1)
    queueSet(132, 'greyScale', 0 -1)

    queueEase(4, 116, 'multiScreenScale', 5, 'sineInOut', -1, getValue('multiScreenScale'))
    queueEase(4, 116, 'distortionIntensity', -0.3, 'sineInOut', -1, getValue('distortionIntensity'))
    
    queueEase(116, 118, 'multiScreenScale', 1, 'sineInOut', -1, getValue('multiScreenScale'))
    queueEase(116, 128, 'distortionIntensity', 0, 'elasticOut', -1, getValue('distortionIntensity'))
    queueEase(116, 118, 'centerrotateX', 0, 'sineInOut', -1, getValue('centerrotateX'))
    queueEase(116, 118, 'centerrotateY', 0, 'sineInOut', -1, getValue('centerrotateY'))
    queueEase(116, 118, 'centerrotateZ', 0, 'sineInOut', -1, getValue('centerrotateZ'))
    queueEase(116, 118, 'rotateZ', 0, 'sineInOut', -1, getValue('rotateZ'))
    queueEase(116, 118, 'transformY', 20, 'sineInOut', 0, getValue('transformX'), 0)
    queueEase(116, 118, 'transformX', 30000, 'sineInOut', 1, getValue('transformX'), 1)
    queueEase(116, 118, 'transformY', 20, 'sineInOut', 1, getValue('transformX'), 1)
    queueEase(116, 118, 'transformX', -325, 'sineInOut', 0, getValue('transformX'), 0)

    queueEase(128, 132, 'boost', 1, 'sineInOut', -1, getValue('boost'))
    
    
    
    queueEase(371, 387, 'localrotateZ', (360*8)/8, 'quad', -1, getValue('localrotateZ'))
    queueEase(371, 387, 'cmod', 4, 'quad', -1, getValue('cmod'))

    queueEase(422, 434, 'centerrotateY', 360*8, 'quadOut', -1, getValue('localrotateY'))
    queueEase(422, 434, 'localrotateX', 180, 'quad', -1, getValue('localrotateZ'))
    queueEase(435, 452, 'centerrotateY', 0, 'quadOut', -1, getValue('localrotateY'))
    queueEase(435, 452, 'localrotateX', 0, 'quad', -1, getValue('localrotateZ'))

    queueEase(486, 500, 'centerrotateY', 360*8, 'quadOut', -1, getValue('localrotateY'))
    queueEase(486, 500, 'localrotateX', 180, 'quadOut', -1, getValue('localrotateZ'))
    queueEase(500, 516, 'centerrotateY', 0, 'quad', -1, getValue('localrotateY'))
    queueEase(500, 516, 'localrotateX', 0, 'quadOut', -1, getValue('localrotateZ'))

    queueEase(548, 550, 'fieldRoll', 0, 'quadOut', -1, getValue('fieldRoll'))
    queueEase(550, 551, 'multiScreenOffX', 1, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(554, 555, 'multiScreenOffX', 2, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(558, 559, 'multiScreenOffX', 3, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(562, 564, 'multiScreenOffX', 0, 'quadOut', -1, getValue('multiScreenOffX'))

    queueEase(566, 567, 'multiScreenOffX', 1, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(570, 571, 'multiScreenOffX', 2, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(574, 575, 'multiScreenOffX', 3, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(576, 580, 'multiScreenOffX', 0, 'quadOut', -1, getValue('multiScreenOffX'))

    queueEase(608, 612, 'fieldRoll', 0, 'quadOut', -1, getValue('fieldRoll'))
    queueEase(614, 615, 'multiScreenOffX', 1, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(618, 619, 'multiScreenOffX', 2, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(622, 623, 'multiScreenOffX', 3, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(626, 629, 'multiScreenOffX', 0, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(626, 629, 'multiScreenScale', 5, 'quadOut', -1, getValue('multiScreenScale'))

    queueEase(630, 639, 'multiScreenOffX', 10, 'quadIn', -1, getValue('multiScreenOffX'))
    queueEase(630, 639, 'multiScreenScale', 1, 'quadIn', -1, getValue('multiScreenOffX'))
    queueEase(640, 644, 'multiScreenRot', 25, 'quadIn', -1, getValue('multiScreenOffX'))

    queueEase(644, 648, 'multiScreenRot', 0, 'elasticOut', -1, getValue('multiScreenRot'))

    queueEase(756, 757, 'camHUDZoom', 1.1, 'quadOut', -1, getValue('camHUDZoom'))
    queueEase(756, 757, 'multiScreenRot', 15, 'quadOut', -1, getValue('multiScreenRot'))
    queueEase(760, 761, 'camHUDZoom', 1.2, 'quadOut', -1, getValue('camHUDZoom'))
    queueEase(760, 761, 'multiScreenRot', -15, 'quadOut', -1, getValue('multiScreenRot'))
    queueEase(764, 765, 'camHUDZoom', 1.3, 'quadOut', -1, getValue('camHUDZoom'))
    queueEase(764, 765, 'multiScreenRot', 15, 'quadOut', -1, getValue('multiScreenRot'))
    queueEase(768, 772, 'camHUDZoom', 1, 'quadOut', -1, getValue('camHUDZoom'))
    queueEase(768, 772, 'multiScreenRot', 360, 'quadOut', -1, getValue('multiScreenRot'))

    queueEase(911, 912, 'transformX', -325 - 15*2, 'quadOut', 0, getValue('transformX'))
    queueEase(912, 913, 'transformX', -325 +30*2, 'quadOut', 0, getValue('transformX'))
    queueEase(913, 914, 'transformX', -325 -30*2, 'quadOut', 0, getValue('transformX'))
    queueEase(914, 915, 'transformX', -325 +30*2, 'quadOut', 0, getValue('transformX'))
    queueEase(915, 916, 'transformX', -325 -15*2, 'quadOut', 0, getValue('transformX'))
    queueEase(916, 917, 'transformX', -325, 'quadOut', 0, getValue('transformX'))

    queueEase(948, 949, 'cmod', 2, 'quadOut', 1, getValue('cmod'))
    queueEase(948, 949, 'transformX', 324, 'quadOut', 1, getValue('transformX', 1))
    queueEase(948, 949, 'transformX', 30000000, 'quadOut', 0, getValue('transformX', 0))
    queueEase(948, 950, 'multiScreenOffX', 9, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(972, 973, 'transformX', -325, 'quadOut', 0, getValue('transformX', 1))
    queueEase(972, 973, 'transformX', 30000000, 'quadOut', 1, getValue('transformX', 0))
    queueEase(979, 980, 'multiScreenOffX', 10, 'quadOut', -1, getValue('multiScreenOffX'))
    queueEase(1011, 1012, 'transformX', 324, 'quadOut', 1, getValue('transformX', 1))
    queueEase(1011, 1012, 'transformX', 3000, 'quadOut', 0, getValue('transformX', 0))
    queueEase(1011, 1012, 'multiScreenOffX', 9, 'quadOut', -1, getValue('multiScreenOffX'))

    queueEase(1171, 1175, 'centerrotateZ', -360, 'quadOut', 0, getValue('centerrotateZ'))
    queueEase(1171, 1175, 'centerrotateZ', -360, 'quadOut', 1, getValue('centerrotateZ'))

    queueEase(1032, 1043, 'transformX', 0, 'quadOut', 1, getValue('transformX', 1))
    queueEase(1059, 1075, 'transformX', 0, 'quadOut', 0, getValue('transformX', 0))

    queueEase(1231, 1232, 'transformX', -325 - 15*2, 'quadOut', 0, getValue('transformX'))
    queueEase(1232, 1233, 'transformX', -325 +30*2, 'quadOut', 0, getValue('transformX'))
    queueEase(1233, 1234, 'transformX', -325 -30*2, 'quadOut', 0, getValue('transformX'))
    queueEase(1234, 1235, 'transformX', -325 +30*2, 'quadOut', 0, getValue('transformX'))
    queueEase(1235, 1236, 'transformX', -325 -15*2, 'quadOut', 0, getValue('transformX'))
    queueEase(1236, 1237, 'transformX', -325, 'quadOut', 0, getValue('transformX'))
    queueEase(1231, 1232, 'transformX', 319 + 15*2, 'quadOut', 1, getValue('transformX'))
    queueEase(1232, 1233, 'transformX', 319 -30*2, 'quadOut', 1, getValue('transformX'))
    queueEase(1233, 1234, 'transformX', 319 +30*2, 'quadOut', 1, getValue('transformX'))
    queueEase(1234, 1235, 'transformX', 319 -30*2, 'quadOut', 1, getValue('transformX'))
    queueEase(1235, 1236, 'transformX', 319 +15*2, 'quadOut', 1, getValue('transformX'))
    queueEase(1236, 1237, 'transformX', 319, 'quadOut', 1, getValue('transformX'))

    queueEase(1283, 1299, 'centered', 1, 'quadOut', -1, getValue('centered'))
    queueSet(1299, 'centered', 0, -1)
    queueSet(1299, 'receptorScroll', 1, -1)
    queueEase(1299, 1411, 'multiScreenOffX', 7, 'quadInOut', -1, getValue('multiScreenOffX'))
    
    queueEase(1555, 1563, 'transformY', 1500, 'quadInOut', -1, getValue('transformY'))
    queueEase(1555, 1563, 'centerrotateZ', 1500, 'quadInOut', -1, getValue('centerrotateZ'))
    queueEase(1555, 1563, 'centerrotateY', 1500, 'quadInOut', -1, getValue('centerrotateY'))
    queueEase(1555, 1563, 'centerrotateX', 1500, 'quadInOut', -1, getValue('centerrotateX'))
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
    setProperty('camGame.x', getValue('camGameX'))
    setProperty('camHUD.scroll.x', getValue('camHUDX'))
    setProperty('camHUD.zoom', getValue('camHUDZoom'))
end

function Bop()
	if curBop == 0 then
		curBop = 2
		queueEase(daStep, daStep+4, 'rotateZ', 15, 'quadInOut', -1, getValue('rotateX'))
		queueEase(daStep, daStep+0.2, 'centerrotateX', 20, 'quadInOut', -1, getValue('centerrotateX'))
		queueEase(daStep, daStep+0.2, 'centerrotateY', 20, 'quadInOut', -1, getValue('centerrotateY'))
		queueEase(daStep, daStep+0.2, 'centerrotateZ', 20, 'quadInOut', -1, getValue('centerrotateZ'))
		queueEase(daStep, daStep+0.2, 'tornado', 0.01, 'quadInOut', -1, getValue('tornado'))
		queueEase(daStep, daStep+0.2, 'stretch', 0.5, 'quadInOut', -1, getValue('stretch'))
		queueEase(daStep, daStep+0.2, 'noteAngle', 25, 'quadInOut', -1, getValue('noteAngle'))
	else if curBop == 2 then
		curBop = 0
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

function Bop1andahalf()
	if curBop2 == 0 then
		curBop2 = 2
		queueEase(daStep, daStep+0.2, 'centerrotateZ', -20, 'quadInOut', -1, getValue('centerrotateZ'))
		queueEase(daStep, daStep+0.2, 'tornado', 0.01, 'quadInOut', -1, getValue('tornado'))
		queueEase(daStep, daStep+0.2, 'stretch', 0.5, 'quadInOut', -1, getValue('stretch'))
	else if curBop2 == 2 then
		curBop2 = 0
		queueEase(daStep, daStep+0.2, 'centerrotateZ', 20, 'quadInOut', -1, getValue('centerrotateZ'))
		queueEase(daStep, daStep+0.2, 'squish', 0.5, 'quadInOut', -1, getValue('squish'))
		queueEase(daStep, daStep+0.2, 'tornado', -0.01, 'quadInOut', -1, getValue('tornado'))
	end
	end
end

function Bop2()
	if curBop == 0 then
		curBop = 2
        setValue('multiScreenRot', getValue('multiScreenRot') + 3)
		queueEase(daStep, daStep+0.2, 'tornado', 0.01, 'quadInOut', -1, getValue('tornado'))
		queueEase(daStep, daStep+0.2, 'stretch', 0.5, 'quadInOut', -1, getValue('stretch'))
        queueEase(daStep, daStep+4, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
        --queueEase(daStep, daStep+4, 'camHUDX', 200, 'quadInOut', -1, getValue('camHUDX'))
	else if curBop == 2 then
		curBop = 0
        setValue('multiScreenRot', getValue('multiScreenRot') - 3)
        queueEase(daStep, daStep+4, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
        --queueEase(daStep, daStep+4, 'camHUDX', -200, 'quadInOut', -1, getValue('camHUDX'))
		queueEase(daStep, daStep+0.2, 'squish', 0.5, 'quadInOut', -1, getValue('squish'))
		queueEase(daStep, daStep+0.2, 'tornado', -0.01, 'quadInOut', -1, getValue('tornado'))
	end
	end
end

function Bop3(who)
    if who == 0 then
        if curBop == 0 then
            curBop = 2
            setValue('multiScreenRot', getValue('multiScreenRot') + 3)
            queueEase(daStep, daStep+0.2, 'tornado', 0.01, 'quadInOut', 1, getValue('tornado'))
            queueEase(daStep, daStep+0.2, 'stretch', 0.5, 'quadInOut', 1, getValue('stretch'))
            queueEase(daStep, daStep+4, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
            queueEase(daStep, daStep+0.2, 'localrotateZ', -20, 'quadInOut', 1, getValue('localrotateZ', 1))

            queueEase(daStep, daStep+0.2, 'localrotateZ', 0, 'quadInOut', 0, getValue('localrotateZ', 0))
        else if curBop == 2 then
            curBop = 0
            setValue('multiScreenRot', getValue('multiScreenRot') - 3)
            queueEase(daStep, daStep+4, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
            queueEase(daStep, daStep+0.2, 'localrotateZ', 20, 'quadInOut', 1, getValue('localrotateZ', 1))
            queueEase(daStep, daStep+0.2, 'squish', 0.5, 'quadInOut', 1, getValue('squish'))
            queueEase(daStep, daStep+0.2, 'tornado', -0.01, 'quadInOut', 1, getValue('tornado'))

            queueEase(daStep, daStep+0.2, 'localrotateZ', 0, 'quadInOut', 0, getValue('localrotateZ', 0))
        end
        end
    end
    if who == 1 then
        if curBop == 0 then
            curBop = 2
            setValue('multiScreenRot', getValue('multiScreenRot') + 3)
            queueEase(daStep, daStep+0.2, 'tornado', 0.01, 'quadInOut', 0, getValue('tornado'))
            queueEase(daStep, daStep+0.2, 'stretch', 0.5, 'quadInOut', 0, getValue('stretch'))
            queueEase(daStep, daStep+4, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
            queueEase(daStep, daStep+0.2, 'localrotateZ', -20, 'quadInOut', 0, getValue('localrotateZ', 0))

            queueEase(daStep, daStep+0.2, 'localrotateZ', 0, 'quadInOut', 1, getValue('localrotateZ', 1))
        else if curBop == 2 then
            curBop = 0
            setValue('multiScreenRot', getValue('multiScreenRot') - 3)
            queueEase(daStep, daStep+4, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
            queueEase(daStep, daStep+0.2, 'localrotateZ', 20, 'quadInOut', 0, getValue('localrotateZ', 0))
            queueEase(daStep, daStep+0.2, 'squish', 0.5, 'quadInOut', 0, getValue('squish'))
            queueEase(daStep, daStep+0.2, 'tornado', -0.01, 'quadInOut', 0, getValue('tornado'))

            queueEase(daStep, daStep+0.2, 'localrotateZ', 0, 'quadInOut', 1, getValue('localrotateZ', 1))
        end
        end
    end
    if who == 2 then
        queueEase(daStep, daStep+0.2, 'localrotateZ', 0, 'quadInOut', 0, getValue('localrotateZ', 0))
        queueEase(daStep, daStep+0.2, 'localrotateZ', 0, 'quadInOut', 1, getValue('localrotateZ', 1))
    end
end

function onBeatHit()
    if (daStep < 115) then
        Bop()
    end
    if (daStep > 385 and daStep < 628) or (daStep > 642 and daStep < 754) or (daStep > 770 and daStep < 900) or (daStep >= 1171 and daStep < 1228) or (daStep >= 1235 and daStep < 1411) then
        Bop2()
        Bop1andahalf()
    end
    if (daStep >= 1043 and daStep < 1075) or (daStep >= 1107 and daStep < 1139) then
        Bop3(0)
    end
    if (daStep >= 1075 and daStep < 1107) or (daStep >= 1139 and daStep < 1168) then
        Bop3(1)
    end
    if allowBright then
        setValue('greyScale', getValue('greyScale') - 1)
        queueEase(daStep, daStep+4, 'greyScale', 0, 'quadInOut', -1, getValue('greyScale'))
        setValue('chromaticIntensity', getValue('chromaticIntensity') + 1)
        queueEase(daStep, daStep+4, 'chromaticIntensity', 0, 'quadInOut', -1, getValue('chromaticIntensity'))
        triggerEvent("Add Camera Zoom", 0.05, 0.05)
    end
    if daStep > 123 then
        allowBright = true
    end
    if (daStep >= 128 and daStep < 371) or (daStep >= 1427 and daStep < 1539) then
        Bop1andahalf()
    end
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

    if (curStep >= 518 and curStep <= 529) or (curStep >= 534 and curStep <= 544) or (curStep >= 582 and curStep <= 593) or (curStep >= 598 and curStep <= 608) then
        setValue('fieldRoll', getValue('fieldRoll') + 25)
    end

    if curStep == 132 then
        triggerEvent("Add Camera Zoom", 0.5, 0.5)
    end
    if curStep == 188 then
        setValue('multiScreenRot', getValue('multiScreenRot') + 3)
        queueEase(curStep, curStep+3, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
    end
    if curStep == 192 then
        setValue('multiScreenRot', getValue('multiScreenRot') - 3)
        queueEase(curStep, curStep+3, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
    end
    if curStep == 196 then
        triggerEvent("Add Camera Zoom", 0.1, 0.1)
    end
    if curStep == 260 then
        triggerEvent("Add Camera Zoom", 0.1, 0.1)
    end
    if curStep == 316 then
        setValue('multiScreenRot', getValue('multiScreenRot') + 3)
        queueEase(curStep, curStep+3, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
    end
    if curStep == 320 then
        setValue('multiScreenRot', getValue('multiScreenRot') - 3)
        queueEase(curStep, curStep+3, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
    end
    if curStep == 324 then
        triggerEvent("Add Camera Zoom", 0.3, 0.3)
    end
    if curStep == 387 then
        triggerEvent("Add Camera Zoom", 0.5, 0.5)
    end
    if curStep == 900 then
        setValue('multiScreenRot', getValue('multiScreenRot') + 3)
        queueEase(curStep, curStep+3, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
        triggerEvent("Add Camera Zoom", 0.3, 0.3)
    end
    if curStep == 904 then
        setValue('multiScreenRot', getValue('multiScreenRot') - 3)
        queueEase(curStep, curStep+3, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
        triggerEvent("Add Camera Zoom", 0.3, 0.3)
    end
    if curStep == 906 then
        setValue('multiScreenRot', getValue('multiScreenRot') + 3)
        queueEase(curStep, curStep+3, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
        triggerEvent("Add Camera Zoom", 0.3, 0.3)
    end
    if curStep == 910 then
        setValue('multiScreenRot', getValue('multiScreenRot') - 3)
        queueEase(curStep, curStep+3, 'multiScreenRot', 0, 'quadInOut', -1, getValue('multiScreenRot'))
        triggerEvent("Add Camera Zoom", 0.3, 0.3)
    end
    if curStep == 916 then
        setProperty('dadField.isPlayer', true)
    end
    if curStep == 1171 then
        Bop3(2)
    end
end