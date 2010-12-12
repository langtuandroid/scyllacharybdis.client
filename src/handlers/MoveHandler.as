package handlers 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import core.BaseObject;
	import core.EventManager;
	import models.MovePieceModel;
	/**
	 */
	public class MoveHandler extends BaseObject
	{
		private var _eventManager:EventManager;

		/**
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
		
			_eventManager.registerListener("MOVE_PIECE", this, movePiece );
			_eventManager.registerListener("MOVE_PEICE_RESULTS", this, movePieceResults );			
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
			_eventManager.unregisterListener("MOVE_PIECE", this, movePiece );
			_eventManager.unregisterListener("MOVE_PIECE_RESULTS", this, movePieceResults );
		}
		
		/**
		 */
		public function movePiece(move:MovePieceModel):void
		{
			var sfsObject:ISFSObject = new SFSObject();
			sfsObject.putUtfString("from", move.from);
			sfsObject.putUtfString("to", move.to);
			var request:ExtensionRequest = new ExtensionRequest("MOVE_PIECE", owner.sfs.room);
			owner.sfs.send(request, sfsObject);			
		}

		/**
		 * @param	evt
		 */
		public function movePieceResults(evt:SFSEvent):void
		{
			// Get the network message information
			var params:ISFSObject = evt.params.params;
			var valid:Boolean = params.getBool("valid");
			var from:String = params.getUtfString("from");
			var to:String = params.getUtfString("to");
			_eventManager.fireEvent("MOVE_RESULTS", new MovePieceModel(from, to, valid) );
		}
	
	}

}