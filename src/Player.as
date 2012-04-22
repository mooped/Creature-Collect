package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import GameWorld;
	import RotateyImage;
	
	/**
	 * ...
	 * @author moop
	 */
	public class Player extends VerletEntity 
	{
		private const RADIAN:Number = Math.PI / 180;
		
		[Embed(source = '../lib/Ship_No_Thrusters.png')] private const PLAYER_STILL:Class;
		[Embed(source = '../lib/Ship_Thrusters.png')] private const PLAYER_THRUST:Class;
		
		[Embed(source = '../lib/Tutorial_1.png')] private const TUTORIAL:Class;

		private var still:RotateyImage = new RotateyImage(PLAYER_STILL);
		private var thrust:RotateyImage = new RotateyImage(PLAYER_THRUST);
		private var tutorial:RotateyImage = new RotateyImage(TUTORIAL);
		private var graphics:Graphiclist;
		
		private var thrusting:Boolean = false;
		private var turn:Number = 0;
		
		private var initx:Number = 0;
		private var inity:Number = 0;
		private var angle:Number = 0;
		
		private var idle:int = 0;
		private var tutorialActive:Boolean = true;
		
		public function Player(x:Number=0, y:Number=0)
		{
			super(x, y, null, null);
			initx = x;
			inity = y;
			
			thrusting = false;
			angle = 0;
			turn = 0;
			
			updateAngles(true);
			
			graphics = new Graphiclist(still);
			graphic = graphics;
			radius = still.width * 0.45;
			
			Input.define("Thrust", Key.W);
			Input.define("Left", Key.A);
			Input.define("Right", Key.D);
		}
		
		override public function update():void
		{
			checkInput();
			
			updateTutorial();
			updateAngles();
			
			applyThrust();
			
			checkBounds();
			
			updateGraphics();
			updateCamera();
		}
		
		public function checkInput():void
		{			
			if (Input.pressed("Thrust"))
			{
				thrusting = true;
				resetTutorial();
			}
			if (Input.released("Thrust"))
			{
				thrusting = false;
				resetTutorial();
			}
			
			if (Input.pressed("Left"))
			{
				turn = +4;
				resetTutorial();
			}
			else if (Input.pressed("Right"))
			{
				turn = -4;
				resetTutorial();
			}
			else if (Input.released("Left") || Input.released("Right"))
			{
				turn = 0;
			}
		}
		
		public function resetTutorial():void
		{
			idle = 0;
			tutorialActive = false;
		}
		
		public function updateTutorial():void
		{
			const idleThreshold:int = 600;
			
			++idle;
			
			if (idle > idleThreshold)
			{
				tutorialActive = true;
			}
		}
		
		public function updateAngles(force:Boolean=false):void
		{
			angle += turn;
			still.setAngle(angle, force);
			thrust.setAngle(angle, force);
			tutorial.setAngle(angle, force);
		}
		
		public function applyThrust():void
		{
			if (thrusting)
			{
				addForce(-Math.sin(angle * RADIAN), -Math.cos(angle * RADIAN));
			}
		}
		
		public function checkBounds():void
		{
			const w:GameWorld = world as GameWorld;
			var out:Boolean = false;
			if (x < w.minx)
			{
				x = w.minx;
				out = true;
			}
			if (y < w.miny)
			{
				y = w.miny;
				out = true;
			}
			if (x > w.maxx)
			{
				x = w.maxx;
				out = true;
			}
			if (y > w.maxy)
			{
				y = w.maxy;
				out = true;
			}
			
			if (out)
			{
				const dist:Number = distanceToPoint(initx, inity);
				const force:Number = -32;
				addForce(force * (x - initx) / dist, force * (y - inity) / dist)
			}
		}
		
		public function updateGraphics():void
		{
			graphics.removeAll();
			if (thrusting)
			{
				graphics.add(thrust);
			}
			else
			{
				graphics.add(still);
			}
			if (tutorialActive)
			{
				graphics.add(tutorial);
			}
		}
		
		public function updateCamera():void
		{
			world.camera.x = x - 400;
			world.camera.y = y - 300;
		}
		
	}
	
}