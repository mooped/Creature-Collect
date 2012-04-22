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
		
		public var minx:Number = 0;
		public var miny:Number = 0;
		public var maxx:Number = 0;
		public var maxy:Number = 0;
		
		public function GameWorld() 
		{
			super();
			camera.x = -400;
			camera.y = -300;
			
			loadUniverse(UNIVERSE);
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
			
			dataList = xmlData.Planets.BackdropSprite;
			for each (dataElement in dataList)
			{
				add(new BackdropSprite(dataElement.@x, dataElement.@y, dataElement.@sprite));
			}			
			
			dataList = xmlData.Planets.Player;
			for each (dataElement in dataList)
			{
				add(new Player(dataElement.@x, dataElement.@y));
			}
			
			dataList = xmlData.Planets.KnownUniverse;
			for each (dataElement in dataList)
			{
				minx = dataElement.@x;
				miny = dataElement.@y;
				maxx = dataElement.@width;
				maxy = dataElement.@height;
				maxx += minx;
				maxy += miny;
				trace(minx, miny, maxx, maxy);
			}
		}
		
		override public function update():void
		{
			super.update();
			VerletEntity.verletTick(this);
		}
		
	}

}