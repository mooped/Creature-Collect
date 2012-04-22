package  
{
	import flash.utils.ByteArray;
	import net.flashpunk.World;
	import VerletEntity;
	
	/**
	 * ...
	 * @author moop
	 */
	public class GameWorld extends World 
	{
		[Embed(source = "../lib/Universe.oel", mimeType = "application/octet-stream")] private static const UNIVERSE:Class;
		
		public function GameWorld() 
		{
			super();
			camera.x = -400;
			camera.y = -300;
			
			loadUniverse(UNIVERSE);
			
			/*
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
			*/
		}
		
		private function loadUniverse(source:Class):void
		{
			var rawData:ByteArray = new source;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			dataList = xmlData.Planets.Planet;
			for each (dataElement in dataList)
			{
				add(new Planet(dataElement.@x, dataElement.@y, dataElement.@Sprite));
			}
			
			dataList = xmlData.Planets.Player;
			for each (dataElement in dataList)
			{
				add(new Player(dataElement.@x, dataElement.@y));
			}
		}
		
		override public function update():void
		{
			super.update();
			VerletEntity.verletTick(this);
		}
		
	}

}