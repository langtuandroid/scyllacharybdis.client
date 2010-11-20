package  
{
	import components.RenderComponent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Daniel Lamb
	 */
	public class SquareRenderComponent extends RenderComponent
	{
		public override function start():void
		{
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0x123456 );
			_baseclip.graphics.drawRect( 0, 0, 200, 200 );
			_baseclip.graphics.endFill();
		}
	}

}