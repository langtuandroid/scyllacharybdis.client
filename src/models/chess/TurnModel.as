package models.chess 
{
	import com.smartfoxserver.v2.protocol.serialization.SerializableSFSType;
	/**
	 */
	public class TurnModel implements SerializableSFSType
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