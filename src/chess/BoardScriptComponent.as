package chess
{
	import core.BaseObject;
	import core.GameObject;
	import core.MemoryManager;
	import core.EventManager;
	import components.ScriptComponent;
	import components.TransformComponent;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.casalib.math.geom.Point3d;
	import chess.pieces.*;

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
		private var _squaresByBaseclip:Dictionary = null; 	// Hash map of square game objects indexed by their renderable's baseclip
		private var _labelsByPiece:Dictionary = null 		// Hash map of alphanumeric labels indexed by piece
		private var _labelsBySquares:Dictionary = null;		// Hash map of alphanumeric labels indexed by squares
			
		
		public override function awake():void
		{
			_eventManager = getDependency(EventManager);		
			_eventManager.registerListener("ready", this, readyMessage);
			_eventManager.registerListener("move", this, moveMessage);		
		}
		
		/**
		 * Set up the squares and pieces
		 */
		public override function start():void 
		{
			// Reset the squares and pieces dictionaries
			_squares = new Dictionary(true);
			_pieces = new Dictionary(true);
			_labelsByPiece = new Dictionary(true);
			_squaresByLabel = new Dictionary(true);
			_squaresByBaseclip = new Dictionary(true);
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
					var square:GameObject = MemoryManager.instantiate(GameObject, GameObject.dependencies);
					
					// Add the square as a child to the board
					owner.addChild( square );
					
					// Set its components
					square.addComponent(TransformComponent);
					square.addComponent( ( i % 2 == j % 2 ) ? WhiteSquareRenderComponent : BlackSquareRenderComponent );
					
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
					_squaresByBaseclip[square.getComponent( RENDER_COMPONENT).baseclip] = square;
					_labelsBySquares[square] = key;
					
					
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
						var piece:GameObject = MemoryManager.instantiate(GameObject, GameObject.dependencies);
						
						// Set its components
						piece.addComponent(PieceScriptComponent);
						piece.addComponent(TransformComponent);
						piece.addComponent( renderClass );
						
						// Add piece as child to the board
						owner.addChild( piece );
						
						// Add piece to data structures
						_pieces[piece] = piece;
						_labelsByPiece[piece] = key;
						
						// Add event listener to handle user dragging and dropping piece to move it
						piece.addEventListener( ChessEvent.DROP, onDrop, false, 0, true );
						
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
		}
		
		private function onDrop( e:ChessEvent ):void
		{
			// Get the drop target and piece out of the event
			var dropTarget:DisplayObject = e.data.dropTarget as DisplayObject;
			var piece:GameObject = e.data.piece as GameObject;
			
			// If there was a drop target
			if ( dropTarget != null )
			{
				// Try to get square that is the drop target
				var square:GameObject = _squaresByBaseclip[dropTarget];
				
				// If the drop target was a square
				if ( square != null )
				{
					// Set the piece's x and y (not Z!) position to the target square's position
					var newPosition:Point3d = new Point3d( square.getComponent( TRANSFORM_COMPONENT ).position.x,
														   square.getComponent( TRANSFORM_COMPONENT ).position.y,
														   piece.getComponent( TRANSFORM_COMPONENT ).position.z );
				
					piece.getComponent( TRANSFORM_COMPONENT ).position = newPosition;
					
					// Updtate the piece's position in the labels dictionary
					_labelsByPiece[piece] = _labelsBySquares[_squaresByBaseclip[dropTarget]];
				}
				else
				{
					// Reset the piece's position
					piece.getComponent( TRANSFORM_COMPONENT ).position = piece.getComponent(TRANSFORM_COMPONENT).position;
				}
			}
			else
			{
				// Reset the piece's position
				piece.getComponent( TRANSFORM_COMPONENT ).position = piece.getComponent(TRANSFORM_COMPONENT).position;
			}
		}
		
		/**
		 * Clear the piece and square dictionaries
		 */
		public override function stop():void
		{
			for ( var key:String in _squares )
			{
				delete _squares[key];
			}
			
			for ( key in _pieces )
			{
				_pieces[key].removeEventListener( ChessEvent.DROP, onDrop );
				delete _pieces[key];
			}
			
			for ( key in _labelsByPiece )
			{
				delete _labelsByPiece[key];
			}
			
			for ( key in _squaresByBaseclip )
			{
				delete _squaresByBaseclip[key];
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
			_squaresByBaseclip = null;
			_labelsBySquares = null;
		}
		
		/**
		 * Unregister from event manager
		 */
		public override function destroy():void
		{
			_eventManager.unregisterListener("ready", this, readyMessage);
			_eventManager.unregisterListener("move", this, moveMessage);
			_eventManager = null;
			
			
		}		

		public function readyMessage(event:*):void
		{
			trace("readyMessage");
		}		

		public function moveMessage(event:*):void
		{
			trace("moveMessage");
		}		
	}
}