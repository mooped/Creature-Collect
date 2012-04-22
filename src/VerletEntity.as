package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author moop
	 */
	public class VerletEntity extends Entity 
	{
		private static const TIMESTEP:Number = 0.5;
		
		private var xo:Number;
		private var yo:Number;
		private var ax:Number;
		private var ay:Number;
		
		protected var radius:Number = 0;
		
		public function VerletEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			xo = x;
			yo = y;
			ax = 0;
			ay = 0;
		}
		
		public static function verletTick(world:World):void
		{
			var verletList:Array = [];
			world.getClass(VerletEntity, verletList);
			
			var planetList:Array = [];
			world.getClass(Planet, planetList);
			
			for (var i:int = 0; i < 1; ++i)
			{
				verlet(verletList);
				satisfyConstraints(verletList, planetList);
				accumulateForces(verletList);
				applyFriction(verletList);
			}
		}
		
		private static function verlet(verletList:Array):void
		{
			for each (var e:VerletEntity in verletList)
			{
				var tempx:Number = e.x;
				var tempy:Number = e.y;
				
				e.x = e.x + (e.x - e.xo + e.ax * TIMESTEP * TIMESTEP);
				e.y = e.y + (e.y - e.yo + e.ay * TIMESTEP * TIMESTEP);
				
				e.xo = tempx;
				e.yo = tempy;
			
				e.ax = 0;
				e.ay = 0;
			}
		}
		
		private static function satisfyConstraints(verletList:Array, planetList:Array):void
		{
			const len:int = verletList.length;
			for (var i:int = 0; i < len; ++i)
			{
				for (var j:int = 0; j < i; ++j)
				{
					satisfyRadiusConstraint(verletList[i], verletList[j]);
				}
				for each (var planet:Planet in planetList)
				{
					satisfyPlanetConstraint(verletList[i], planet);
				}
			}
		}
		
		private static function satisfyRadiusConstraint(a:VerletEntity, b:VerletEntity):void
		{
			const dist:Number = a.distanceFrom(b);
			if (dist <= (a.radius + b.radius))
			{
				const dx:Number = (b.x - a.x) / dist;
				const dy:Number = (b.y - a.y) / dist;
				const radius:Number = a.radius + b.radius;
				a.x = b.x - dx * radius;
				a.y = b.y - dy * radius;
				b.x = a.x + dx * radius;
				b.y = a.y + dy * radius;
			}
		}
		
		private static function satisfyPlanetConstraint(a:VerletEntity, b:Planet):void
		{
			const dist:Number = a.distanceFrom(b);
			if (dist <= (a.radius + b.radius))
			{
				const dx:Number = (b.x - a.x) / dist;
				const dy:Number = (b.y - a.y) / dist;
				const radius:Number = a.radius + b.radius;
				a.x = b.x - dx * radius;
				a.y = b.y - dy * radius;
			}
		}
		
		private static function accumulateForces(verletList:Array):void
		{
			
		}
		
		private static function applyFriction(verletList:Array):void
		{
			
		}
		
		public function addForce(x:Number = 0, y:Number = 0):void
		{
			ax += x;
			ay += y;
		}
	}

}