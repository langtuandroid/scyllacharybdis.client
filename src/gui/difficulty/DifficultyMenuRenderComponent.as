package gui.difficulty 
{
	import components.RenderComponent;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author 
	 */
	public class DifficultyMenuRenderComponent extends RenderComponent 
	{
		private var _buttons:Dictionary = null;
		
		public function DifficultyMenuRenderComponent() 
		{
			super();
			
		}
		
		public override function awake():void
		{
			_buttons = new Dictionary(true);
			
			_buttons["easy"] = new Button();
			_buttons["medium"] = new Button();
			_buttons["hard"] = new Button();
		}
		
		public override function destroy():void
		{
			for ( var key:String in _buttons )
			{
				delete _buttons[key];
			}
			
			_buttons = null;
		}
		
		public override function start():void
		{
			baseclip.graphics.beginFill(0x114488);
			baseclip.graphics.drawRect( 0, 0, 145, 125 );
			baseclip.graphics.endFill();
			
			var x:Number = 20;
			var y:Number = 20;
			
			_buttons["easy"].move ( 20, 20 );
			_buttons["medium"].move ( 20, 50 );
			_buttons["hard"].move ( 20, 80 );
			
			for ( var key:String in _buttons )
			{
				baseclip.addChild( _buttons[key] );
			    _buttons[key].label = key;
				_buttons[key].addEventListener( MouseEvent.CLICK, owner.getComponent(SCRIPT_COMPONENT).listeners[key], false, 0, true );
			}
		}
		
		public override function stop():void
		{
			for ( var key:String in _buttons )
			{
				baseclip.removeChild( _buttons[key] );
				_buttons[key].removeEventListener( MouseEvent.CLICK, owner.getComponent(SCRIPT_COMPONENT).listeners[key] );
			}
		}
	}

}