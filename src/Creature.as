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
		[Embed(source = '../lib/Animal_1.png')] private static const CREATURE_1:Class;
		[Embed(source = '../lib/Animal_2.png')] private static const CREATURE_2:Class;
		[Embed(source = '../lib/Animal_3.png')] private static const CREATURE_3:Class;
		[Embed(source = '../lib/Animal_4.png')] private static const CREATURE_4:Class;
		[Embed(source = '../lib/Animal_5.png')] private static const CREATURE_5:Class;
		[Embed(source = '../lib/Animal_6.png')] private static const CREATURE_6:Class;
		[Embed(source = '../lib/Animal_7.png')] private static const CREATURE_7:Class;
		[Embed(source = '../lib/Animal_8.png')] private static const CREATURE_8:Class;
		private static const SPRITES:Array = [
			CREATURE_1, CREATURE_2, CREATURE_3, CREATURE_4, CREATURE_5, CREATURE_6, CREATURE_7, CREATURE_8,
		];
		
		private var image:RotateyImage;
		public var creatureType:int = -1;
		
		public static function getSprite(id:int):RotateyImage
		{
			var img:RotateyImage = new RotateyImage(SPRITES[id]);
			img.setAngle(0);
			return img;
		}
		
		public function Creature(x:Number=0, y:Number=0, sprite:int=0, angle:Number=0)
		{
			super(x, y);
			image = new RotateyImage(SPRITES[sprite]);
			radius = image.width * 0.25;
			image.setAngle(angle * 180 / Math.PI, true);
			graphic = image;
			creatureType = sprite;
		}
		
		override public function update():void
		{
			if (isNaN(spin)) spin = 0;
			image.setAngle(image.angle + spin);
			super.update();
		}
	}

}