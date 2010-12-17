package  handlers
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import core.BaseObject;
	import core.EventManager;
	import flash.utils.Dictionary;
	import models.ValidMoveModel;
	/**
	 */
	public class ValidMoveHandler extends BaseObject
	{
		public override final function getType():String 
		{
			return "VALID_MOVE_HANDLER"; 
		}		
		
		private var _eventManager:EventManager;

		/**
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
		
			_eventManager.registerListener("GET_VALID_MOVES", this, getValidMoves );
			_eventManager.registerListener("GET_VALID_MOVES_RESULTS", this, getValidMovesResults );			
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
			_eventManager.unregisterListener("GET_VALID_MOVES", this, getValidMoves );
			_eventManager.unregisterListener("GET_VALID_MOVES_RESULTS", this, getValidMovesResults );
		}
		
		/**
		 */
		public function getValidMoves():void
		{
			var request:ExtensionRequest = new ExtensionRequest("GET_VALID_MOVES", owner.sfs.lastJoinedRoom);
			owner.sfs.send(request);			
		}

		/**
		 * Recieved a board
		 * @param	evt
		 */
		public function getValidMovesResults(evt:SFSEvent):void
		{
			// Get the network message information
			var params:ISFSObject = evt.params.params;
			var dict:Dictionary = new Dictionary;
			for each ( var key:String in params.getKeys ) 
			{
				var values:Array = new Array();
				for each ( var value:String in params.getSFSArray(key) ) 
				{
					values.put( value );
				}
				dict[key] = values;
			}
			_eventManager.fireEvent("VALID_MOVE_RESULTS", new ValidMoveModel( dict ) );
		}
	}

}