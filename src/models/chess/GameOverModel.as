package models.chess 
{
	import com.smartfoxserver.v2.protocol.serialization.SerializableSFSType;
	/**
	 */
	public class GameOverModel implements SerializableSFSType
	{
		private var _winner:int;
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