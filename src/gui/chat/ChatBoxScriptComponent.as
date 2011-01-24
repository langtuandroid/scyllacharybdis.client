package gui.chat 
{
	import com.scyllacharybdis.components.RenderComponent;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.core.events.EventHandler;
	import com.scyllacharybdis.core.events.NetworkEventHandler;
	import com.scyllacharybdis.core.events.NetworkEvents;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import fl.events.ComponentEvent;
	
	/**
	 * ...
	 * @author The Engine Team
	 */
	public class ChatBoxScriptComponent extends ScriptComponent
	{

		private var _networkHandler:NetworkEventHandler = null;
		
		public function ChatBoxScriptComponent() 
		{
			super();
		}
		
		public override function awake():void
		{
			_networkHandler = getDependency(NetworkEventHandler);
		}
		
		public override function destroy():void
		{
			_networkHandler = null;
		}
		
		public override function start():void
		{
			_networkHandler.addEventListener(NetworkEvents.RECEIVED_CHAT_MESSAGE, this, displayMessage );
		}
		
		public override function stop():void
		{
			_networkHandler.removeEventListener(NetworkEvents.RECEIVED_CHAT_MESSAGE, this, displayMessage);
		}
		
		public function onInputTextEnter( e:ComponentEvent ):void
		{
			var renderable:ChatBoxRenderComponent = owner.getComponent( RenderComponent );
			
			var msg:String = renderable.inputText.text;
			
			if ( msg != "" )
			{
				// Send the message to the other player
				var messageObj:ISFSObject = SFSObject.newInstance();
				messageObj.putUtfString("Message", msg );
				_networkHandler.sendRoomMessage(NetworkEvents.SEND_CHAT_MESSAGE, messageObj);
				
				// Append the message to the text area
				displayMessage( msg );
				
				// Clear input text
				renderable.inputText.text = "";
			}
		}
		
		private function displayMessage( data:* ):void
		{
			var renderable:ChatBoxRenderComponent = owner.getComponent( RenderComponent );
			
			var msg:String = data as String;
			
			// Add the message to the text area
			renderable.messageText.appendText( msg + "\n");
			
			// Move carat to the bottom so message is always visible
			renderable.messageText.verticalScrollPosition = renderable.messageText.maxVerticalScrollPosition;
		}
	}
}