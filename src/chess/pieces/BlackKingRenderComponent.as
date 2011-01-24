package chess.pieces 
{
	import com.scyllacharybdis.components.MovieClipComponent;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author 
	 */
	public class BlackKingRenderComponent extends MovieClipComponent 
	{
		
		public function BlackKingRenderComponent() 
		{
			super();
			
		}

		private var _loader:Loader = new Loader();
		
		public override function start():void
		{
			_loader.contentLoaderInfo.addEventListener( Event.INIT, onInit, false, 0, true );
			_loader.load( new URLRequest("../assets/bk.png") );
		}
		
		private function onInit( e:Event ):void
		{
			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onInit );
			
			_loader.width = 50;
			_loader.height = 50;
			
			baseclip.addChild(_loader);
		}
	}

}