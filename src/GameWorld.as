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
			
			dataList = xmlData.Planets.children();
			for each (dataElement in dataList)
			{
				switch (dataElement.localName())
				{
					case "Planet":
					{
						add(new Planet(dataElement.@x, dataElement.@y, dataElement.@sprite));
					} break;
					case "BackdropSprite":
					{
						add(new BackdropSprite(dataElement.@x, dataElement.@y, dataElement.@sprite));
					} break;
					case "Player":
					{
						add(new Player(dataElement.@x, dataElement.@y));
					} break;
					case "KnownUniverse":
					{
						minx = dataElement.@x;
						miny = dataElement.@y;
						maxx = dataElement.@width;
						maxy = dataElement.@height;
						maxx += minx;
						maxy += miny;
					} break;
					case "Turtle":
					{
						add(new Creature(dataElement.@x, dataElement.@y, 0, dataElement.@angle));
					} break;
					case "Armadillo":
					{
						add(new Creature(dataElement.@x, dataElement.@y, 1, dataElement.@angle));
					} break;
					case "Kangaroo":
					{
						add(new Creature(dataElement.@x, dataElement.@y, 2, dataElement.@angle));
					} break;
					case "Chicken":
					{
						add(new Creature(dataElement.@x, dataElement.@y, 3, dataElement.@angle));
					} break;
					case "Amoeba":
					{
						add(new Creature(dataElement.@x, dataElement.@y, 4, dataElement.@angle));
					} break;
					case "Yak":
					{
						add(new Creature(dataElement.@x, dataElement.@y, 5, dataElement.@angle));
					} break;
					case "Crocodile":
					{
						add(new Creature(dataElement.@x, dataElement.@y, 6, dataElement.@angle));
					} break;
					case "Fish":
					{
						add(new Creature(dataElement.@x, dataElement.@y, 7, dataElement.@angle));
					} break;
				}
			}
		}
		
		override public function update():void
		{
			super.update();
			VerletEntity.verletTick(this);
		}
		
	}

}