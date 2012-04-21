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
			add(new Planet(100, 130, 0));
			add(new Planet(470, 50, 1));
			add(new Planet(170, 330, 2));
			add(new Planet(300, 410, 3));
			add(new Planet(700, 220, 4));
			add(new Planet(623, 450, 5));
		}
		
	}

}