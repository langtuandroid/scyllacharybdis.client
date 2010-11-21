package chess
{
	import core.BaseObject;
	import core.GameObject;
	import core.MemoryManager;
	import core.EventManager;
	import components.ScriptComponent;
	import components.TransformComponent;
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
		
		private var _squares:Dictionary = new Dictionary();
		
		public override function awake():void
		{
			_eventManager = getDependency(EventManager);		
			_eventManager.registerListener("ready", this, readyMessage);
			_eventManager.registerListener("move", this, moveMessage);		
		}
		
		public override function start():void 
		{
			var depth:int = 1;
			var size:int = 50;
			var startingX:int = 800 / 2.0 - ( 8 * size / 2.0 );
			var startingY:int = 600 / 2.0 - ( 8 * size / 2.0 );
			
			var col:String = "a";
			
			for ( var i:int = 0; i < 8; i++ ) 
			{
				var row:int = 8;
				
				for ( var j:int = 0; j < 8; j++ )
				{
					var square:GameObject = MemoryManager.instantiate(GameObject, GameObject.dependencies);
					
					owner.addChild( square );
					
					square.addComponent(PieceScriptComponent);
					square.addComponent(TransformComponent);
					square.addComponent( ( i % 2 == j % 2 ) ? WhiteSquareRenderComponent : BlackSquareRenderComponent );
					
					square.getComponent( BaseObject.TRANSFORM_COMPONENT ).dimensions = new Point( size, size );
					square.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( startingX + i * size, 
																								 startingY + j * size, 
																								 depth );
					depth++;
					
					_squares[ col + row ] = square;
					row--;
				}
				
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
			
			col = "a";
			
			for ( i = 0; i < 8; i++ ) 
			{
				row = 8;
				
				for ( j = 0; j < 8; j++ )
				{
					var renderClass:Class = null;
			
					var key:String = col + row;
					
					
					switch (key)
					{
						case "a1": 
						case "h1": 
							renderClass = BlackRookRenderComponent;
							break;
						case "b1":
						case "g1":
							renderClass = BlackKnightRenderComponent;
							break;
						case "c1":
						case "f1":
							renderClass = BlackBishopRenderComponent;
							break;
						case "d1":
							renderClass = BlackQueenRenderComponent;
							break;
						case "e1":
							renderClass = BlackKingRenderComponent;
							break;
						case "a2":
						case "b2":
						case "c2":
						case "d2":
						case "e2":
						case "f2":
						case "g2":
						case "h2":
							renderClass = BlackPawnRenderComponent;
							break;
						case "a8": 
						case "h8": 
							renderClass = WhiteRookRenderComponent;
							break;
						case "b8":
						case "g8":
							renderClass = WhiteKnightRenderComponent;
							break;
						case "c8":
						case "f8":
							renderClass = WhiteBishopRenderComponent;
							break;
						case "d8":
							renderClass = WhiteQueenRenderComponent;
							break;
						case "e8":
							renderClass = WhiteKingRenderComponent;
							break;
						case "a7":
						case "b7":
						case "c7":
						case "d7":
						case "e7":
						case "f7":
						case "g7":
						case "h7":
							renderClass = WhitePawnRenderComponent;
							break;

					}
					
					if ( renderClass != null )
					{
						
					
						var piece:GameObject = MemoryManager.instantiate(GameObject, GameObject.dependencies);
						
						piece.addComponent(PieceScriptComponent);
						piece.addComponent(TransformComponent);
						piece.addComponent( renderClass );
						
						_squares[ key ].addChild( piece );
						
						piece.getComponent( TRANSFORM_COMPONENT ).position = new Point3d( 0, 0, 100 );
					}
					
					row--;
				}
				
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