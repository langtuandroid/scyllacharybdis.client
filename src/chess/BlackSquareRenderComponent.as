package chess
{
	import components.RenderComponent;
	/**
	 * ...
	 * @author ...
	 */
	public class BlackSquareRenderComponent extends RenderComponent
	{
		public override function awake():void
		{
			_baseclip.graphics.beginFill( 0x222222 );
			_baseclip.graphics.drawRect( 0, 0, 50, 50 );
			_baseclip.graphics.endFill();
		}
		
		public override function destroy():void 
		{
			_baseclip.graphics.clear();
		}
	}
}
