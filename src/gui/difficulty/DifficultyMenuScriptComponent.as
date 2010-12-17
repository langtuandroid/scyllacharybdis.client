package gui.difficulty 
{
	import com.smartfoxserver.v2.exceptions.SFSValidationError;
	import components.ScriptComponent;
	import core.EventManager;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author 
	 */
	public class DifficultyMenuScriptComponent extends ScriptComponent 
	{
		public function get listeners():Dictionary { return _listeners; }
		
		private var _listeners:Dictionary = null;
		private var _eventManager:EventManager = null;
		
		public static function get dependencies():Array { return [EventManager]; }
		
		public function DifficultyMenuScriptComponent() 
		{
			super();
		}
		
		public override function awake():void
		{
			_listeners = new Dictionary(true);
			
			// Add listener functions to hash map
			_listeners["easy"] = onEasyClick;
			_listeners["medium"] = onMediumClick;
			_listeners["hard"] = onHardClick;
			
			_eventManager = getDependency( EventManager );
		}
		
		public override function destroy():void
		{
			for ( var key:String in _listeners )
			{
				delete _listeners[key];
			}
			
			_listeners = null;
			_eventManager = null;
		}
		
		private function onEasyClick( e:MouseEvent ):void
		{
			_eventManager.fireEvent("JOIN_EASY_ROOM");
		}
		
		private function onMediumClick( e:MouseEvent ):void
		{
			_eventManager.fireEvent("JOIN_MEDIUM_ROOM");
		}
		
		private function onHardClick( e:MouseEvent ):void
		{
			_eventManager.fireEvent("JOIN_HARD_ROOM");
		}
	}
}