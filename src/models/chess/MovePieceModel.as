package models.chess 
{
	import com.smartfoxserver.v2.protocol.serialization.SerializableSFSType;
	/**
	 * ...
	 * @author ...
	 */
	public class MovePieceModel implements SerializableSFSType
	{
		private var _from:String;
		private var _to:String;
		private var _valid:Boolean;
		
		public function MovePieceModel(from:String, to:String, valid:Boolean=true) 
		{
			_from = from;
			_to = to;
		}
		
		public function get from():String { return _from; }
		
		public function set from(from:String):void 
		{
			_from = from;
		}
		
		public function get to():String { return _to; }
		
		public function set to(to:String):void 
		{
			_to = to;
		}
		
		public function get valid():Boolean { return _valid; }
		
		public function set valid(valid:Boolean):void 
		{
			_valid = valid;
		}
	}

}