package models
{
	import com.smartfoxserver.v2.protocol.serialization.SerializableSFSType;
	/**
	 * ...
	 * @author ...
	 */
	public class RandomGameModel implements SerializableSFSType
	{
		private var _gameType:String;
		private var _gameExtension:String;
		private var _difficulty:String;
		private var _area:String;
		
		public function RandomGameModel(gameType:String="", gameExtension:String="", difficulty:String="", area:String="")
		{
			_gameType = gameType;
			_gameExtension = gameExtension;
			_difficulty = difficulty;
			_area = area;
		}
			
		
		public function get gameType():String { return _gameType; }
		
		public function set gameType(value:String):void 
		{
			_gameType = value;
		}
		
		public function get gameExtension():String { return _gameExtension; }
		
		public function set gameExtension(value:String):void 
		{
			_gameExtension = value;
		}
		
		public function get difficulty():String { return _difficulty; }
		
		public function set difficulty(value:String):void 
		{
			_difficulty = value;
		}
		
		public function get area():String { return _area; }
		
		public function set area(value:String):void 
		{
			_area = value;
		}
	}
}
