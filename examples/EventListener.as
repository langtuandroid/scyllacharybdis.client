package  
{
	import core.BaseObject;
	import core.EventManager
	/**
	 */
	public class EventListener extends BaseObject
	{
		private var _eventHandler:EventManager;
		
		public override function awake():void
		{
			_eventHandler = getDependency(EventManager);
			
			if ( _eventHandler == null ) {
				trace("Event Handler is null");
				return;
			}
			trace("RegisterListener");
			_eventHandler.registerListener("myevent", this, myEventHandler);			
		}
		
		public override function destroy():void
		{
			if ( _eventHandler == null ) {
				trace("Event Handler is null");
				return;
			}
			trace("UnregisterListener");
			_eventHandler.unregisterListener("myevent", this, myEventHandler);
		}

		public function myEventHandler(theData:*):void
		{
			trace("Received and event");
		}
	}
}