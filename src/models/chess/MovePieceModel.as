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
		private var _type:int;
		private var _valid:Boolean;
		
		public function MovePieceModel(from:String = null, to:String = null, type:int = 0, valid:Boolean=true) 
		{
			_from = from;
			_to = to;
			_type = type;
			_valid = valid;
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
		
		public function get type():int { return _type; }
		
		public function set type(value:int):void 
		{
			_type = value;
		}
		
		public function get valid():Boolean { return _valid; }
		
		public function set valid(valid:Boolean):void 
		{
			_valid = valid;
		}
		

	}

}