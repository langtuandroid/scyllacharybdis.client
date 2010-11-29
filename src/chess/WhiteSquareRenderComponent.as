package chess
{
	import components.RenderComponent;

	public class WhiteSquareRenderComponent  extends RenderComponent
	{
		public override function awake():void
		{
			_baseclip.graphics.beginFill( 0xDDDDDD );
			_baseclip.graphics.drawRect( 0, 0, 50, 50 );
			_baseclip.graphics.endFill();
		}
		
		public override function destroy():void 
		{
			_baseclip.graphics.clear();
		}
	}
}
