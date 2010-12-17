package models 
{
	import com.smartfoxserver.v2.protocol.serialization.SerializableSFSType;
	/**
	 * ...
	 * @author ...
	 */
	public class RandomGameModel implements SerializableSFSType
	{
		private var mGameType:String;
		private var mGameExtension:String;
		private var mDifficulty:String;
		private var mArea:String;
		
		public function get gameType():String { return mGameType; }
		
		public function set gameType(value:String):void 
		{
			mGameType = value;
		}
		
		public function get gameExtension():String { return mGameExtension; }
		
		public function set gameExtension(value:String):void 
		{
			mGameExtension = value;
		}
		
		public function get difficulty():String { return mDifficulty; }
		
		public function set difficulty(value:String):void 
		{
			mDifficulty = value;
		}
		
		public function get area():String { return mArea; }
		
		public function set area(value:String):void 
		{
			mArea = value;
		}
	}
}
