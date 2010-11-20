package chess
{
	import components.RenderComponent;
	/**
	 * ...
	 * @author ...
	 */
	public class BlackSquareRenderComponent extends RenderComponent
	{
		public override function start():void
		{
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0x000000 );
			_baseclip.graphics.drawRect( 0, 0, 25, 25 );
			_baseclip.graphics.endFill();
		}
	}
}
