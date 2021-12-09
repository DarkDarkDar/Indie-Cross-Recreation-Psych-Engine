function onCreate()
	makeLuaSprite('Back', 'stages/bendy/BACKBACKgROUND', 0, 0);
	makeLuaSprite('Background', 'stages/bendy/BackgroundwhereDEEZNUTSfitINYOmOUTH', 0, 0);
	makeLuaSprite('MidGroun', 'stages/bendy/MidGrounUTS', 0, 0);
	makeLuaSprite('MetalBar', 'stages/bendy/NUTS', 0, 0);
	makeLuaSprite('Chain', 'stages/bendy/ChainUTS', 0, 0);
	makeLuaSprite('Foreground', 'stages/bendy/ForegroundEEZNUTS', 0, 0);	

	addLuaSprite('Back', false);
	addLuaSprite('Background', false);
	addLuaSprite('MidGroun', false);
	addLuaSprite('MetalBar', false);
	addLuaSprite('Chain', false);
	addLuaSprite('Foreground', false);

end

function onMoveCamera(focus)
    if focus == 'dad' then
        setProperty('camFollow.y', getProperty('camFollow.y') -100);
        setProperty('camFollow.x', getProperty('camFollow.x'));
    elseif focus == 'boyfriend' then
        setProperty('camFollow.y', getProperty('camFollow.y') -200);
        setProperty('camFollow.x', getProperty('camFollow.x') -300);
    end
end