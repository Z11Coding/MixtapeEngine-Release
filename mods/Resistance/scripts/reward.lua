local songList = {
    {'Resistance', false},
    {'Resistance-K', false},
    {'Resistance Awsome Mix', false},
    {'Resistance-kai', false},
    {'Resistalovania', false}
}
function onCreate()
    initSaveData('zenettaDeathCheck', 'Resistance')
end
function onCreatePost()
    if getDataFromSave("zenettaDeathCheck", "Resistance") == nil then
        setDataFromSave('zenettaDeathCheck', 'Resistance', songList)
    end
    debugPrint(getDataFromSave("zenettaDeathCheck", "Resistance"))
end
function onEndSong()
    if songName == 'Resistance' and getProperty("deathCounter") <= 0 then
        songList[0][1] = true
        setDataFromSave('zenettaDeathCheck', 'Resistance', songList)
    end
end