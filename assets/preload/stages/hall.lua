local utSwitchCam = false
function onCreate()
	makeLuaSprite('hall', 'stages/sans/hall', 0, 0);	  
	addLuaSprite('hall', false);
end

function onMoveCamera(focus)
    if not utSwitchCam then
        if focus == 'dad' then
            setProperty('camFollow.y', getProperty('camFollow.y') );
            setProperty('camFollow.x', getProperty('camFollow.x') +50);
        elseif focus == 'boyfriend' then
            setProperty('camFollow.y', getProperty('camFollow.y') -50);
            setProperty('camFollow.x', getProperty('camFollow.x') -300);
        end
    else
         if focus == 'dad' then
            setProperty('camFollow.y', getProperty('camFollow.y'));
            setProperty('camFollow.x', getProperty('camFollow.x') -150);
        elseif focus == 'boyfriend' then
            setProperty('camFollow.y', getProperty('camFollow.y') +100);
            setProperty('camFollow.x', getProperty('camFollow.x') +100);
        end
    end       
end

function onStepHit()
    if curStep == 800 then
        removeLuaSprite('hall', false)   
        makeLuaSprite('battle', 'stages/sans/battle', 0, 0);  
        addLuaSprite('battle', false);   
        setProperty('dad.x', 750);
        setProperty('dad.y', 720); 
        setProperty('boyfriend.x', 750);
        setProperty('boyfriend.y', 1500);
        utSwitchCam = true;      
    end
end