package chess.pieces   
{
	import components.RenderComponent;
	import components.ScriptComponent;
	import flash.events.MouseEvent;
	import chess.ChessEvent;
	
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
			}
		}
		
		public override function onMouseUp( e:MouseEvent ):void
		{
			var renderComponent:RenderComponent = owner.getComponent( RENDER_COMPONENT );
			
			if ( renderComponent != null )
			{
				renderComponent.baseclip.stopDrag();
			}
			
			var data:Object = new Object();
			data.piece = owner;
			data.dropTarget = renderComponent.baseclip.dropTarget;
			owner.dispatchEvent( new ChessEvent( ChessEvent.DROP, data ) );
		}
	}
}
