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
		private static const RADIAN:Number = Math.PI / 180;
		
		private static const BRAKE_FACTOR:Number = 0.75;
		
		[Embed(source = '../lib/Ship_No_Thrusters.png')] private const PLAYER_STILL:Class;
		[Embed(source = '../lib/Ship_Thrusters.png')] private const PLAYER_THRUST:Class;
		[Embed(source = '../lib/TractorBeam.png')] private const PLAYER_BEAM:Class;
		
		[Embed(source = '../lib/Tutorial_1.png')] private const TUTORIAL:Class;
		
		private var still:RotateyImage = new RotateyImage(PLAYER_STILL);
		private var thrust:RotateyImage = new RotateyImage(PLAYER_THRUST);
		private var beam:RotateyImage = new RotateyImage(PLAYER_BEAM);
		private var tutorial:RotateyImage = new RotateyImage(TUTORIAL);
		private var graphics:Graphiclist;
		
		private var thrusting:Boolean = false;
		private var braking:Boolean = false;
		private var turn:Number = 0;
		private var beaming:Boolean = false;
		
		private var beamEntity:Creature = null;
		
		private var angle:Number = 0;
		
		private var idle:int = 0;
		private var tutorialActive:Boolean = true;
		
		public function Player(x:Number=0, y:Number=0)
		{
			super(x, y, null, null);
			
			thrusting = false;
			braking = false;
			angle = 0;
			turn = 0;
			
			updateAngles(true);
			
			graphics = new Graphiclist(still);
			graphic = graphics;
			radius = still.width * 0.45;
			
			Input.define("Thrust", Key.W);
			Input.define("Brake", Key.S);
			Input.define("Left", Key.A);
			Input.define("Right", Key.D);
			Input.define("Beam", Key.SPACE);
			Input.define("Release", Key.Q);
		}
		
		override public function update():void
		{
			checkInput();
			
			updateTutorial();
			updateAngles();
			
			updateBeam();
			applyThrust();
			
			updateGraphics();
			updateCamera();
			
			super.update();
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
			}
			
			if (Input.pressed("Brake"))
			{
				braking = true;
				resetTutorial();
			}
			if (Input.released("Brake"))
			{
				braking = false;
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
			
			if (Input.pressed("Beam"))
			{
				beaming = true;
			}
			else if (Input.released("Beam"))
			{
				beaming = false;
			}
			
			if (Input.pressed("Release"))
			{
				if (beamEntity)
				{
					beamEntity.stop(0.3);
					beamEntity = null;
				}
				beaming = false;
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
			beam.setAngle(angle, force);
			tutorial.setAngle(angle, force);
		}
		
		public function updateBeam():void
		{
			const beamDist:Number = 64;
			const beamForce:Number = 10;
			const releaseDist:Number = 64;
			var refx:Number;
			var refy:Number;
			var dx:Number;
			var dy:Number;
			var dist:Number;
			
			if (beaming || beamEntity)
			{
				refx = x + Math.sin(angle * RADIAN) * beamDist;
				refy = y + Math.cos(angle * RADIAN) * beamDist;
			}
			
			if (beaming && beamEntity == null)
			{
				var creatureList:Array = [];
				world.getClass(Creature, creatureList);
				
				const radius:Number = 64;
				var best:Creature = null;
				var bestDist:Number = radius;
				for each (var creature:Creature in creatureList)
				{
					dx = creature.x - refx;
					dy = creature.y - refy;
					dist = Math.sqrt(dx * dy + dy * dy);
					if (dist < bestDist)
					{
						best = creature;
						bestDist = dist;
					}
				}
				if (best != null)
				{
					beamEntity = best;
					beaming = true;
					beamEntity.stop(0.5);
				}
			}
				
			if (beamEntity)
			{
				dx = refx - beamEntity.x;
				dy = refy - beamEntity.y;
				dist = Math.sqrt(dx * dx + dy * dy);
				const invDist:Number = 1.0 / dist;
				beamEntity.stop(0.5);
				beamEntity.addForce(dx * invDist * Math.max(dist * 0.5, beamForce), dy * invDist * Math.max(dist * 0.5, beamForce));
				if (dist > releaseDist)
				{
					beamEntity = null;
				}
			}
		}
		
		public function applyThrust():void
		{
			if (thrusting)
			{
				addForce(-Math.sin(angle * RADIAN), -Math.cos(angle * RADIAN));
			}
			if (braking)
			{
				addForce(Math.sin(angle * RADIAN) * BRAKE_FACTOR, Math.cos(angle * RADIAN) * BRAKE_FACTOR);
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
			if (beaming || beamEntity != null)
			{
				graphics.add(beam);
			}
		}
		
		public function updateCamera():void
		{
			world.camera.x = x - 400;
			world.camera.y = y - 300;
		}
		
	}
	
}