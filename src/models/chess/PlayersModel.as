package models.chess 
{
	/**
	 * ...
	 * @author ...
	 */
	public class PlayersModel 
	{
		private var _player1:int;
		private var _player2:int;

		public function PlayersModel(player1:int = 0, player2:int = 0) 
		{
			_player1 = player1;
			_player2 = player2;
		}
		
		public function get player1():int { return _player1; }
		
		public function set player1(value:int):void 
		{
			_player1 = value;
		}
		
		public function get player2():int { return _player2; }
		
		public function set player2(value:int):void 
		{
			_player2 = value;
		}
	}

}