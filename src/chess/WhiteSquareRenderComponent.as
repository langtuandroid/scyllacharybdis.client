package chess
{
	import com.scyllacharybdis.components.MovieClipComponent;

	public class WhiteSquareRenderComponent  extends MovieClipComponent
	{
		public override function awake():void
		{
			baseclip.graphics.beginFill( 0xDDDDDD );
			baseclip.graphics.drawRect( 0, 0, 50, 50 );
			baseclip.graphics.endFill();
		}
		
		public override function destroy():void 
		{
			baseclip.graphics.clear();
		}
	}
}
