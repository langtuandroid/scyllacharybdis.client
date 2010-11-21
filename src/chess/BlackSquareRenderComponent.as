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
			_baseclip.graphics.beginFill( 0x222222 );
			_baseclip.graphics.drawRect( 0, 0, 50, 50 );
			_baseclip.graphics.endFill();
		}
	}
}
