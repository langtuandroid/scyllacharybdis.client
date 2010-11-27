package chess.pieces   
{
	import components.RenderComponent;
	import components.ScriptComponent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import chess.ChessEvent;
	import org.casalib.math.geom.Point3d;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PieceScriptComponent extends ScriptComponent
	{
		public function PieceScriptComponent()
		{
			super();
		}
		
		public override function onMouseDown( e:MouseEvent ):void
		{
			var renderComponent:RenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			if ( renderComponent != null )
			{
				renderComponent.baseclip.startDrag();
				
				if ( !renderComponent.baseclip.hasEventListener(MouseEvent.MOUSE_MOVE) )
				{
					renderComponent.baseclip.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true);
				}
			}
		}
		
		public override function onMouseMove( e:MouseEvent ):void
		{
			var renderComponent:RenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			if ( renderComponent != null )
			{
				owner.position = new Point3d(renderComponent.baseclip.x, renderComponent.baseclip.y, owner.position.z);
			}
		}
		
		public override function onMouseUp( e:MouseEvent ):void
		{
			var renderComponent:RenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			if ( renderComponent != null )
			{
				if ( !renderComponent.baseclip.hasEventListener(MouseEvent.MOUSE_MOVE) )
				{
					renderComponent.baseclip.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				}
				
				renderComponent.baseclip.stopDrag();
				
				
			}
			
			var data:Object = new Object();
			data.piece = owner;
			data.dropTarget = renderComponent.baseclip.dropTarget;
			owner.dispatchEvent( new ChessEvent( ChessEvent.DROP, data ) );
		}
	}
}
