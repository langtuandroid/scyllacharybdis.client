package gui.chat 
{
	import com.scyllacharybdis.components.MovieClipComponent;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import fl.events.ComponentEvent;
	
	/**
	 * ...
	 * @author The Engine Team
	 */
	public class ChatBoxRenderComponent extends MovieClipComponent
	{
		private var _messageText:TextArea = null;
		private var _inputText:TextInput = null;
		
		public function get messageText():TextArea { return _messageText; }
		public function get inputText():TextInput { return _inputText; }
		
		public function ChatBoxRenderComponent() 
		{
			super();
			
		}
		
		public override function awake():void
		{
			_messageText = new TextArea();
			_inputText = new TextInput();
		}
		
		public override function destroy():void
		{
			MemoryManager.destroy( _messageText );
			MemoryManager.destroy( _inputText );
			
			_messageText = null;
			_inputText = null;
		}
		
		public override function start():void
		{
			baseclip.graphics.beginFill( 0xF4AD95 );
			baseclip.graphics.drawRect( 0, 0, 200, 250 );
			baseclip.graphics.endFill();
			
			_messageText.move( 10, 10 );
			_messageText.setSize( 180, 100 );
			_inputText.move( 10, 120 );
			_inputText.width = 180;
			
			baseclip.addChild( _messageText );
			baseclip.addChild( _inputText );
			
			_inputText.addEventListener( ComponentEvent.ENTER, owner.getComponent( ScriptComponent ).onInputTextEnter, false, 0, true );
		}
		
		public override function stop():void
		{
			baseclip.removeChild( _messageText );
			baseclip.removeChild( _inputText );
			baseclip.graphics.clear();
			
			_inputText.removeEventListener( ComponentEvent.ENTER, owner.getComponent( ScriptComponent ).onInputTextEnter );
		}
		
	}

}