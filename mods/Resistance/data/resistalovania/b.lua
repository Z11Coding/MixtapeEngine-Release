local amountLeft = 1
local safeForNow = false
local safeCheck = false
function onCreatePost()
    setProperty("boyfriend.y", getProperty("boyfriend.y") - 10, false)

    makeLuaSprite("redFlash", "RedVG", 0, 0)
    setObjectCamera("redFlash", "hud")
    screenCenter("redFlash", 'xy')
    addLuaSprite("redFlash", true)
    setProperty("redFlash.alpha", 0)

    makeLuaSprite("sign", "Sign", 0, 0)
    setObjectCamera("sign", "hud")
    scaleObject("sign", 0.5, 0.5)
    updateHitbox("sign")
    screenCenter("sign", 'xy')
    addLuaSprite("sign", true)
    setProperty("sign.alpha", 0)

    makeLuaSprite("x", "twitter", 0, 0)
    setObjectCamera("x", "hud")
    scaleObject("x", 0.5, 0.5)
    updateHitbox("x")
    screenCenter("x", 'xy')
    addLuaSprite("x", true)
    setProperty("x.alpha", 0)

    makeLuaText("warnem", "WAIT...", 700, 0, 500)
    setObjectCamera("warnem", "hud")
    setTextSize('warnem', 50)
    screenCenter('warnem', 'X')
    addLuaText("warnem")
    setProperty("warnem.alpha", 0)
    setProperty("warnem.x", getProperty("warnem.x") + 30)
end

function onEvent(name, value1, value2)
    if name == 'doAttackMech' then
        queueEase(daStep2, daStep2+12, 'distortionIntensity', getValue('distortionIntensity')-0.1, 'elasticOut', -1, getValue('distortionIntensity'))
        setTextColor("warnem", "YELLOW")
        setTextString("warnem", "WAIT...")
        if difficultyName == 'Nightmare' then
            if keyboardPressed("SPACE") then
                setProperty("health", 0)
                setProperty("dad.x", getProperty("dad.x") + 400)
            end
            setProperty("redFlash.alpha", 1)
            doTweenAlpha("redAl", "redFlash", 0, 0.2, "sineInOut")
            setProperty("warnem.alpha", 1)
            doTweenAlpha("warnemAl", "warnem", 0, 0.2, "sineInOut")
        else if difficultyName == 'Hard' then
            setProperty("x.alpha", 1)
            doTweenAlpha("xAl", "x", 0, 0.2, "sineInOut")
            setProperty("warnem.alpha", 1)
            doTweenAlpha("warnemAl", "warnem", 0, 0.2, "sineInOut")
            setProperty("redFlash.alpha", 1)
            doTweenAlpha("redAl", "redFlash", 0, 0.2, "sineInOut")
        else if difficultyName == 'Unreal' then
            if keyboardPressed("SPACE") then
                setProperty("health", 0)
                setProperty("dad.x", getProperty("dad.x") + 400)
            end
            setProperty("warnem.alpha", 1)
            doTweenAlpha("warnemAl", "warnem", 0, 0.2, "sineInOut")
        end
        end
        end
        runTimer("doWarn", (crochet/1000)/playbackRate)
        setProperty("dad.x", getProperty("dad.x") + 100)
        amountLeft = value1-2
        if value1 == 3 then
            amountMoved = 400
        end
        --debugPrint('WAIT...')
    end
end

function onStepHit()
	daStep2 = curStep 
end

function onTimerCompleted(a,b,c)
    --debugPrint(safeForNow)
    if a == 'doWarn' then
        if amountLeft == 0 then
            setValue("reverse", getValue('reverse') + 1, -1)
            queueEase(daStep2, daStep2+8, 'multiScreenOffX', getValue('multiScreenOffX') + 0.99999, 'elasticOut', -1, getValue('multiScreenOff'))
		    queueEase(daStep2, daStep2+12, 'distortionIntensity', 0, 'elasticOut', -1, getValue('distortionIntensity'))
            setTextColor("warnem", "RED")
            if difficultyName == 'Nightmare' then
                if keyboardPressed("SPACE") then
                    setProperty("health", 0)
                    setProperty("dad.x", getProperty("dad.x") + 400)
                end
                setProperty("redFlash.alpha", 1)
                doTweenAlpha("redAl", "redFlash", 0, 0.2, "sineInOut")
                setProperty("warnem.alpha", 1)
                doTweenAlpha("warnemAl", "warnem", 0, 0.2, "sineInOut")
            else if difficultyName == 'Hard' then
                setProperty("sign.alpha", 1)
                doTweenAlpha("signAl", "sign", 0, 0.2, "sineInOut")
                setProperty("redFlash.alpha", 1)
                doTweenAlpha("redAl", "redFlash", 0, 0.2, "sineInOut")
                setProperty("warnem.alpha", 1)
                doTweenAlpha("warnemAl", "warnem", 0, 0.2, "sineInOut")
            else if difficultyName == 'Unreal' then
                if keyboardPressed("SPACE") then
                    setProperty("health", 0)
                    setProperty("dad.x", getProperty("dad.x") + 400)
                end
            end
            end
            end
            runTimer("doAttackMech", (crochet/1000)/playbackRate)
            setProperty("dad.x", getProperty("dad.x") + 100)
            setTextString("warnem", "PRESS SPACE!")
            safeCheck = true
            --debugPrint('PRESS NOW!')
        else
            queueEase(daStep2, daStep2+12, 'distortionIntensity', getValue('distortionIntensity')-0.1, 'elasticOut', -1, getValue('distortionIntensity'))
            setTextColor("warnem", "YELLOW")
            if difficultyName == 'Nightmare' then
                if keyboardPressed("SPACE") then
                    setProperty("health", 0)
                    setProperty("dad.x", getProperty("dad.x") + 400)
                end
                setProperty("redFlash.alpha", 1)
                doTweenAlpha("redAl", "redFlash", 0, 0.2, "sineInOut")
                setProperty("warnem.alpha", 1)
                doTweenAlpha("warnemAl", "warnem", 0, 0.2, "sineInOut")
            else if difficultyName == 'Hard' then
                setProperty("x.alpha", 1)
                doTweenAlpha("xAl", "x", 0, 0.2, "sineInOut")
                setProperty("redFlash.alpha", 1)
                doTweenAlpha("redAl", "redFlash", 0, 0.2, "sineInOut")
                setProperty("warnem.alpha", 1)
                doTweenAlpha("warnemAl", "warnem", 0, 0.2, "sineInOut")
            else if difficultyName == 'Unreal' then
                if keyboardPressed("SPACE") then
                    setProperty("health", 0)
                    setProperty("dad.x", getProperty("dad.x") + 400)
                end
            end
            end
            end
            amountLeft = amountLeft - 1
            runTimer("doWarn", (crochet/1000)/playbackRate)
            setProperty("dad.x", getProperty("dad.x") + 100)
            setTextString("warnem", "WAIT...")
            --debugPrint('WAIT...')
        end
    end
    if a == 'doAttackMech' then
        if difficultyName == 'Nightmare' then
            runTimer("doCheck", 0.01)
            if keyboardJustPressed("SPACE") then
                safeForNow = true
            end
            if safeForNow then
                --debugPrint('SAFE!')
            else
                --debugPrint('LAST CHANCE!')
            end
        else if difficultyName == 'Unreal' then
            runTimer("doCheck", 0.001)
            if safeForNow then
                --debugPrint('SAFE!')
            else
                --debugPrint('GAME OVER!')
                safeCheck = false
            end
        else
            runTimer("doCheck", 0.4)
            if safeForNow then
                --debugPrint('SAFE!')
            else
               -- debugPrint('LAST CHANCE!')
            end
        end
        end
    end
    if a == 'doCheck' then
        cancelTimer("doAttackMech")
        cancelTimer("doWarn")
        amountLeft = 1
        if not botPlay then
            if not safeForNow then
                --debugPrint('GAME OVER!')
                setProperty("health", 0)
            else
                --debugPrint('SAFE!')
                playAnim("boyfriend", "idle-alt", true)
                setProperty("boyfriend.specialAnim", true)
                setProperty("dad.x", getProperty("dad.x") + 200)
                doTweenX("goBAck", "dad", 0, 1, "sineInOut")
                safeForNow = false
                safeCheck = false
            end
        else
            debugPrint('BOTPLAY PASS')
            playAnim("boyfriend", "idle-alt", true)
            setProperty("boyfriend.specialAnim", true)
            setProperty("dad.x", getProperty("dad.x") + 200)
            doTweenX("goBAck", "dad", 0, 1, "sineInOut")
            cancelTimer("doCheck")
            safeForNow = false
        end
    end
end

function onUpdate(w)
    if safeCheck then
        if keyboardPressed("SPACE") then
            safeForNow = true
            setTextString("warnem", "SAFE!")
            setTextColor("warnem", "GREEN")
            if difficultyName == 'Unreal' then
                setProperty("warnem.alpha", 1)
                doTweenAlpha("warnemAl", "warnem", 0, 0.2, "sineInOut")
            end
        end
    end
end