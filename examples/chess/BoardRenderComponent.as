package chess
{
	import components.RenderComponent;

	public class BoardRenderComponent extends RenderComponent
	{
		public override function start():void
		{
			_baseclip.graphics
			_baseclip.graphics.beginFill( 0xCCCCCC );
			_baseclip.graphics.drawRect( 0, 0, 800, 600 );
			_baseclip.graphics.endFill();
		}
	}
}