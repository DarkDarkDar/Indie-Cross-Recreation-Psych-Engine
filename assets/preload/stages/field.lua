function onCreate()
	makeLuaSprite('BG0', 'stages/cup/BG-00', 0, 0);
	setLuaSpriteScrollFactor('BG0', 0.7, 0.7);

	makeLuaSprite('BG1', 'stages/cup/BG-01', 0, 0);
	setLuaSpriteScrollFactor('BG1', 0.8, 0.8);

	makeLuaSprite('Ground', 'stages/cup/Foreground', 0, 0);

	addLuaSprite('BG0', false);
	addLuaSprite('BG1', false);
	addLuaSprite('Ground', false);	
end

function onMoveCamera(focus)
    if focus == 'dad' then
        setProperty('camFollow.y', getProperty('camFollow.y') -50);
        setProperty('camFollow.x', getProperty('camFollow.x'));
    elseif focus == 'boyfriend' then
        setProperty('camFollow.y', getProperty('camFollow.y'));
        setProperty('camFollow.x', getProperty('camFollow.x'));
    end
end