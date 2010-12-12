package  
{
	import core.BaseObject;
	import models.BoardModel;
	import models.MovePieceModel;
	import models.ValidMoveModel;
	/**
	 * ...
	 * @author ...
	 */
	public class ChessExample extends BaseObject
	{
		private var _eventManager:EventManager;
		
		/**
		 * Override awake and create any variables and listeners.
		 */
		public override function awake():void
		{
			// Get the event manager
			_eventManager = getDependency(EventManager);
		
			_eventManager.registerListener("BOARD_RESULTS", this, boardResults );
			_eventManager.registerListener("VALID_MOVE_RESULTS", this, validMoveResults );
			_eventManager.registerListener("MOVE_RESULTS", this, moveResults );
		}
		
		/**
		 * Start runs when the game object is added to the scene.
		 */
		public override function start():void
		{
			_eventManager.fireEvent("GET_BOARD");
			_eventManager.fireEvent("GET_VALID_MOVES");
			// move a pawn
			_eventManager.fireEvent("MOVE_PIECE", new MovePieceModel("d2", "d4") );
			
			// There should be turns in here somewhere
			_eventManager.fireEvent("GET_BOARD");
			_eventManager.fireEvent("GET_VALID_MOVES");
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
			_eventManager.registerListener("BOARD_RESULTS", this, boardResults );
			_eventManager.registerListener("VALID_MOVE_RESULTS", this, validMoveResults );
			_eventManager.registerListener("MOVE_RESULTS", this, moveResults );
		}
		
		public function boardResults( board:BoardModel )
		{
			trace("Board Results: " + board );
		}
		
		public function validMoveResults( validMoves:ValidMoveModel )
		{
			trace("Valid moves Results: " + validMoves );
		}
		
		public function moveResults( movePiece:MovePieceModel )
		{
			if ( movePiece.valid ) {
				trace("Valid Move");
			} else {
				trace("Invalid Move");
			}
			
			trace("Move Results: " + movePiece );
		}
	}
}