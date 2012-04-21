package  
{
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author moop
	 */
	public class GameWorld extends World 
	{
		
		public function GameWorld() 
		{
			super();
			add(new Planet);
		}
		
	}

}