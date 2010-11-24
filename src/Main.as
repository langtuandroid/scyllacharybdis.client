package 
{
	
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
		
		
		
		public function Main():void 
		{		
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			setup(e);
			setupLogin();
			//setupChessBoard(e);
			//testEvent();
			
			addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
		
		private function setup(e:Event = null):void
		{
			_renderer = MemoryManager.instantiate(Renderer, Renderer.dependencies);
			
			// Create the event manager
			_eventManager = MemoryManager.instantiate(EventManager);
			
			_listerner = MemoryManager.instantiate( EventListener, [EventManager] );			

			// Create a network layer
			_networkmanager = MemoryManager.instantiate(NetworkManager, [EventManager]);			
			_networkmanager.addComponent(ConnectionHandler);
			_networkmanager.addComponent(LoginHandler);
			_networkmanager.addComponent(RoomHandler);
			_networkmanager.addComponent(MessageHandler);
		}
		
		private function setupLogin():void
		{
			_loginBox = MemoryManager.instantiate( GameObject, GameObject.dependencies );
			_loginBox.addComponent(LoginBoxScriptComponent, [EventManager]);
			_loginBox.addComponent(LoginBoxRenderComponent);
			
			_loginBox.enabled = true;
		}
		
		private function setupChessBoard(e:Event = null):void
		{
			// Set the square
			_board = MemoryManager.instantiate( GameObject, GameObject.dependencies );
			_board.addComponent(BoardScriptComponent, [EventManager]);
			_board.addComponent(BoardRenderComponent);			

			_board.position = new Point3d(0, 0, 0);
			_board.rotate = 0;
			
			_board.enabled = true;
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