package 
{
	
	import chess.LoginScene;
	import chess.GameScene;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedSuperclassName;
	import org.casalib.math.geom.Point3d;
	import core.BaseObject;
	import core.GameObject;
	import core.Renderer;
	import core.MemoryManager;
	import core.EventManager;
	import core.NetworkObject;
	import core.SceneManager;
	
	import chess.BoardRenderComponent;
	import chess.BoardScriptComponent;
	
	import gui.login.LoginBoxRenderComponent;
	import gui.login.LoginBoxScriptComponent;
	
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;
	import handlers.MessageHandler;
	
	/**
	 */
	public class Main extends Sprite 
	{
		private var _renderer:Renderer;
		private var _loginBox:GameObject;
		private var _board:GameObject;
		private var _eventManager:EventManager;
		private var _listerner:EventListener;
		private var _networkObject:NetworkObject;
		private var _sceneManager:SceneManager;
		
		
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
			// Create the renderer
			_renderer = MemoryManager.instantiate(Renderer, Renderer.dependencies);
			
			// Start the renderer
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			// Create the event manager
			_eventManager = MemoryManager.instantiate(EventManager);
			
			_listerner = MemoryManager.instantiate( EventListener, [EventManager] );			

			// Create a network layer
			_networkObject = MemoryManager.instantiate(NetworkObject);			
			_networkObject.addComponent(ConnectionHandler, [EventManager]);
			_networkObject.addComponent(LoginHandler, [EventManager]);
			_networkObject.addComponent(RoomHandler, [EventManager]);
			_networkObject.addComponent(MessageHandler, [EventManager]);
			
			// Create a scene manager
			_sceneManager = MemoryManager.instantiate( SceneManager );
		}
		
		private function start():void
		{
			_eventManager.registerListener("CONNECTION_SUCCESS", this, onConnectionSuccess );
			_eventManager.registerListener("CONNECTION_FAILED", this, onConnectionFail );
			
			_eventManager.fireEvent("NETWORK_CONNECT");
		}
		
		private function onConnectionSuccess( data:* ):void
		{
			_eventManager.registerListener("LOGIN_SUCCESS", this, onLoginSuccess);
			
			// Push a game scene with a login scene on top 
			_sceneManager.PushScene( GameScene );
			//_sceneManager.PushScene( LoginScene );
		}
		
		private function onConnectionFail( data:* ):void
		{
			var msg:String = data as String;
			
			trace("CONNECTION FAILED: " + msg);
		}
		
		private function onLoginSuccess( data:* ):void
		{
			_sceneManager.PopScene();
		}
		
		private function onLoginFail( data:* ):void
		{
			trace("YOU SUCK, LOGIN FAILED");
		}
		
		private function onEnterFrame( e:Event ):void
		{
			_renderer.render(this);
		}
	}
}