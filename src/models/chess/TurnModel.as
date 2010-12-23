package models.chess 
{
	/**
	 */
	public class TurnModel 
	{
		private var _turn:int;
		
		public function TurnModel(turn:int = 0) 
		{
			_turn = turn;
		}
		
		public function get turn():int { return _turn; }
		
		public function set turn(value:int):void 
		{
			_turn = value;
		}
	}
}