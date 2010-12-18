package chess
{
	import core.BaseObject;
	import core.GameObject;
	import core.MemoryManager;
	import core.EventManager;
	import components.ScriptComponent;
	import components.TransformComponent;
	import events.EngineEvent;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import gui.chat.ChatBoxRenderComponent;
	import gui.chat.ChatBoxScriptComponent;
	import models.chess.BoardModel;
	import models.chess.MovePieceModel;
	import models.chess.ValidMoveModel;
	import models.CreateRoomModel;
	import models.RoomModel;
	import org.casalib.math.geom.Point3d;
	import chess.pieces.*;
	import org.casalib.util.ArrayUtil;

	/**
	 */
	public class BoardScriptComponent extends ScriptComponent
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		private var _eventManager:EventManager;
		
		private var _squares:Dictionary = null;				// Hash map of squares with themselves as keys
		private var _pieces:Dictionary = null;				// Hash map of pieces with themselves as keys
		
		private var _squaresByLabel:Dictionary = null;		// Hash map of square game objects indexed by their alphanumeric label
		private var _piecesByLabel:Dictionary = null;
		private var _labelsByPiece:Dictionary = null 		// Hash map of alphanumeric labels indexed by piece
		private var _labelsBySquares:Dictionary = null;		// Hash map of alphanumeric labels indexed by squares
			
		
		public override function awake():void
		{
			_eventManager = getDependency(EventManager);	

			_eventManager.registerListener("CREATEROOM_SUCCESS", this, createRoomSuccess );
			_eventManager.registerListener("CREATEROOM_FAILED", this, createRoomFailed );
			_eventManager.registerListener("JOINROOM_SUCCESS", this, joinRoomSuccess );
			_eventManager.registerListener("JOINROOM_FAILED", this, joinRoomFailed );
			
			_eventManager.registerListener("START_GAME", this, startGame);
			_eventManager.registerListener("BOARD_RESULTS", this, boardResults );
			_eventManager.registerListener("VALID_MOVE_RESULTS", this, validMoveResults );
			_eventManager.registerListener("MOVE_RESULTS", this, moveResults );

			
		}
		
			
		/**
		 * Unregister from event manager
		 */
		public override function destroy():void
		{
			clearBoard();
			_eventManager.unregisterListener("CREATEROOM_SUCCESS", this, createRoomSuccess );
			_eventManager.unregisterListener("CREATEROOM_FAILED", this, createRoomFailed );
			_eventManager.unregisterListener("JOINROOM_SUCCESS", this, joinRoomSuccess );
			_eventManager.unregisterListener("JOINROOM_FAILED", this, joinRoomFailed );
			
			_eventManager.unregisterListener("START_GAME", this, startGame);
			_eventManager.unregisterListener("BOARD_RESULTS", this, boardResults );
			_eventManager.unregisterListener("VALID_MOVE_RESULTS", this, validMoveResults );
			_eventManager.unregisterListener("MOVE_RESULTS", this, moveResults );			
			_eventManager = null;
		}		

		/**
		 * Create a game 
		 */
		public function createGame(roomName:String):void
		{
			_eventManager.fireEvent( "NETWORK_CREATEROOM", new CreateRoomModel("TestGameRoom", "", 2, "sfsChess", "com.pikitus.games.chess.SFSChess") );
		}
		
		/**
		 * Join a game
		 */
		public function joinGame(roomName:String):void
		{
			_eventManager.fireEvent( "NETWORK_JOINROOM", new RoomModel("TestGameRoom") );
		}

		/**
		 * Create room success event handler
		 */
		public function createRoomSuccess( data:* ):void
		{
			trace("Network Driver: createRoomSuccess");
		}

		/**
		 * Create room failed event handler
		 */
		public function createRoomFailed( data:* ):void
		{
			trace("Network Driver: createRoomFailed");
		}

		/**
		 * Join room success event handler
		 */
		public function joinRoomSuccess( data:* ):void
		{
			trace("Network Driver: joinRoomSuccess");
		}
		
		/**
		 * Join room failed event handler
		 */
		public function joinRoomFailed( data:* ):void
		{
			trace("Network Driver: joinRoomFailed");
		}
		
		/**
		 * Server has 2 players so start the game handler
		 */
		public function startGame(event:*):void
		{
			_eventManager.fireEvent("GET_BOARD");
			_eventManager.fireEvent("GET_VALID_MOVES");
		}		

		/**
		 * Recieved the board from the server handler
		 * @param	board
		 */
		public function boardResults( board:BoardModel ):void
		{
			trace("Board Results: " + board );
			setupBoard(board);
		}
		
		/**
		 * Recieved the valid moves from the server handler
		 * @param	validMoves
		 */
		public function validMoveResults( validMoves:ValidMoveModel ):void
		{
			trace("Valid moves Results: " + validMoves );
		}
		
		/**
		 * Recieved the move results handler
		 * @param	movePiece
		 */
		public function moveResults( movePiece:MovePieceModel ):void
		{
			if ( movePiece.valid ) {
				trace("Valid Move");
			} else {
				trace("Invalid Move");
			}
			
			// There should be turns in here somewhere
			_eventManager.fireEvent("GET_BOARD");
			_eventManager.fireEvent("GET_VALID_MOVES");
		}
		
		
		/**
		 * Set up the squares and pieces
		 */
		public function setupBoard( board:BoardModel ):void 
		{
			// Reset the squares and pieces dictionaries
			_squares = new Dictionary(true);
			_pieces = new Dictionary(true);
			_squaresByLabel = new Dictionary(true);
			_piecesByLabel = new Dictionary(true);
			_labelsByPiece = new Dictionary(true);
			_labelsBySquares = new Dictionary(true);
			
			// Init some variables for placement
			var depth:int = 1;
			var size:int = 50;
			var startingX:int = 800 / 2.0 - ( 8 * size / 2.0 );
			var startingY:int = 600 / 2.0 - ( 8 * size / 2.0 );
			
			// Column label for a square
			var col:String = "a";
			
			// For each column
			for ( var i:int = 0; i < 8; i++ ) 
			{
				// Reset the row count
				var row:int = 8;
				
				// For each row
				for ( var j:int = 0; j < 8; j++ )
				{
					// Make a square
					var square:GameObject = MemoryManager.instantiate( GameObject );
					
					// Set its components
					square.addComponent(TransformComponent);
					square.addComponent( ( i % 2 == j % 2 ) ? WhiteSquareRenderComponent : BlackSquareRenderComponent );
					
					// Add the square as a child to the board
					owner.addChild( square );
					
					// Size and place square
					square.getComponent( BaseObject.TRANSFORM_COMPONENT ).dimensions = new Point( size, size );
					square.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( startingX + i * size, 
																								 startingY + j * size, 
																								 depth );
																								 
					// Increment relative depth of each piece
					depth++;
					
					// Add the square to the dictionaries
					_squares[square] = square;
					_squaresByLabel[ col + row ] = square;
					_labelsBySquares[square] = col + row;
					
					
					// Decrement row
					row--;
				}
				
				// Update the column identifier
				switch ( i )
				{
					case 0: col = "b";
							break;
					case 1: col = "c";
							break;
					case 2: col = "d";
							break;
					case 3: col = "e";
							break;
					case 4: col = "f";
							break;
					case 5: col = "g";
							break;
					case 6: col = "h";
							break;
				}
			}
			
			// Reset the column identifier
			col = "a";
			
			// Scroll through the columns again
			for ( i = 0; i < 8; i++ ) 
			{
				// Reset the row
				row = 8;
				
				// For each row
				for ( j = 0; j < 8; j++ )
				{
					// Declare a class for a possible render component
					var renderClass:Class = null;
			
					// Create key
					var key:String = col + row;
					
					// Determine render component if it's a row that starts with a piece
					switch (key)
					{
						case "a1": 
						case "h1": 
							renderClass = WhiteRookRenderComponent;
							break;
						case "b1":
						case "g1":
							renderClass = WhiteKnightRenderComponent;
							break;
						case "c1":
						case "f1":
							renderClass = WhiteBishopRenderComponent;
							break;
						case "d1":
							renderClass = WhiteQueenRenderComponent;
							break;
						case "e1":
							renderClass = WhiteKingRenderComponent;
							break;
						case "a2":
						case "b2":
						case "c2":
						case "d2":
						case "e2":
						case "f2":
						case "g2":
						case "h2":
							renderClass = WhitePawnRenderComponent;
							break;
						case "a8": 
						case "h8": 
							renderClass = BlackRookRenderComponent;
							break;
						case "b8":
						case "g8":
							renderClass = BlackKnightRenderComponent;
							break;
						case "c8":
						case "f8":
							renderClass = BlackBishopRenderComponent;
							break;
						case "d8":
							renderClass = BlackQueenRenderComponent;
							break;
						case "e8":
							renderClass = BlackKingRenderComponent;
							break;
						case "a7":
						case "b7":
						case "c7":
						case "d7":
						case "e7":
						case "f7":
						case "g7":
						case "h7":
							renderClass = BlackPawnRenderComponent;
							break;

					}
					
					// If there's a render class (hence a piece)...
					if ( renderClass != null )
					{
						// Make a piece
						var piece:GameObject = MemoryManager.instantiate(GameObject);
						
						// Set its components
						piece.addComponent(PieceScriptComponent);
						piece.addComponent(TransformComponent);
						piece.addComponent( renderClass );
						
						// Add piece as child to the board
						owner.addChild( piece );
						
						// Add piece to data structures
						_pieces[piece] = piece;
						_labelsByPiece[piece] = key;
						_piecesByLabel[key] = piece;
						
						// Add event listener to handle user dragging and dropping piece to move it
						piece.addEventListener( ChessEvent.DROP, onDrop, false, 0, true );
						piece.addEventListener( ChessEvent.BRING_CHILD_TO_TOP, onBringChildToTop, false, 0, true );
						
						// Place piece ( initial sizing is handled by render component )
						// Put it at the same position as the square
						var squareTransform:TransformComponent = _squaresByLabel[key].getComponent( TRANSFORM_COMPONENT );
						piece.getComponent( TRANSFORM_COMPONENT ).position = new Point3d( squareTransform.position.x, squareTransform.position.y, depth );
						
						// Increment depth
						depth++;
					}
					
					// Decrement row
					row--;
				}
				
				// Update column
				switch ( i )
				{
					case 0: col = "b";
							break;
					case 1: col = "c";
							break;
					case 2: col = "d";
							break;
					case 3: col = "e";
							break;
					case 4: col = "f";
							break;
					case 5: col = "g";
							break;
					case 6: col = "h";
							break;
				}	
			}
			
			var chatBox:GameObject = MemoryManager.instantiate( GameObject );
			chatBox.addComponent( ChatBoxRenderComponent );
			chatBox.addComponent( ChatBoxScriptComponent, ChatBoxScriptComponent.dependencies );
			
			chatBox.position = new Point3d( 600, 450, depth);
			
			owner.addChild(chatBox);
		}
		
		private function onBringChildToTop( e:ChessEvent ):void
		{
			// Child to bring to top
			var topChild:GameObject = e.data as GameObject;
			
			// Get all the render components of the board's children
			var renderComponents:Array = new Array();
			
			for each ( var child:GameObject in owner.children )
			{
				renderComponents.push(child.getComponent(RENDER_COMPONENT));
			}
			
			// Sort them
			renderComponents.sortOn( "comparator", Array.NUMERIC );
			
			// Get the max depth
			var maxDepth:Number = renderComponents[renderComponents.length - 1].comparator;
			
			// Set the child to be brought to the top's z
			topChild.position = new Point3d( topChild.position.x, topChild.position.y, maxDepth + 1 );
			
			// Sort again
			renderComponents.sortOn( "comparator", Array.NUMERIC );
			
			// Bring z values that need it back down by one to "collapse" the z values
			for ( var i:int = 1; i < renderComponents.length; i++ )
			{
				if ( renderComponents[i].comparator - renderComponents[i - 1].comparator > 1 )
				{
					renderComponents[i].owner.position = new Point3d( renderComponents[i].owner.position.x,
																	  renderComponents[i].owner.position.y,
																	  renderComponents[i].owner.position.z - 1);
				}
			}
		}
		
		private function onDrop( e:ChessEvent ):void
		{
			// Calculate drop target
			var piece:GameObject = e.data.piece as GameObject;
			var mousePos:Point = e.data.mousePos as Point;
			var dropTarget:GameObject = detectCollisions( mousePos );
			
			// If there was a drop target
			if ( dropTarget != null )
			{
				if ( _piecesByLabel[_labelsBySquares[dropTarget]] != null && _piecesByLabel[_labelsBySquares[dropTarget]] != piece )
				{
					// For now, just disable instead of tweening to a "captured pieces" area
					//_piecesByLabel[_labelsBySquares[dropTarget]].enabled = false;	
					
					delete _labelsByPiece[ _piecesByLabel[_labelsBySquares[dropTarget]]];
					delete _piecesByLabel[_labelsBySquares[dropTarget]];
					
				}
				
				// Set the piece's x and y (not Z!) position to the target square's position
				var newPosition:Point3d = new Point3d( dropTarget.position.x,
													   dropTarget.position.y,
													   piece.position.z );

				// FIXME: Fire the actual move event here.
				_eventManager.fireEvent("MOVE_PIECE", new MovePieceModel("d2", "d4") );
				piece.position = newPosition;
				
				// Updtate the piece's position in the labels dictionary
				delete _labelsByPiece[ _piecesByLabel[ _labelsByPiece[piece] ] ];
				delete _piecesByLabel[ _labelsByPiece[piece] ];
				_labelsByPiece[piece] = _labelsBySquares[ dropTarget ];
				_piecesByLabel[_labelsBySquares[dropTarget]] = piece;
				
			}
			else
			{
				// Reset the piece's position
				piece.position = piece.position;
			}
		}
		
		private function detectCollisions( point:Point ):GameObject
		{
			// The possible drop target and the intersection between the piece and it
			var dropTarget:GameObject = null;
			var intersection:Rectangle = null;
			
			
			for each ( var square:GameObject in _squares ) //TODO Soon this will be a list of all available moves for the piece, not all squares
			{
				// Get the rectangle of the square
				var squareClip:MovieClip = square.getComponent(RENDER_COMPONENT).baseclip;
				
				// If there is an intersection between the two pieces
				if ( squareClip.hitTestPoint( point.x, point.y ) )
				{
					// If there's no previous drop target
					dropTarget = square;
					break;
				}
			}
			
			return dropTarget;
		}
		
		/**
		 * Clear the piece and square dictionaries
		 */
		public function clearBoard():void
		{
			for ( var key:String in _squares )
			{
				delete _squares[key];
			}
			
			for ( key in _pieces )
			{
				if ( _pieces[key] && _pieces[key].hasEventListener( ChessEvent.DROP ) )
				{
					_pieces[key].removeEventListener( ChessEvent.DROP, onDrop );	
				}
				
				delete _pieces[key];
			}
			
			for ( key in _piecesByLabel )
			{
				delete _piecesByLabel[key];
			}
			
			for ( key in _labelsByPiece )
			{
				delete _labelsByPiece[key];
			}
			
			for ( key in _squaresByLabel )
			{
				delete _squaresByLabel[key];
			}
			
			for ( key in _labelsBySquares )
			{
				delete _labelsBySquares[key];
			}
		
			
			_squares = null;
			_pieces = null;
			_labelsByPiece = null;
			_squaresByLabel = null;
			_piecesByLabel = null;
			_labelsBySquares = null;
		}
	}
}