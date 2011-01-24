package  
{
	import com.scyllacharybdis.core.events.EventHandler;
	import com.scyllacharybdis.core.objects.BaseObject;

	/**
	 */
	public class EventListener extends BaseObject
	{
		private var _eventHandler:EventHandler;
		
		public override function awake():void
		{
			_eventHandler = getDependency(EventHandler);
			
			if ( _eventHandler == null ) {
				trace("Event Handler is null");
				return;
			}
			trace("RegisterListener");
			_eventHandler.addEventListener("myevent", this, myEventHandler);			
		}
		
		public override function destroy():void
		{
			if ( _eventHandler == null ) {
				trace("Event Handler is null");
				return;
			}
			trace("UnregisterListener");
			_eventHandler.removeEventListener("myevent", this, myEventHandler);
		}

		public function myEventHandler(theData:*):void
		{
			trace("Received and event");
		}
	}
}