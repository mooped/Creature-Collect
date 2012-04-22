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
	public class BackdropSprite extends Entity 
	{
		[Embed(source = '../lib/QuestionMark_1.png')] private static const SPRITE_1:Class;
		[Embed(source = '../lib/QuestionMark_2.png')] private static const SPRITE_2:Class;
		[Embed(source = '../lib/QuestionMark_3.png')] private static const SPRITE_3:Class;
		[Embed(source = '../lib/Arrow_1.png')] private static const SPRITE_4:Class;
		[Embed(source = '../lib/Arrow_2.png')] private static const SPRITE_5:Class;
		[Embed(source = '../lib/Arrow_3.png')] private static const SPRITE_6:Class;
		[Embed(source = '../lib/Tutorial_2.png')] private static const SPRITE_7:Class;
		[Embed(source = '../lib/Tutorial_3.png')] private static const SPRITE_8:Class;
		[Embed(source = '../lib/Tutorial_4.png')] private static const SPRITE_9:Class;
		[Embed(source = '../lib/Tutorial_5.png')] private static const SPRITE_10:Class;
		[Embed(source = '../lib/Success.png')] private static const SPRITE_11:Class;
		[Embed(source = '../lib/Thanks.png')] private static const SPRITE_12:Class;
		
		private static const SPRITES:Array = [
			SPRITE_1, SPRITE_2, SPRITE_3, SPRITE_4, SPRITE_5, SPRITE_6, SPRITE_7, SPRITE_8, SPRITE_9, SPRITE_10, SPRITE_11, SPRITE_12,
		];
		
		public function BackdropSprite(x:Number=0, y:Number=0, sprite:int=0, angle:Number=0)
		{
			super(x, y, null, null);
			var img:RotateyImage = new RotateyImage(SPRITES[sprite]);
			img.setAngle(angle * 180 / Math.PI, true);
			graphic = img;
			graphic.x = -64;
			graphic.y = -64;
		}
		
	}

}