package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author moop
	 */
	public class Player extends VerletEntity 
	{
		private const RADIAN:Number = Math.PI / 180;
		
		[Embed(source = '../lib/Ship_No_Thrusters.png')] private const PLAYER_STILL:Class;
		[Embed(source = '../lib/Ship_Thrusters.png')] private const PLAYER_THRUST:Class;

		private var m_still:Image = new Image(PLAYER_STILL);
		private var m_thrust:Image = new Image(PLAYER_THRUST);
		
		private var thrusting:Boolean = false;
		private var turn:Number = 0;
		
		private var angle:Number = 0;
		
		public function Player(x:Number=0, y:Number=0)
		{
			super(x, y, null, null);
			
			thrusting = false;
			angle = 0;
			turn = 0;
			updateAngle(true);
			
			graphic = m_still;
			
			Input.define("Thrust", Key.W);
			Input.define("Left", Key.A);
			Input.define("Right", Key.D);
		}
		
		override public function update():void
		{
			checkInput();
			
			updateAngle();
			
			applyThrust();
			applyGravity();
			
			updateCamera();
		}
		
		public function checkInput():void
		{			
			if (Input.pressed("Thrust"))
			{
				thrusting = true;
				graphic = m_thrust;
			}
			if (Input.released("Thrust"))
			{
				thrusting = false;
				graphic = m_still;
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
		
		public function updateAngle(force:Boolean=false):void
		{
			var oldangle:Number = angle;
			angle += turn;
			if (angle != oldangle || force)
			{
				const xbx:Number = Math.sin(angle * RADIAN);
				const xby:Number = -Math.cos(angle * RADIAN);
				
				const ybx:Number = xby;
				const yby:Number = -xbx;
				
				const xo:Number = (xbx - ybx) * -32;
				const yo:Number = (yby - xby) * -32;
				
				m_thrust.angle = angle;
				m_thrust.x = xo;
				m_thrust.y = yo;
				
				m_still.angle = angle;
				m_still.x = xo;
				m_still.y = yo;
			}
		}
		
		public function applyThrust():void
		{
			if (thrusting)
			{
				addForce(-Math.sin(angle * RADIAN), -Math.cos(angle * RADIAN));
			}
		}
		
		public function applyGravity():void
		{
			var planets:Array = [];
			world.getClass(Planet, planets);
			
			for each (var planet:Planet in planets)
			{
				var dist:Number = distanceFrom(planet);
				if (dist != 0 && dist < planet.gravityDist)
				{
					var invdist:Number = 1.0 / dist;
					var ax:Number = ((x - planet.x) * invdist) * (1 - (dist / planet.gravityDist)) * planet.gravity;
					var ay:Number = ((y - planet.y) * invdist) * (1 - (dist / planet.gravityDist)) * planet.gravity;
					//addForce(-ax, -ay);
				}
			}
		}
		
		public function updateCamera():void
		{
			world.camera.x = x - 400;
			world.camera.y = y - 300;
		}
		
	}

}