package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author moop
	 */
	public class RotateyImage extends Image 
	{
		private const RADIAN:Number = Math.PI / 180;
		
		public function RotateyImage(source:*, clipRect:Rectangle=null) 
		{
			super(source, clipRect);
		}
		
		public function setAngle(newAngle:Number, force:Boolean = false):void
		{
			if (newAngle != angle || force)
			{
				const xbx:Number = Math.sin(newAngle * RADIAN);
				const xby:Number = -Math.cos(newAngle * RADIAN);
				
				const ybx:Number = xby;
				const yby:Number = -xbx;
				
				const xo:Number = (xbx - ybx) * -(width / 2);
				const yo:Number = (yby - xby) * -(width / 2);
				
				angle = newAngle;
				x = xo;
				y = yo;
			}
		}
	}
}