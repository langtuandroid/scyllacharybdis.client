package gui.chat 
{
	import components.ScriptComponent;
	import fl.events.ComponentEvent;
	import core.EventManager;
	
	/**
	 * ...
	 * @author The Engine Team
	 */
	public class ChatBoxScriptComponent extends ScriptComponent
	{
		public static function get dependencies():Array { return [EventManager]; }
		
		private var _eventManager:EventManager = null;
		
		public function ChatBoxScriptComponent() 
		{
			super();
		}
		
		public override function awake():void
		{
			_eventManager = getDependency(EventManager);
		}
		
		public override function destroy():void
		{
			_eventManager = null;
		}
		
		public override function start():void
		{
			_eventManager.registerListener("RECEIVED_CHATMESSAGE", this, displayMessage );
		}
		
		public override function stop():void
		{
			_eventManager.unregisterListener("RECEIVED_CHATMESSAGE", this, displayMessage);
		}
		
		public function onInputTextEnter( e:ComponentEvent ):void
		{
			var renderable:ChatBoxRenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			var msg:String = renderable.inputText.text;
			
			if ( msg != "" )
			{
				_eventManager.fireEvent("SEND_CHATMESSAGE", msg);
				displayMessage( msg );
			}
		}
		
		private function displayMessage( data:* )
		{
			var renderable:ChatBoxRenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			var msg:String = data as String;
			
			renderable.messageText.appendText( msg );
		}
		
	}

}