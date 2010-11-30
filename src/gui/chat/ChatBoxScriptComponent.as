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
				// Send the message to the other player
				_eventManager.fireEvent("SEND_CHATMESSAGE", msg);
				
				// Append the message to the text area
				displayMessage( msg );
				
				// Clear input text
				renderable.inputText.text = "";
			}
		}
		
		private function displayMessage( data:* ):void
		{
			var renderable:ChatBoxRenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			var msg:String = data as String;
			
			// Add the message to the text area
			renderable.messageText.appendText( msg + "\n");
			
			// Move carat to the bottom so message is always visible
			renderable.messageText.verticalScrollPosition = renderable.messageText.maxVerticalScrollPosition;
		}
	}
}