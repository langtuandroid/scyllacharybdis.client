package 
{
	import chess.DifficultyScene;
	import chess.LoginScene;
	import com.scyllacharybdis.core.events.NetworkEventHandler;
	import com.scyllacharybdis.core.events.NetworkEvents;
	import com.scyllacharybdis.core.memory.MemoryManager;
	import com.scyllacharybdis.core.rendering.Renderer;
	import com.scyllacharybdis.core.rendering.Window;
	import com.scyllacharybdis.core.scenes.SceneManager;
	import com.scyllacharybdis.handlers.ChatMessageHandler;
	import com.scyllacharybdis.handlers.ConnectionHandler;
	import com.scyllacharybdis.handlers.LoginHandler;
	import com.scyllacharybdis.handlers.RoomHandler;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 */
	public class Main extends Sprite 
	{
		private var _window:Window;
		private var _renderer:Renderer;
		private var _sceneManager:SceneManager;
		private var _listerner:EventListener;
		private var _facebook:FbObject;
		private var _networkHandler:NetworkEventHandler;
		
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			setup();
			start();
		}
		
		private function setup():void
		{
			// Create a window
			_window = MemoryManager.instantiate(Window);
			_window.displayContext = this;
			
			// Create a rendering system
			_renderer = MemoryManager.instantiate(Renderer);
			
			// Create a network layer
			var _networkHandler:NetworkEventHandler = MemoryManager.instantiate(NetworkEventHandler);	
			
			var _connectionHandler:ConnectionHandler = MemoryManager.instantiate(ConnectionHandler);
			var _loginHandler:LoginHandler = MemoryManager.instantiate(LoginHandler);
			var _roomHandler:RoomHandler = MemoryManager.instantiate(RoomHandler);
			var _chatMessageHandler:ChatMessageHandler = MemoryManager.instantiate(ChatMessageHandler);
			
			// Create the scene manager
			_sceneManager = MemoryManager.instantiate(SceneManager);
		}
		
		private function start():void
		{
			// Add the event listeners
			_networkHandler.addEventListener(NetworkEvents.CONNECTION_SUCCESS, this, onConnectionSuccess );
			_networkHandler.addEventListener(NetworkEvents.CONNECTION_FAILED, this, onConnectionFail );
			
			// Fire the connection event
			_networkHandler.fireEvent(NetworkEvents.CONNECT);
		}
		
		private function onConnectionSuccess( data:* ):void
		{
			// Remove the listeners
			_networkHandler.removeEventListener(NetworkEvents.CONNECTION_SUCCESS, this, onConnectionSuccess );
			_networkHandler.removeEventListener(NetworkEvents.CONNECTION_FAILED, this, onConnectionFail );
			
			// Add the event listeners
			_networkHandler.addEventListener(NetworkEvents.LOGIN_SUCCESS, this, onLoginSuccess);
			
			// Push a game scene with a login scene on top 
			_sceneManager.PushScene( LoginScene );
		}
		
		private function onConnectionFail( data:* ):void
		{
			// Remove the listeners
			_networkHandler.removeEventListener(NetworkEvents.CONNECTION_SUCCESS, this, onConnectionSuccess );
			_networkHandler.removeEventListener(NetworkEvents.CONNECTION_FAILED, this, onConnectionFail );

			// Print the error
			var msg:String = data as String;
			trace("CONNECTION FAILED: " + msg);
		}
		
		private function onLoginSuccess( data:* ):void
		{
			// Remove the listeners
			_networkHandler.removeEventListener(NetworkEvents.LOGIN_SUCCESS, this, onLoginSuccess);
			
			// Jump to the difficult scene
			_sceneManager.PushScene( DifficultyScene );
		}
		
		private function onLoginFail( data:* ):void
		{
		}
		
		private function onEnterFrame( e:Event ):void
		{
			_renderer.render();
		}
	}
}