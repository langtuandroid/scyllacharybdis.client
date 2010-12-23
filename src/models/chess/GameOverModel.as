package models.chess 
{
	/**
	 */
	public class GameOverModel 
	{
		var _winner:int;
		public function GameOverModel(winner:int = 0) 
		{
			_winner = winner;
		}
		
		public function get winner():int { return _winner; }
		
		public function set winner(value:int):void 
		{
			_winner = value;
		}
		
	}

}