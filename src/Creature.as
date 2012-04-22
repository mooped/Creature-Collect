package  
{
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author moop
	 */
	public class Creature extends VerletEntity 
	{
		[Embed(source = '../lib/Animal_1.png')] private const CREATURE_1:Class;
		[Embed(source = '../lib/Animal_2.png')] private const CREATURE_2:Class;
		[Embed(source = '../lib/Animal_3.png')] private const CREATURE_3:Class;
		[Embed(source = '../lib/Animal_4.png')] private const CREATURE_4:Class;
		private const SPRITES:Array = [
			CREATURE_1, CREATURE_2, CREATURE_3, CREATURE_4,
		];
		
		private var image:RotateyImage;
		
		public function Creature(x:Number=0, y:Number=0, sprite:int=0, angle:Number=0)
		{
			super(x, y);
			image = new RotateyImage(SPRITES[sprite]);
			radius = image.width * 0.25;
			image.setAngle(angle * 180 / Math.PI, true);
			graphic = image;
		}
		
	}

}