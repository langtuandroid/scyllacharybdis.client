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
	import core.NetworkManager;
	import core.SceneManager;
	
	import chess.BoardRenderComponent;
	import chess.BoardScriptComponent;
	
	import gui.login.LoginBoxRenderComponent;
	import gui.login.LoginBoxScriptComponent;
	import gui.login.LoginBoxNetworkComponent;
	
	import handlers.ConnectionHandler;
	import handlers.LoginHandler;
	import handlers.RoomHandler;
	import handlers.MessageHandler;
	
	/**
	 */
	public class Main extends Sprite 
	{
		private var _renderer:Renderer;
		private var _networkManager:NetworkManager;
		
		private var _loginBox:GameObject;
		private var _board:GameObject;
		
		private var _eventManager:EventManager;
		private var _listerner:EventListener;
		private var _networkmanager:NetworkManager;
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
			_networkmanager = MemoryManager.instantiate(NetworkManager, [EventManager]);			
			_networkmanager.addComponent(ConnectionHandler);
			_networkmanager.addComponent(LoginHandler);
			_networkmanager.addComponent(RoomHandler);
			_networkmanager.addComponent(MessageHandler);
			
			// Create a scene manager
			_sceneManager = MemoryManager.instantiate( SceneManager );
		}
		
		private function start():void
		{
			_sceneManager.PushScene( LoginScene );
			_sceneManager.PushScene( GameScene, false );
		}
		
		private function testEvent():void
		{
		
			_eventManager.fireEvent("myevent", null);
			
		}

		private function onEnterFrame( e:Event ):void
		{
			_renderer.render(this);
		}
	}
}