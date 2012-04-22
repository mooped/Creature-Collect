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
		
		private static const SPRITES:Array = [
			SPRITE_1, SPRITE_2, SPRITE_3
		];
		
		public function BackdropSprite(x:Number=0, y:Number=0, sprite:int=0)
		{
			super(x, y, null, null);
			graphic = new Image(SPRITES[sprite]);
			graphic.x = -64;
			graphic.y = -64;
		}
		
	}

}