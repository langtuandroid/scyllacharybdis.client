package chess
{
	import com.scyllacharybdis.components.MovieClipComponent;

	public class BoardRenderComponent extends MovieClipComponent
	{
		public override function start():void
		{
			baseclip.graphics.beginFill( 0x4499FF );
			baseclip.graphics.drawRect( 0, 0, 800, 600 );
			baseclip.graphics.endFill();
		}
	}
}