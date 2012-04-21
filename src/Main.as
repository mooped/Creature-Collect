package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author moop
	 */
	public class Main extends Engine
	{
		
		public function Main():void 
		{
			super(800, 600, 60, false);
			
			FP.world = new GameWorld;
		}
		
		override public function init():void 
		{
			trace("Started");
		}
		
	}
	
}