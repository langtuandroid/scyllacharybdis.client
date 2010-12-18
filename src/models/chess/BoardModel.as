package models.chess 
{
	import com.smartfoxserver.v2.protocol.serialization.SerializableSFSType;

	/**
	 */
	public class BoardModel implements SerializableSFSType
	{
		private var _board:Array;
		public function BoardModel(board:Array = null) 
		{
			_board = board;
		}
		
		public function get board():Array { return _board; }
		
		public function set board(board:Array):void 
		{
			_board = board;
		}
		
	}

}