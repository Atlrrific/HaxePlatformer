package;

import nme.Assets;
import nme.geom.Rectangle;
import nme.events.Event;
import nme.events.TouchEvent;
import nme.Lib;
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;
import nme.net.SharedObject;
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxPath;
import org.flixel.FlxRect;
import org.flixel.FlxSave;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTilemap;
import org.flixel.FlxU;
import org.flixel.FlxObject;
import org.flixel.FlxGroup;
import org.flixel.FlxText;


class PlayState extends FlxState
{
	private var map:FlxTilemap;
	private var player:FlxSprite;
	private var player_jumping:Bool;
	private var collectables_layer:FlxGroup;
	public var textScore:FlxText;
	private var enemyGroup:FlxGroup;
	
	override public function create():Void
	{
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.camera.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		#if !FLX_NO_MOUSE
		//FlxG.mouse.show();
		#end
		
		//LOAD UP THE MAP
		map = new FlxTilemap();
		map.loadMap(Assets.getText("assets/map.txt"), "assets/tiles.png");
		add(map);
		
		//THE PLAYER
		player = new Player();
		add(player);
		
		
		
		//SET UP COLLECTABLES
		collectables_layer = new FlxGroup();
		add(collectables_layer);
		for (i in 0 ... 10)
		{
			var collectible:FlxSprite = new FlxSprite(Math.random() * map.width, Math.random() * map.height);
			collectible.loadGraphic("assets/collectible.png");
			collectables_layer.add(collectible);
		}
		
		
		//ADD SCORE TEXT
		textScore = new FlxText(0, 0, 50);
		textScore.text = Std.string(FlxG.score);
		add(textScore);
		
		FlxG.playMusic("assets/Sycamore_Drive_-_01_-_Kicks.mp3");
		
		//ADD THE ENEMIES BY THE FUNCTION
		makeEnemies();
		//Make the Camera Follow the Player
		FlxG.camera.follow(player);
		//Set the bound of the world to prevent the player from falling down
		FlxG.worldBounds = new FlxRect(0, 0, map.width, map.height);
		
		
		//Keep the UI in place
		textScore.scrollFactor.x = 0;
		textScore.scrollFactor.y = 0;
		
	}
	
	
	
	override public function destroy():Void
	{
		super.destroy();
	}
	
	private function makeEnemies():Void
	{
		//Make the group for the enemies, add it to the game
		enemyGroup = new FlxGroup();
		add(enemyGroup);
		
		//Make three enemies
		var enemy:Enemy = new Enemy();
		enemy.setTarget(player);
		enemy.x = 500;
		enemy.y = 100;
		enemyGroup.add(enemy);
		
		enemy = new Enemy();
		enemy.setTarget(player);
		enemy.x = 200;
		enemy.y = 500;
		enemyGroup.add(enemy);
		
		enemy = new Enemy();
		enemy.setTarget(player);
		enemy.x = 900;
		enemy.y = 300;
		enemyGroup.add(enemy);
		
	}
	override public function update():Void
	{
		super.update();
		FlxG.collide(map, player);
		FlxG.collide(map, enemyGroup);
		FlxG.overlap(player, enemyGroup, playerHitEnemy, null);
		
		//COLLISION AND THEN DO FUNCTION
		FlxG.overlap(player, collectables_layer, playerHitCollectible);
		
		
		//TO CHECK FOR TOUCH
		if (player.velocity.x > 0)
		{
			//textScore.text = Player.textTouch;
		}
		
		
		
	}	
	
	function playerHitEnemy(playerRef:FlxObject, enemyRef:FlxObject):Void {
		playerRef.flicker();
		enemyGroup.remove(enemyRef);
	}
	
	
	function playerHitCollectible(playerRef:FlxObject, collectibleRef:FlxObject):Void
	{
		collectables_layer.remove(collectibleRef);
		//Score Build in var
		FlxG.score++;
		FlxG.play("Get");
		textScore.text = Std.string(FlxG.score);
	}
}