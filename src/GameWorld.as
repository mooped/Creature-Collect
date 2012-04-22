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
		[Embed(source = "../lib/Tutorial.oel", mimeType = "application/octet-stream")] private static const TUTORIAL:Class;
		[Embed(source = "../lib/Level1.oel", mimeType = "application/octet-stream")] private static const LEVEL1:Class;
		[Embed(source = "../lib/Level2.oel", mimeType = "application/octet-stream")] private static const LEVEL2:Class;
		[Embed(source = "../lib/Level3.oel", mimeType = "application/octet-stream")] private static const LEVEL3:Class;
		
		private static const LEVELS:Array = [TUTORIAL, LEVEL1, LEVEL2, LEVEL3];
		
		public var minx:Number = 0;
		public var miny:Number = 0;
		public var maxx:Number = 2400;
		public var maxy:Number = 1800;
		
		public var next:int = -1;
		public var splashDelay:int = -1;
		
		public function GameWorld(level:int=0) 
		{
			super();
			camera.x = -400;
			camera.y = -300;
			
			loadUniverse(LEVELS[level]);
		}
		
		private function loadUniverse(source:Class):void
		{
			var rawData:ByteArray = new source;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			
			var dataList:XMLList;
			var dataElement:XML;
			
			next = xmlData.@Next;
			trace("Next level: ", next);
			
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
					case "Freighter":
					{
						add(new Trader(dataElement.@x, dataElement.@y, dataElement.@wanted1, dataElement.@wanted2, dataElement.@wanted3));
					} break;
				}
			}
		}
		
		override public function update():void
		{
			super.update();
			VerletEntity.verletTick(this);
			
			if (splashDelay == -1)
			{
				var traderList:Array = [];
				getClass(Trader, traderList);
				
				var complete:Boolean = true;
				for each (var t:Trader in traderList)
				{
					if (!t.full)
					{
						complete = false;
					}
				}
				
				if (complete)
				{
					removeAll();
					camera.x = 0;
					camera.y = 0;
					if (next == -1)
					{
						add(new BackdropSprite(400 - 128, 300 - 128, 11));
						splashDelay = 100;
					}
					else
					{
						add(new BackdropSprite(400 - 128, 300 - 128, 10));
						splashDelay = 100;
					}
				}
			}
			else
			{
				if (splashDelay == 0)
				{
					removeAll();
					if (next < 0) next = 0;
					loadUniverse(LEVELS[next]);
					splashDelay = -1;
				}
				else
				{
					--splashDelay;
				}
			}
		}
		
	}

}