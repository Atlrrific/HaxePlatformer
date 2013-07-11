package ;
import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;
import nme.events.Event;
import nme.events.TouchEvent;
import nme.Lib;
import nme.ui.Multitouch;
import nme.ui.MultitouchInputMode;
import nme.display.Sprite;
import org.flixel.FlxGame;
/**
 * ...
 * @author Atl Arredondo
 */
 class Enemy extends FlxSprite
{
	public var _jumping:Bool;
	public var _movement:Bool;
	public var _movement2:Bool;
	private var touches : IntHash<Sprite>;
	public static var textTouch:String;
	private var targ:FlxSprite;
	
	public function new() 
	{
		super();
		this.loadGraphic("assets/enemy.png", true, true, 25, 34);
		
		
		this.addAnimation("default", [0, 1], 3);
		this.addAnimation("jump", [2]);
		this.play("default");
		_jumping = true;
		
		this.acceleration.y = 200;
		//Le Drag Force
		this.drag.x = 100;
		
	}
	
	public function setTarget(t:FlxSprite)
	{
		targ = t;
	}
	private function onTouchBegin(e:TouchEvent):Void 
	{
		
		
	}
	override public function update():Void 
	{
		//Distance from the target
		var distX:Float = this.x - targ.x;
		var distY:Float = this.y - targ.y;
		
		if (distX > 0)
		{
			this.velocity.y = -50;
			this.facing = FlxObject.RIGHT;
			
		}
		else {
			this.velocity.x = 50;
			this.facing = FlxObject.RIGHT;
		}
		
		if(distY > 0 && !_jumping)
		{
			this.velocity.y = -150;
			this.play('jump');
			_jumping  = true;
		}
		
		
		if (_jumping && this.velocity.y == 0)
		{
			_jumping = false;
			this.play('default');
		}
	}
	
}
