package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author moop
	 */
	public class VerletEntity extends Entity 
	{
		private static const TIMESTEP:Number = 1;
		private var xo:Number;
		private var yo:Number;
		private var ax:Number;
		private var ay:Number;
		
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
			
			verlet(verletList);
			satisfyConstraints(verletList);
			accumulateForces(verletList);
			applyFriction(verletList);
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
		
		private static function satisfyConstraints(verletList:Array):void
		{
			
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