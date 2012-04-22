package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
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

		private var still:RotateyImage = new RotateyImage(PLAYER_STILL);
		private var thrust:RotateyImage = new RotateyImage(PLAYER_THRUST);
		
		private var thrusting:Boolean = false;
		private var turn:Number = 0;
		
		private var initx:Number = 0;
		private var inity:Number = 0;
		private var angle:Number = 0;
		
		public function Player(x:Number=0, y:Number=0)
		{
			super(x, y, null, null);
			initx = x;
			inity = y;
			
			thrusting = false;
			angle = 0;
			turn = 0;
			
			updateAngles(true);
			graphic = still;
			radius = still.width * 0.45;
			
			Input.define("Thrust", Key.W);
			Input.define("Left", Key.A);
			Input.define("Right", Key.D);
		}
		
		override public function update():void
		{
			checkInput();
			
			updateAngles();
			
			applyThrust();
			
			checkBounds();
			
			updateCamera();
		}
		
		public function checkInput():void
		{			
			if (Input.pressed("Thrust"))
			{
				thrusting = true;
				graphic = thrust;
			}
			if (Input.released("Thrust"))
			{
				thrusting = false;
				graphic = still;
			}
			
			if (Input.pressed("Left"))
			{
				turn = +4;
			}
			else if (Input.pressed("Right"))
			{
				turn = -4;
			}
			else if (Input.released("Left") || Input.released("Right"))
			{
				turn = 0;
			}
		}
		
		public function updateAngles(force:Boolean=false):void
		{
			angle += turn;
			still.setAngle(angle, force);
			thrust.setAngle(angle, force);
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
		
		public function updateCamera():void
		{
			world.camera.x = x - 400;
			world.camera.y = y - 300;
		}
		
	}

}