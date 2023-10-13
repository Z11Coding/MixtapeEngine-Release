------------------------------------------------------------------------------
----------------------- BETTERCAMERA BY RORUTOP!!!!! -------------------------
------------------------------------------------------------------------------


--local signal = require([[mods\Bad Future\module\Signal]])
--local Eases = require([[mods\Bad Future\module\Eases]])

---------------------------------------------------------------
----------------------- CAMERA MODULE -------------------------
---------------------------------------------------------------
local BetterCamera = {}
BetterCamera.__index = BetterCamera
BetterCamera.instances = {}

function BetterCamera.new()
    local self = {
        index = #getProperty('BETTERCAMERA_CamInstanceHolder') + 1, -- dont ever change this
        x = 0,y = 0,
        offsetx = 0,offsety = 0,
        zoom = 0,offsetzoom = 0,camposzoom = 0,
        dadsideZoom = 0,bfsideZoom = 0,
        cameraspeed = 0,
        angle = 0
    }
    insertToHaxeTbl(setmetatable(self,BetterCamera))
    return setmetatable(self, BetterCamera)
end

function BetterCamera:set(var,val)
    self[var] = val
    local holder = getProperty('BETTERCAMERA_CamInstanceHolder')
    for i,v in next,holder do
        if v.index == self.index then
            table.remove(holder, i)
            table.insert(holder,self)
            setProperty('BETTERCAMERA_CamInstanceHolder', holder)
            break
        end
    end
end
function BetterCamera:delete() -- idk lol, prob for onupdate stuff
    local holder = getProperty('BETTERCAMERA_CamInstanceHolder')
    for i,v in next,holder do
        if v.index == self.index then
            table.remove(holder, i)
            setProperty('BETTERCAMERA_CamInstanceHolder',holder)
            break
        end
    end
end

function BetterCamera.setMoveOnNoteHit(val)
    if val ~= 'animHit' or val ~= 'noteHit' then val = false end
    setProperty('BETTERCAMERA_moveOnNoteHit',val)
end
function BetterCamera.setHitPoses(axis,animName,val)
    local hitPoses = getProperty('BETTERCAMERA_moveHitPoses')
    if not hitPoses[axis] then hitPoses[axis] = {} end
    hitPoses[axis][animName] = val
    setProperty('BETTERCAMERA_moveHitPoses',hitPoses)
end
function BetterCamera.setFollowLerp(val)
    local tval = val or 1
    runHaxeCode('FlxG.camera.follow(BETTERCAMERA_camFollowPos, Type.getEnum(game.camGame.style).LOCKON, '..tval..');')
end
function BetterCamera.bop(amount)
    runHaxeCode([[FlxG.camera.zoom += ]]..amount)
    runHaxeCode([[game.camHUD.zoom += ]]..amount)
end

-- put anything here if u have some cameras or u want ot put game.camOther
local camshakeHolder = {['FlxG.camera'] = 'camGame_camshakething',['game.camHUD'] = 'camHUD_camshakething'}
local whichCam = {
    ['game.camHUD'] = {'hud','camhud'}
}
function BetterCamera.shake(cam,intensity,dur,ease)
    local camName = camshakeHolder[cameraFromString(cam:lower())]
    local inten
    setProperty(camName..'.x',type(intensity) == 'table' and intensity[1] or (intensity or 0))
    doTweenX(camName..'SHAKEEEE',camName,type(intensity) == 'table' and intensity[2] or 0,dur,ease or 'linear')
end
-- CUSTOM CAMERAFLASH
function BetterCamera.newCameraFlash(index,camera)
    if index <= 0 then runHaxeCode([[game.addTextToDebug("BETTERCAMERA ERROR: Really? You put the index to ]]..index..[[? That doesn't work dumbass!", 0xFFFF0000);]]) end
    local holder = getProperty('BETTERCAMERA_CamFlashIndexHolder')
    if holder[index] then
        index = holder[#holder][1] + 1
        runHaxeCode"game.addTextToDebug('BETTERCAMERA WARNING: That camera flash index already existed! Putting it in a new index..', 0xFFFFFF00);"
        runHaxeCode("game.addTextToDebug('Your index is now: "..index.."', 0xFFFFFF00);")
    end
    local box = 'BETTERCAMERA_camFlashBox'..index
    makeLuaSprite(box,'',-screenWidth / 2,-screenHeight / 2)
    makeGraphic(box,screenWidth,screenHeight,'FFFFFF')
    addLuaSprite(box,true)
    setProperty(box..'.alpha',0)
    runHaxeCode([[
        game.getLuaObject(']]..box..[[').camera = ]]..cameraFromString(camera:lower())..[[;
    ]])
    setScrollFactor(box,0,0)
    holder[index] = {index,cameraFromString(camera:lower())}
    setProperty('BETTERCAMERA_CamFlashIndexHolder',holder)
end
function BetterCamera.flash(index,alpha,dur,color,ease) -- tip setting the alpha to nil will set the alpha for you
    local _index = getProperty('BETTERCAMERA_CamFlashIndexHolder')[index]
    if not _index then runHaxeCode"game.addTextToDebug('BETTERCAMERA ERROR: CAMERA FLASH INDEX NOT FOUND!', 0xFFFF0000);"; return end
    local box = 'BETTERCAMERA_camFlashBox'..index
    setProperty(box..'.color',getColorFromHex(color or 'FFFFFF'))
    setProperty(box..'.alpha',type(alpha) == 'table' and alpha[1] or 1)
    doTweenAlpha(box..'tween',box,type(alpha) == 'table' and alpha[2] or (alpha or 0),dur,ease or 'linear')
end


-----------------------------------------------------------
----------------------- FUNCTIONS -------------------------
-----------------------------------------------------------
function _lerp(a,b,t) return a * (1-t) + b * t end
function insertToHaxeTbl(val)
    local holder = getProperty('BETTERCAMERA_CamInstanceHolder')
    table.insert(holder,val)
    setProperty('BETTERCAMERA_CamInstanceHolder', holder)
end
function boundTo(v,min,max)
    return math.max(min,math.min(max,v))
end
function cameraFromString(cam) 
    local found = false
    for i, v in pairs(whichCam) do
        for i2,v2 in ipairs(v) do
            if v2 == cam then
                return i
            end
        end
    end
    return 'FlxG.camera';
end

local noteHitLerp = {x = 0,y = 0}
function updateCamFollow(dt)
    local sides = runHaxeCode('return PlayState.SONG.notes[game.curSection].mustHitSection;')

    local pos,zoom,camposzoom = {x = 0,y = 0},getProperty('BETTERCAMERA_actualDefCamZoom'),0
    local forcpos,forczoom = {x = 0,y = 0},0
    local isforcedpos,isforcedzoom = {x = false,y = false},false
    local camspeed = 0
    local camangle = 0
    for i,v in next,getProperty('BETTERCAMERA_CamInstanceHolder') do
        if v.x == 0 and not isforcedpos.x then 
            pos.x = pos.x + v.offsetx
        else isforcedpos.x = true; forcpos.x = forcpos.x + v.x
        end
        if v.y == 0 and not isforcedpos.y then 
            pos.y = pos.y + v.offsety
        else 
            isforcedpos.y = true
            forcpos.y = forcpos.y + v.y
        end
        pos.x,pos.y = pos.x + v.offsetx,pos.y + v.offsety
        if v.zoom == 0 and not isforcedzoom then
            zoom = zoom + v.offsetzoom + (sides and v.bfsideZoom or v.dadsideZoom)
        else isforcedzoom = true; forczoom = forczoom + v.zoom
        end
        camposzoom = camposzoom + v.camposzoom
        camspeed = camspeed + v.cameraspeed
        camangle = camangle + v.angle
    end
    pos.x = pos.x + getMoveOnAnimHit(getProperty('BETTERCAMERA_moveHitPoses')).x + noteHitLerp.x
    pos.y = pos.y + getMoveOnAnimHit(getProperty('BETTERCAMERA_moveHitPoses')).y + noteHitLerp.y
    setPropertyFromClass('flixel.FlxG','camera.angle',camangle)
    -- if(SONG.notes[curSection] == null) return
    setProperty('defaultCamZoom', isforcedzoom and forczoom or zoom)
    setProperty('cameraSpeed', camspeed == 0 and getProperty('BETTERCAMERA_defaultCamSpeed') or camspeed)

    updateShake()
    updateZoomCamera(camposzoom)
    easeCameraPos(dt)
    if not runHaxeCode('return (PlayState.SONG.notes[game.curSection] != null);') then return end
    updateMoveCamera(pos,forcpos,isforcedpos)
end

function getMoveOnAnimHit(poses)
    if getProperty('BETTERCAMERA_moveOnNoteHit') ~= 'animHit' then return {x = 0,y = 0} end

    local sides = runHaxeCode('return PlayState.SONG.notes[game.curSection].mustHitSection;') and 'boyfriend' or 'dad'
    local ogPoses = {
        x = {singLEFT = -20,singRIGHT = 20},
        y = {singUP = -20,singDOWN = 20}
    }
    for ax = 1,2 do
        local axis = {'x','y'}
        if poses[axis[ax]] ~= nil then
            for i,v in pairs(poses[axis[ax]]) do
                ogPoses[axis[ax]][i] = v
            end
        end
    end
    return {x = ogPoses.x[getProperty(sides..'.animation.curAnim.name')] or 0,y = ogPoses.y[getProperty(sides..'.animation.curAnim.name')] or 0}
end

function updateMoveCamera(offset,forcposition,isforcedpos)
    runHaxeCode([=[
        var hitsides = PlayState.SONG.notes[game.curSection].mustHitSection;
        var isforcedpos = []=]..tostring(isforcedpos.x)..[=[,]=]..tostring(isforcedpos.y)..[=[];

        var leMidPosX = isforcedpos[0] ? ]=]..forcposition.x..[=[ : (hitsides ? game.boyfriend.getMidpoint().x - 100 : game.dad.getMidpoint().x + 150);
        var leMidPosY = isforcedpos[1] ? ]=]..forcposition.y..[=[ : (hitsides ? game.boyfriend.getMidpoint().y - 100 : game.dad.getMidpoint().y - 100);

        var cameraPosition = hitsides ? game.boyfriend.cameraPosition : game.dad.cameraPosition;
        var cameraOffset = hitsides ? game.boyfriendCameraOffset : game.opponentCameraOffset;

        game.camFollow.set(leMidPosX + ]=]..offset.x..[=[, leMidPosY + ]=]..offset.y..[=[);
		game.camFollow.x += cameraPosition[0] + cameraOffset[0];
		if (hitsides)
            game.camFollow.y -= cameraPosition[1] + cameraOffset[1];
        else
            game.camFollow.y += cameraPosition[1] + cameraOffset[1];
    ]=])
end

local lastcamfollow = {x = 0,y = 0}
local lastcamfollowPOS = {x = 0,y = 0}
local thatimerx = 0
local thatimery = 0
function easeCameraPos(dt)
    if lastcamfollow.x ~= getProperty('camFollow.x') then 
        thatimerx = 0; lastcamfollowPOS.x = runHaxeCode'return BETTERCAMERA_camFollowPos.x'; lastcamfollow.x = getProperty('camFollow.x')
    end
    if lastcamfollow.y ~= getProperty('camFollow.y') then 
        thatimery = 0; lastcamfollowPOS.y = runHaxeCode'return BETTERCAMERA_camFollowPos.y'; lastcamfollow.y = getProperty('camFollow.y') 
    end

    local e = getProperty('BETTERCAMERA_typeEase')
    if e == 'default' then
        local h = boundTo(runHaxeCode'return FlxG.elapsed * 2.4 * game.cameraSpeed * game.playbackRate;',0,1) -- doing this because the coolutil one doesnt work
        addHaxeLibrary('FlxMath','flixel.math')
        runHaxeCode([[
			BETTERCAMERA_camFollowPos.setPosition(FlxMath.lerp(BETTERCAMERA_camFollowPos.x, game.camFollow.x, ]]..h..[[),FlxMath.lerp(BETTERCAMERA_camFollowPos.y, game.camFollow.y, ]]..h..[[));
        ]])
    elseif e == 'static' then
        runHaxeCode'BETTERCAMERA_camFollowPos.setPosition(game.camFollow.x, game.camFollow.y);'
        --[=[
    else -- THIS IS BUGGED ATM
        -- I DONT FUCKING KNOW HOW TO IMPLEMENT THIS SHIT
        local easeType = Eases[e]
        if not easeType then runHaxeCode"game.addTextToDebug('BETTERCAMERA ERROR: EASE TYPE NOT FOUND!', 0xFFFF0000);"; return end
        thatimerx,thatimery = thatimerx + dt * getProperty('cameraSpeed'),thatimery + dt * getProperty('cameraSpeed')
        local valx = easeType(math.min(1,thatimerx),lastcamfollowPOS.x,getProperty('camFollow.x'),1)
        local valy = easeType(math.min(1,thatimery),lastcamfollowPOS.y,getProperty('camFollow.y'),1)
        runHaxeCode([[BETTERCAMERA_camFollowPos.setPosition(]]..valx..[[, ]]..valy..[[);]])
        debugPrint(valy) ]=]
    end
end

function updateZoomCamera(camposzoom)
    if not getProperty('BETTERCAMERA_camZooming') then return end
    addHaxeLibrary('FlxMath','flixel.math')
    local h = boundTo(runHaxeCode[[return 1 - (FlxG.elapsed * 3.125 * game.camZoomingDecay * game.playbackRate);]],0,1)

    runHaxeCode([[
        FlxG.camera.zoom = FlxMath.lerp(game.defaultCamZoom + ]]..camposzoom..[[, FlxG.camera.zoom, ]]..h..[[);
        game.camHUD.zoom = FlxMath.lerp(1, game.camHUD.zoom, ]]..h..[[);
    ]])
end

function updateShake()
    for i,v in pairs(camshakeHolder) do
        local shakeintensity = getProperty(v..'.x')
        local shakeX = runHaxeCode([[FlxG.random.float(-]]..shakeintensity..[[ * ]]..i..[[.width, ]]..shakeintensity..[[ * ]]..i..[[.width) * ]]..i..[[.zoom * FlxG.scaleMode.scale.x;]])
        local shakeY = runHaxeCode([[FlxG.random.float(-]]..shakeintensity..[[ * ]]..i..[[.height, ]]..shakeintensity..[[ * ]]..i..[[.height) * ]]..i..[[.zoom * FlxG.scaleMode.scale.y;]])
        runHaxeCode([[
            ]]..i..[[.x = ]]..shakeX..[[;
            ]]..i..[[.y = ]]..shakeY..[[;
        ]])
    end
end

function BetterCamera.update(dt)
    setProperty('camZooming', false) -- LOLOLOLOL
    setProperty('isCameraOnForcedPos', true)
    luaDebugMode = true
    updateCamFollow(dt)

    local h = boundTo(runHaxeCode'return FlxG.elapsed * 2.4 * game.cameraSpeed * game.playbackRate;' + crochet*0.0001,0,1)
    noteHitLerp.x = _lerp(noteHitLerp.x,0,h)
    noteHitLerp.y = _lerp(noteHitLerp.y,0,h)

    for i,v in pairs(getProperty('BETTERCAMERA_CamFlashIndexHolder')) do
        local box = 'BETTERCAMERA_camFlashBox'..i
        setProperty(box..'.x',-(screenWidth / 2) / runHaxeCode('return '..v[2]..'.zoom'))
        setProperty(box..'.y',-(screenHeight / 2) / runHaxeCode('return '..v[2]..'.zoom'))
        setGraphicSize(box,screenWidth * 2 / runHaxeCode('return '..v[2]..'.zoom'),screenHeight * 2 / runHaxeCode('return '..v[2]..'.zoom'))
        setObjectOrder(box,99999 + i)
    end
end

function BetterCamera.noteHit(noteData)
    if getProperty('BETTERCAMERA_moveOnNoteHit') ~= 'noteHit' then return end
    local ogPoses = {
        x = {singLEFT = -20,singRIGHT = 20},
        y = {singUP = -20,singDOWN = 20}
    }
    local poses = getProperty('BETTERCAMERA_moveHitPoses')
    for ax = 1,2 do
        local axis = {'x','y'}
        if poses[axis[ax]] ~= nil then
            for i,v in pairs(poses[axis[ax]]) do
                ogPoses[axis[ax]][i] = v
            end
        end
    end
    local data = {
        x = {ogPoses.x.singLEFT,0,0,ogPoses.x.singRIGHT},
        y = {0,ogPoses.y.singDOWN,ogPoses.y.singUP,0}
    }
    noteHitLerp.x = noteHitLerp.x + data.x[noteData + 1] * 2
    noteHitLerp.y = noteHitLerp.y + data.y[noteData + 1] * 2
end

return BetterCamera