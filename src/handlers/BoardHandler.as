package  handlers
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import core.BaseObject;
	import core.EventManager;
	import flash.utils.Dictionary;
	import models.BoardModel;
	/**
	 */
	public class BoardHandler extends BaseObject
	{
		public override final function getType():String 
		{
			return "BOARD_HANDLER"; 
		}		

		private var _eventManager:EventManager;
		
		/**
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
		
			_eventManager.registerListener("GET_BOARD", this, getBoard );
			_eventManager.registerListener("GET_BOARD_RESULTS", this, receivedBoard );			
		}
		
		/**
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
		}

		/**
		 * Stop runs when the game object is added to the scene.
		 */
		public override function stop():void
		{
		}

		/**
		 * Override destroy to clean up any variables or listeners.
		 */
		public override function destroy():void
		{
			_eventManager.unregisterListener("GET_BOARD", this, getBoard );
			_eventManager.unregisterListener("GET_BOARD_RESULTS", this, receivedBoard );
		}
		
		/**
		 * Request Board
		 */
		public function getBoard():void
		{
			var request:ExtensionRequest = new ExtensionRequest("GET_BOARD", owner.sfs.room);
			owner.sfs.send(request);			
		}

		/**
		 * Recieved a board
		 * @param	evt
		 */
		public function receivedBoard(evt:SFSEvent):void
		{
			// Get the network message information
			var params:ISFSObject = evt.params.params;
			var board:ISFSObject = params.getSFSObject("boardArray");
			var dict:Dictionary = new Dictionary;
			for each ( var key:String in board.getKeys ) 
			{
				dict[key] = board.getLong(key);
			}
			_eventManager.fireEvent("BOARD_RESULTS", new BoardModel( dict ) );
		}
	}
}