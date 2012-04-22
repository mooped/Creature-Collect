package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author moop
	 */
	public class Planet extends Entity 
	{
		[Embed(source = '../lib/Planet_1.png')] private const PLANET_1:Class;
		[Embed(source = '../lib/Planet_2.png')] private const PLANET_2:Class;
		[Embed(source = '../lib/Planet_3.png')] private const PLANET_3:Class;
		[Embed(source = '../lib/Planet_4.png')] private const PLANET_4:Class;
		[Embed(source = '../lib/Planet_5.png')] private const PLANET_5:Class;
		[Embed(source = '../lib/Planet_6.png')] private const PLANET_6:Class;
		private const SPRITES:Array = [
			PLANET_1, PLANET_2, PLANET_3, PLANET_4, PLANET_5, PLANET_6,
		];
		
		public var gravityDist:Number = 512;
		public var gravity:Number = 1;
		
		public var radius:Number = 0;
		
		public function Planet(x:Number=0, y:Number=0, sprite:int=0) 
		{
			super(x, y, null, null);
			
			var image:Image = new Image(SPRITES[sprite]);
			radius = image.width * 0.25;
			graphic = image;
			graphic.x -= 128;
			graphic.y -= 128;
			
			setHitbox(256, 256, -128, -128);
		}
		
		override public function update():void
		{
			var verlets:Array = [];
			world.getClass(VerletEntity, verlets);
			
			for each (var e:VerletEntity in verlets)
			{
				var dist:Number = distanceFrom(e);
				if (dist != 0 && dist < gravityDist)
				{
					var invdist:Number = 1.0 / dist;
					var ax:Number = ((x - e.x) * invdist) * (1 - (dist / gravityDist)) * gravity;
					var ay:Number = ((y - e.y) * invdist) * (1 - (dist / gravityDist)) * gravity;
					e.addForce(ax, ay);
				}
			}
		}
		
	}

}