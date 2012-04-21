package  
{
	import net.flashpunk.World;
	import VerletEntity;
	
	/**
	 * ...
	 * @author moop
	 */
	public class GameWorld extends World 
	{
		
		public function GameWorld() 
		{
			super();
			camera.x = -400;
			camera.y = -300;
			
			add(new Planet(0, 0, 0));
			add(new Planet(-400, -750, 1));
			add(new Planet(1000, -800, 2));
			add(new Planet(170, -600, 3));
			add(new Planet(900, -100, 4));
			add(new Planet(-600, 300, 5));
			add(new Planet(200, 450, 3));
			add(new Planet(-300, 600, 1));
			add(new Planet(800, 500, 5));
			
			add(new Player(0, 0));
		}
		
		override public function update():void
		{
			super.update();
			VerletEntity.verletTick(this);
		}
		
	}

}