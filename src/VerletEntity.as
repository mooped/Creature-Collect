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
		
		private var initx:Number = 0;
		private var inity:Number = 0;
		
		protected var radius:Number = 0;
		
		protected var spin:Number = 0;
		
		public function VerletEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			xo = x;
			yo = y;
			ax = 0;
			ay = 0;
			initx = x;
			inity = y;
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
				
				e.spin *= 0.99;
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
				const vx:Number = a.x - a.xo;
				const vy:Number = a.y - a.yo;
				const v:Number = Math.sqrt(vx * vx + vy * vy);
				const vxn:Number = vx / v;
				const vyn:Number = vy / v;
				a.spin -= (dx * vxn + dy * vyn) * v;
			}
		}
		
		private static function accumulateForces(verletList:Array):void
		{
			
		}
		
		public function addForce(x:Number = 0, y:Number = 0):void
		{
			ax += x;
			ay += y;
		}
		
		public function stop(amount:Number=0):void
		{
			xo = x - amount * (x - xo);
			yo = y - amount * (y - yo);
		}
		
		override public function update():void 
		{
			super.update();
			
			stop(0.999);
			
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
	}

}