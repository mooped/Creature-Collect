package  
{
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author moop
	 */
	public class Creature extends VerletEntity 
	{
		[Embed(source = '../lib/Creature_1.png')] private const CREATURE_1:Class;
		[Embed(source = '../lib/Creature_2.png')] private const CREATURE_2:Class;
		[Embed(source = '../lib/Creature_3.png')] private const CREATURE_3:Class;
		[Embed(source = '../lib/Creature_4.png')] private const CREATURE_4:Class;
		private const SPRITES:Array = [
			CREATURE_1, CREATURE_2, CREATURE_3, CREATURE_4,
		];
		
		public function Creature(x:Number=0, y:Number=0, sprite:int=0) 
		{
			super(x, y);
			
		}
		
	}

}