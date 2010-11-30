package chess.pieces   
{
	import components.RenderComponent;
	import components.ScriptComponent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import chess.ChessEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
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
				// Bring the piece above the board's other childrent
				owner.dispatchEvent( new ChessEvent( ChessEvent.BRING_CHILD_TO_TOP, owner ) );
			
				renderComponent.baseclip.startDrag();
			}
		}
		
		public override function onMouseUp( e:MouseEvent ):void
		{
			var renderComponent:RenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			if ( renderComponent != null )
			{	
				renderComponent.baseclip.stopDrag();
				
				var data:Object = new Object();
				data.piece = owner;
				data.mousePos = new Point( e.stageX, e.stageY );
				owner.dispatchEvent( new ChessEvent( ChessEvent.DROP, data ) );
			}
		}
	}
}
