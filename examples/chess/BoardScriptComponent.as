package chess
{
	import core.BaseObject;
	import core.GameObject;
	import core.MemoryManager;
	import core.EventManager;
	import components.ScriptComponent;
	import components.TransformComponent;
	import flash.geom.Point;
	import org.casalib.math.geom.Point3d;

	/**
	 */
	public class BoardScriptComponent extends ScriptComponent
	{
		/**
		 * Get the dependencies to instantiate the class
		 */
		private var _eventManager:EventManager;
		
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
			
			for ( var i:int = 0; i < 8; i++ ) 
			{
				for ( var j:int = 0; j < 8; j++ )
				{
					var piece:GameObject = MemoryManager.instantiate(GameObject, GameObject.dependencies);
					
					owner.addChild( piece );
					
					piece.addComponent(PieceScriptComponent);
					piece.addComponent(TransformComponent);
					piece.addComponent( ( i % 2 == j % 2 ) ? WhiteSquareRenderComponent : BlackSquareRenderComponent );
					
					piece.getComponent( BaseObject.TRANSFORM_COMPONENT ).dimensions = new Point( size, size );
					piece.getComponent( BaseObject.TRANSFORM_COMPONENT ).position = new Point3d( startingX + i * size, 
																								 startingY + j * size, 
																								 depth );
					depth++;
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