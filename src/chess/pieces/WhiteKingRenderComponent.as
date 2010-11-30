package chess.pieces 
{
	import components.RenderComponent;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author 
	 */
	public class WhiteKingRenderComponent extends RenderComponent 
	{
		
		public function WhiteKingRenderComponent() 
		{
			super();
			
		}
		
		private var _loader:Loader = new Loader();
		
		public override function start():void
		{
			_loader.contentLoaderInfo.addEventListener( Event.INIT, onInit, false, 0, true );
			_loader.load( new URLRequest("../assets/wk.png") );
		}
		
		private function onInit( e:Event ):void
		{
			removeEventListener( Event.COMPLETE, onInit );
			
			_loader.width = 50;
			_loader.height = 50;
			_baseclip.addChild(_loader);
		}
		
	}

}