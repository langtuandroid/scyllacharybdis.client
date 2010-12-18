package models.chess 
{
	import com.smartfoxserver.v2.protocol.serialization.SerializableSFSType;

	/**
	 */
	public class ValidMoveModel implements SerializableSFSType
	{
		private var _validMoves:Array;
		
		public function ValidMoveModel( validMoves:Array ) 
		{
			_validMoves = validMoves;
		}
		
		public function get validMoves():Array { return _validMoves; }
		
		public function set validMoves(validMoves:Array):void 
		{
			_validMoves = validMoves;
		}
		
	}

}