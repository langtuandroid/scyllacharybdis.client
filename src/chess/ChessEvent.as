package chess 
{
	import com.scyllacharybdis.events.EngineEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class ChessEvent extends EngineEvent 
	{
		public static const DROP:String = "drop";
		public static const BRING_CHILD_TO_TOP:String = "bring_child_to_top";
		
		public function ChessEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
	}

}