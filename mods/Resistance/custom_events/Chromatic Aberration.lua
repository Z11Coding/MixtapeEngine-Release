function boundTo(value, min, max)
	return math.max(min, math.min(max, value))
end

function math.lerp(from,to,i) return from+(to-from)*i end

function setChrome(chromeOffset)
	setShaderFloat("die2", "rOffset", chromeOffset);
	setShaderFloat("die2", "gOffset", 0.0);
	setShaderFloat("die2", "bOffset", chromeOffset * -1);
end

function onCreatePost()
	luaDebugMode = false;
	if (shadersEnabled) then
		makeLuaSprite('die2')
	    	makeGraphic('die2',screenWidth,screenHeight,'000000')
	   	initLuaShader('vcr')
	      	setSpriteShader('die2','vcr')
		-- the haxe code is for changing the layr that the shader is applied to
	      	addHaxeLibrary('ShaderFilter', 'openfl.filters');
	      	runHaxeCode([[
	          game.camHUD.setFilters([new ShaderFilter(game.getLuaObject('die2').shader)]);
	          game.camGame.setFilters([new ShaderFilter(game.getLuaObject('die2').shader)]);
	      	]])
	end
end

function onEvent(n,v1,v2)


	if n == 'Chromatic Aberration' then

		local Chromacrap = 0;


		Chromacrap = Chromacrap + v1; -- edit this


		function onUpdate(elapsed)
			if (shadersEnabled) then
				Chromacrap = math.lerp(Chromacrap, 0, boundTo(elapsed * v2, 0, 1));
				setChrome(Chromacrap);
			end
		end
	end



end