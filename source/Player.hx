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
 class Player extends FlxSprite
{
	public var _jumping:Bool;
	public var _movement:Bool;
	public var _movement2:Bool;
	private var touches : IntHash<Sprite>;
	public static var textTouch:String;
	
	
	public function new() 
	{
		textTouch = "AAAAA";
		 // Declare our touches hash
		touches = new IntHash<Sprite>();
		super();
		this.loadGraphic("assets/player.png",true, true, 25, 34);
		
		_movement = false;
		this.x = 40;
		this.y = 70;
		
		this.addAnimation("default", [0, 1], 3);
		this.addAnimation("jump", [2]);
		this.play("default");
		_jumping = true;
		
		this.acceleration.y = 200;
		//Le Drag Force
		this.drag.x = 100;
		
		//////////////////////////////////////////////////////////////////////////////////////////
		// Multitouch
		/////////////////////////////////////////////////////////////////////////////////////
		
		Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
		Lib.current.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
		//Lib.current.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
		//Lib.current.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
	}
	
	private function onTouchBegin(e:TouchEvent):Void 
	{
		
	
		if (e.stageX > (Lib.current.stage.stageWidth/2))
		{
		_movement	 = true;
		//To check touch
		//textTouch = "AAAAAAAAAAAAAAAAAAAAA";

		}
		
			if (e.stageX < (Lib.current.stage.stageWidth/2))
			{
				_movement2 = true;
				//To check touch
			//textTouch= "BBBBBBBBBBBBBBBBBBBB";
				

			}
	
		
	}
	override public function update():Void 
	{
		super.update();
		
		//PLAYER TOUCH MOVEMENT
		if (_movement2 == true)
		{
			this.velocity.x = -100;
			this.facing = FlxObject.LEFT;
			_movement2 = false;
		}
		
			if (_movement ==true)
		{
			this.velocity.x = 100;
			this.facing = FlxObject.RIGHT;
			_movement = false;
		}
		
		//PLAYER MOVEMENT
		
		
		if (FlxG.keys.LEFT)
		{
			this.velocity.x = -100;
			this.facing = FlxObject.LEFT;
		}
		
		if (FlxG.keys.RIGHT)
		{
			this.velocity.x = 100;
			this.facing = FlxObject.RIGHT;
		}
		//PLAYER JUMP
		if (this.velocity.y == 0 && FlxG.keys.UP)
		{
			this.velocity.y = -130;
			_jumping = true;
			this.play("jump");
		}
		
			if (_jumping && this.velocity.y == 0)
		{
			_jumping = false;
			this.play('default');
		}
	}
	
}


