package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.FlxCamera;

using StringTools;

class MainMenuState extends MusicBeatState
{
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	public static var psychEngineVersion:String = '0.4.2';
	public static var curSelected:Int = 0;

	var optionShit:Array<String> = ['freeplay', 'options', 'credits', 'awards'];
	var menuItems:FlxTypedGroup<FlxSprite>;
	var freeplay:FlxSprite;
	var options:FlxSprite;
	var credits:FlxSprite;
	var awards:FlxSprite;

	var freeplaySplash:FlxSprite;
	var optionsSplash:FlxSprite;
	var creditsSplash:FlxSprite;
	var awardsSplash:FlxSprite;	

	var menuSketch:FlxSprite;
	var bg:FlxSprite;	

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		freeplay = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/opened/Freeplay'));
		menuItems.add(freeplay);
		freeplay.scrollFactor.set();
		freeplay.antialiasing = ClientPrefs.globalAntialiasing;
		freeplay.setGraphicSize(Std.int(freeplay.width * 0.7));
		freeplay.y += 230;		
		freeplay.x -= 200;
		freeplay.alpha = 0.60;

		options = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/opened/Options'));
		menuItems.add(options);
		options.scrollFactor.set();
		options.antialiasing = ClientPrefs.globalAntialiasing;
		options.setGraphicSize(Std.int(options.width * 0.7));
		options.y += 230;
		options.x -= 200;
		options.alpha = 0.60;

		credits = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/opened/Credits'));
		menuItems.add(credits);
		credits.scrollFactor.set();
		credits.antialiasing = ClientPrefs.globalAntialiasing;
		credits.setGraphicSize(Std.int(credits.width * 0.7));
		credits.y += 230;
		credits.x -= 200;
		credits.alpha = 0.60;

		awards = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/opened/Achievements'));
		menuItems.add(awards);
		awards.scrollFactor.set();
		awards.antialiasing = ClientPrefs.globalAntialiasing;
		awards.setGraphicSize(Std.int(awards.width * 0.7));
		awards.y += 230;
		awards.x -= 200;
		awards.alpha = 0.60;				
		
		freeplaySplash = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/opened/Freeplay flash'));
		freeplaySplash.scrollFactor.set();
		freeplaySplash.antialiasing = ClientPrefs.globalAntialiasing;
		freeplaySplash.setGraphicSize(Std.int(freeplaySplash.width * 0.7));
		freeplaySplash.x -= 200;
		freeplaySplash.y += 230;
		freeplaySplash.alpha = 0;
		add(freeplaySplash);
		
		optionsSplash = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/opened/Options flash'));
		optionsSplash.scrollFactor.set();
		optionsSplash.antialiasing = ClientPrefs.globalAntialiasing;
		optionsSplash.setGraphicSize(Std.int(optionsSplash.width * 0.7));
		optionsSplash.y += 230;
		optionsSplash.x -= 200;
		optionsSplash.alpha = 0;
		add(optionsSplash);	

		creditsSplash = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/opened/Credits flash'));
		creditsSplash.scrollFactor.set();
		creditsSplash.antialiasing = ClientPrefs.globalAntialiasing;
		creditsSplash.setGraphicSize(Std.int(creditsSplash.width * 0.7));
		creditsSplash.y += 230;
		creditsSplash.x -= 200;
		creditsSplash.alpha = 0;
		add(creditsSplash);	

		awardsSplash = new FlxSprite(-100, -400).loadGraphic(Paths.image('mainmenu/opened/Achievements flash'));
		awardsSplash.scrollFactor.set();
		awardsSplash.antialiasing = ClientPrefs.globalAntialiasing;
		awardsSplash.setGraphicSize(Std.int(awardsSplash.width * 0.7));
		awardsSplash.y += 230;
		awardsSplash.x -= 200;
		awardsSplash.alpha = 0;
		add(awardsSplash);					

		var sketch:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/sketch/sketch'));
		sketch.frames = Paths.getSparrowAtlas('mainmenu/sketch/sketch');
		sketch.animation.addByPrefix('bump', 'menu bru', 3); 
		sketch.animation.play('bump');
		sketch.setGraphicSize(Std.int(sketch.width * 0.7));
		sketch.x -= 300;
		sketch.y -= 200;
		add(sketch);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		var IndieLogo:FlxSprite = new FlxSprite(-310, -170).loadGraphic(Paths.image('mainmenu/LOGO'));
		IndieLogo.updateHitbox();
		IndieLogo.setGraphicSize(Std.int(IndieLogo.width * 0.7));
		IndieLogo.antialiasing = ClientPrefs.globalAntialiasing;
		add(IndieLogo);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		#if mobileC
		addVirtualPad(UP_DOWN, A_B_C);
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end
	
	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				
				if (curSelected == 0) 
				{
					FlxTween.tween(freeplaySplash, {alpha: 1}, 0.1, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) { FlxTween.tween(freeplaySplash, {alpha: 0}, 0.4, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) { goToState(); }}); }});
				} 
				else if (curSelected == 1) 
				{
					FlxTween.tween(optionsSplash, {alpha: 1}, 0.1, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) { FlxTween.tween(optionsSplash, {alpha: 0}, 0.4, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) { goToState(); }}); }});
				}
				else if (curSelected == 2) 
				{
					FlxTween.tween(creditsSplash, {alpha: 1}, 0.1, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) { FlxTween.tween(creditsSplash, {alpha: 0}, 0.4, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) { goToState(); }}); }});
				}
				else 
				{
					FlxTween.tween(awardsSplash, {alpha: 1}, 0.1, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) { FlxTween.tween(awardsSplash, {alpha: 0}, 0.4, {ease: FlxEase.linear, onComplete: function(twn:FlxTween) { goToState(); }}); }});
				}									
			}
			else if (FlxG.keys.justPressed.SEVEN #if mobileC || _virtualpad.buttonC.justPressed #end)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
		}

		super.update(elapsed);

	}

	public function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'freeplay':
				MusicBeatState.switchState(new FreeplayState());
			case 'options':
				MusicBeatState.switchState(new OptionsState());
			case 'credits':
				MusicBeatState.switchState(new CreditsState());	
			case 'awards':
				MusicBeatState.switchState(new AchievementsMenuState());				
		}
	}

	public function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;	

		switch (optionShit[curSelected])
		{
			case 'freeplay':
				freeplay.alpha = 1; 
				awards.alpha = 0.6;				
				credits.alpha = 0.6;  
				options.alpha = 0.6; 				
			case 'options':			
				options.alpha = 1; 
				freeplay.alpha = 0.6;
				awards.alpha = 0.6;  
				credits.alpha = 0.6; 
			case 'credits':		
				credits.alpha = 1; 
				options.alpha = 0.6; 
				freeplay.alpha = 0.6;
				awards.alpha = 0.6;  
			case 'awards':	
				awards.alpha = 1;				
				credits.alpha = 0.6; 
				options.alpha = 0.6; 
				freeplay.alpha = 0.6; 				
		}						
	}
}
