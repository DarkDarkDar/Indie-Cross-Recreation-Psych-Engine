package;

/*
Original Creator Of This Castom Code Is
Peppy
*/

import flash.system.System;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.text.FlxText;
import openfl.Lib;
import flixel.effects.FlxFlicker;
import flixel.tweens.FlxTween;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxCamera;

class GameOverCuphead extends MusicBeatSubstate
{
	var curSelected:Int = 0;
	var stageSuffix:String = "";
	var dathing2:FlxSprite;
	var dathing:FlxSprite;
	var blackShits:FlxSprite;
	var optionsidk:Array<String> = ['retry', 'menu', 'quit'];
	var optionsgrp:FlxTypedGroup<FlxSprite>;
	var lmao:FlxSprite;

	public function new(x:Float, y:Float)
	{
		super();

		dathing2 = new FlxSprite(x - 300, y + 200);
		dathing2.frames = Paths.getSparrowAtlas('stages/cup/GameOver/BF_Ghost');
		dathing2.animation.addByPrefix('cupshid', 'thrtr instance 1', 24, false);
		dathing2.antialiasing = ClientPrefs.globalAntialiasing;
		dathing2.animation.play('cupshid', true);

		blackShits = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
			-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
		blackShits.scrollFactor.set();
		blackShits.alpha = 0.7;

		var cupforeg:FlxSprite = new FlxSprite(x - 500, y).loadGraphic(Paths.image('stages/cup/GameOver/death'));
		cupforeg.updateHitbox();
		cupforeg.antialiasing = ClientPrefs.globalAntialiasing;
		cupforeg.scrollFactor.set(1, 1);
		cupforeg.active = false;
		
		dathing = new FlxSprite(x - 410, y - 300);
		dathing.frames = Paths.getSparrowAtlas('stages/cup/GameOver/run');
		dathing.animation.addByPrefix('correHijoDePut', 'bf run');
		dathing.antialiasing = true;
		dathing.animation.play('correHijoDePut', true);
		dathing.angle -= 4;

		var hola:FlxSprite = new FlxSprite(x - 370, y - 300).loadGraphic(Paths.image('stages/cup/GameOver/cuphead_death'));
		hola.updateHitbox();
		hola.antialiasing = ClientPrefs.globalAntialiasing;
		hola.scrollFactor.set(1, 1);
		hola.active = false;
		hola.alpha = 0;
		hola.angle = -18;
		
		new FlxTimer().start(1.82, function(tmr:FlxTimer)
		{
			FlxTween.tween(dathing, {x: 440, y: 290}, 1, {
				ease: FlxEase.smoothStepInOut,
			});
		});

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			FlxTween.tween(cupforeg, {alpha: 0}, 1);
		});

		new FlxTimer().start(0.8, function(tmr:FlxTimer)
		{
			FlxTween.tween(hola, {alpha: 1}, 1);
		});

		new FlxTimer().start(1, function(tmr:FlxTimer) //THIS CODE IS A MESS!!!! -peppy (creator of this code) also penis
		{
			FlxTween.angle(hola, -18, -10, 0.6, {ease: FlxEase.smoothStepInOut});
		});

		add(dathing2);
		add(blackShits);
		add(cupforeg);
		add(hola);

		optionsgrp = new FlxTypedGroup<FlxSprite>();
		add(optionsgrp);

		for (i in 0...optionsidk.length)
		{
			lmao = new FlxSprite(570, 400 + (i * 60));
			lmao.frames = Paths.getSparrowAtlas('stages/cup/GameOver/buttons');
			if (optionsidk[i] == "menu")
			{
				lmao.x -= 55;
			}
			if (optionsidk[i] == "quit")
			{
				lmao.x -= 30;
			}
			lmao.animation.addByPrefix('idle', optionsidk[i] + " basic", 24);
			lmao.animation.addByPrefix('selected', optionsidk[i] + " white", 24);
			lmao.animation.play('idle');
			lmao.ID = i;
			lmao.angle = -10;
			lmao.alpha = 0;
			optionsgrp.add(lmao);
			lmao.scrollFactor.set();
			lmao.antialiasing = ClientPrefs.globalAntialiasing;
		}

		FlxTween.tween(dathing2, {y: -720}, 5);

		FlxG.camera.shake(0.1, 0.1);

		FlxG.sound.play(Paths.sound('death'));
		Conductor.changeBPM(100);

		optionsgrp.forEach(function(spr:FlxSprite)
		{
			new FlxTimer().start(1.82, function(tmr:FlxTimer)
			{
				FlxTween.tween(spr, {alpha: 1}, 1);
			});
		});

		#if mobileC
		addVirtualPad(UP_DOWN, A_B);
		
		var camcontrol = new FlxCamera();
		FlxG.cameras.add(camcontrol);
		camcontrol.bgColor.alpha = 0;
		_virtualpad.cameras = [camcontrol];
		#end
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			optionsgrp.forEach(function(spr:FlxSprite)
				{
						FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
						{
							var daChoice:String = optionsidk[curSelected];

							switch (daChoice)
							{
								case 'retry':
									endBullshit();
								case 'menu':
									FlxG.switchState(new MainMenuState());
								case 'quit':
									System.exit(0);
							}
						});
				});
		}
		if (dathing2.animation.curAnim.name == 'cupshid' && dathing2.animation.curAnim.finished)
		{
			dathing2.animation.play('cupshid', true);
		}

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
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
		}
	

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	function changeItem(huh:Int = 0)
		{
			curSelected += huh;
	
			if (curSelected >= optionsgrp.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = optionsgrp.length - 1;
	
			optionsgrp.forEach(function(spr:FlxSprite)
			{
				spr.animation.play('idle');
	
				if (spr.ID == curSelected)
				{
					spr.animation.play('selected');
				}
	
				spr.updateHitbox();
			});
		}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			
		Conductor.songPosition = 0;

			isEnding = true;
			FlxG.sound.music.stop();
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			});
		}
	}
}
