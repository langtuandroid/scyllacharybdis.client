package chess 
{
	import events.EngineEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ChessEvent extends EngineEvent 
	{
		public static const DROP:String = "drop";
		
		public function ChessEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
	}

}