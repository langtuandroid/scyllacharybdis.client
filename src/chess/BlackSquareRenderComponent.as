package chess
{
	import com.scyllacharybdis.components.MovieClipComponent;

	/**
	 * ...
	 * @author ...
	 */
	public class BlackSquareRenderComponent extends MovieClipComponent
	{
		public override function awake():void
		{
			baseclip.graphics.beginFill( 0x222222 );
			baseclip.graphics.drawRect( 0, 0, 50, 50 );
			baseclip.graphics.endFill();
		}
		
		public override function destroy():void 
		{
			baseclip.graphics.clear();
		}
	}
}
