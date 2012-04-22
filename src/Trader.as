package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	
	import Creature;
	
	/**
	 * ...
	 * @author moop
	 */
	public class Trader extends Entity 
	{
		[Embed(source = '../lib/Freighter_1.png')] private const TRADER:Class;
		[Embed(source = '../lib/Wanted_1.png')] private const WANTED:Class;
		[Embed(source = '../lib/Full_1.png')] private const FULL:Class;
		
		private var images:Graphiclist;
		
		public var full:Boolean = false;
		
		private var wanted1:int;
		private var wanted2:int;
		private var wanted3:int;
		
		public function Trader(x:Number=0, y:Number=0, t1:int=-1, t2:int=-1, t3:int=-1) 
		{
			super(x, y, null, null);
			var trader:RotateyImage = new RotateyImage(TRADER);
			var wanted:RotateyImage = new RotateyImage(WANTED);

			trader.setAngle(0, true);
			wanted.setAngle(0, true);
			images = new Graphiclist(trader, wanted);
			graphic = images;
			
			wanted1 = t1;
			wanted2 = t2;
			wanted3 = t3;
			
			addImage(wanted1, 32, 32);
			addImage(wanted2, 64, 32);
			addImage(wanted3, 94, 32);
		}
		
		public function addImage(id:int, ox:Number, oy:Number):void
		{
			if (id >= 0)
			{
				var creature:Image = Creature.getSprite(id);
				creature.x += ox;
				creature.y += oy;
				images.add(creature);
			}
		}
		
		public function updateWanted():void
		{
			for (var i:int = 2; i < images.count; ++i)
			{
				images.removeAt(i);
			}
			addImage(wanted1, 32, 32);
			addImage(wanted2, 64, 32);
			addImage(wanted3, 94, 32);
		}
		
		override public function update():void
		{
			const radius:Number = 128;
			var creatureList:Array = [];
			world.getClass(Creature, creatureList);
			
			var got1:Boolean = (wanted1 == -1);
			var got2:Boolean = (wanted2 == -1);
			var got3:Boolean = (wanted3 == -1);
			var creature1:Creature = null;
			var creature2:Creature = null;
			var creature3:Creature = null;
			
			for each (var creature:Creature in creatureList)
			{
				if (distanceFrom(creature) < radius)
				{
					if (!got1 && creature.creatureType == wanted1)
					{
						creature1 = creature;
						wanted1 = -1;
						world.remove(creature1);
						got1 = true;
						updateWanted();
					}
					else if (!got2 && creature.creatureType == wanted2)
					{
						creature2 = creature;
						wanted2 = -1
						world.remove(creature2);
						got2 = true;
						updateWanted();
					}
					else if (!got3 && creature.creatureType == wanted3)
					{
						creature3 = creature;
						wanted3 = -1
						world.remove(creature3);
						got3 = true;
						updateWanted();
					}
				}
			}
			
			if (got1 && got2 && got3)
			{
				/*
				if (creature1)
				{
					world.remove(creature1);
				}
				if (creature2)
				{
					world.remove(creature2);
				}
				if (creature3)
				{
					world.remove(creature3);
				}
				*/
				full = true;
				var fullIcon:RotateyImage = new RotateyImage(FULL);
				fullIcon.setAngle(0, true);
				images.removeAt(1);
				images.add(fullIcon);
			}
		}
	}
}