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
		
		public function Planet(x:Number=0, y:Number=0, sprite:int=0) 
		{
			super(x, y, null, null);
			
			graphic = new Image(SPRITES[sprite]);
			graphic.x -= 128;
			graphic.y -= 128;
		}
		
	}

}