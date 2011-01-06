package models.chess 
{
	import com.smartfoxserver.v2.protocol.serialization.SerializableSFSType;

	/**
	 */
	public class BoardModel implements SerializableSFSType
	{
		// White
		private var _lowerWhitePawns:int;
		private var _higherWhitePawns:int;
		private var _lowerWhiteRooks:int;
		private var _higherWhiteRooks:int;
		private var _lowerWhiteKnights:int;
		private var _higherWhiteKnights:int;
		private var _lowerWhiteBishops:int;
		private var _higherWhiteBishops:int;
		private var _lowerWhiteQueen:int;
		private var _higherWhiteQueen:int;
		private var _lowerWhiteKing:int;
		private var _higherWhiteKing:int;

		// Black
		private var _lowerBlackPawns:int;
		private var _higherBlackPawns:int;
		private var _lowerBlackRooks:int;
		private var _higherBlackRooks:int;
		private var _lowerBlackKnights:int;
		private var _higherBlackKnights:int;
		private var _lowerBlackBishops:int;
		private var _higherBlackBishops:int;
		private var _lowerBlackQueen:int;
		private var _higherBlackQueen:int;
		private var _lowerBlackKing:int;
		private var _higherBlackKing:int;
		
		public function BoardModel(
			lowerWhitePawns:int = 0,  higherWhitePawns:int = 0, lowerWhiteRooks:int = 0, higherWhiteRooks:int = 0,
			lowerWhiteKnights:int = 0, higherWhiteKnights:int = 0, lowerWhiteBishops:int = 0, higherWhiteBishops:int = 0,
			lowerWhiteQueen:int = 0, higherWhiteQueen:int = 0, lowerWhiteKing:int = 0, higherWhiteKing:int = 0,
			lowerBlackPawns:int = 0, higherBlackPawns:int = 0, lowerBlackRooks:int = 0, higherBlackRooks:int = 0,
			lowerBlackKnights:int = 0, higherBlackKnights:int = 0, lowerBlackBishops:int = 0, higherBlackBishops:int = 0,
			lowerBlackQueen:int = 0, higherBlackQueen:int = 0, lowerBlackKing:int = 0, higherBlackKing:int = 0
		)
		{
			_lowerWhitePawns = lowerWhitePawns;
			_higherWhitePawns = higherWhitePawns;
			_lowerWhiteRooks = lowerWhiteRooks;
			_higherWhiteRooks = higherWhiteRooks;
			_lowerWhiteKnights = lowerWhiteKnights;
			_higherWhiteKnights = higherWhiteKnights;
			_lowerWhiteBishops = lowerWhiteBishops;
			_higherWhiteBishops = higherWhiteBishops;
			_lowerWhiteQueen = lowerWhiteQueen;
			_higherWhiteQueen = higherWhiteQueen;
			_lowerWhiteKing = lowerWhiteKing;
			_higherWhiteKing = higherWhiteKing;

			// Black
			_lowerBlackPawns = lowerBlackPawns;
			_higherBlackPawns = higherBlackPawns;
			_lowerBlackRooks = lowerBlackRooks;
			_higherBlackRooks = higherBlackRooks;
			_lowerBlackKnights = lowerBlackKnights;
			_higherBlackKnights = higherBlackKnights;
			_lowerBlackBishops = lowerBlackBishops;
			_higherBlackBishops = higherBlackBishops;
			_lowerBlackQueen = lowerBlackQueen;
			_higherBlackQueen = higherBlackQueen;
			_lowerBlackKing = lowerBlackKing;
			_higherBlackKing = higherBlackKing;		
		}
		
		public function get lowerWhitePawns():int { return _lowerWhitePawns; }
		
		public function set lowerWhitePawns(value:int):void 
		{
			_lowerWhitePawns = value;
		}
		
		public function get higherWhitePawns():int { return _higherWhitePawns; }
		
		public function set higherWhitePawns(value:int):void 
		{
			_higherWhitePawns = value;
		}
		
		public function get lowerWhiteRooks():int { return _lowerWhiteRooks; }
		
		public function set lowerWhiteRooks(value:int):void 
		{
			_lowerWhiteRooks = value;
		}
		
		public function get higherWhiteRooks():int { return _higherWhiteRooks; }
		
		public function set higherWhiteRooks(value:int):void 
		{
			_higherWhiteRooks = value;
		}
		
		public function get lowerWhiteKnights():int { return _lowerWhiteKnights; }
		
		public function set lowerWhiteKnights(value:int):void 
		{
			_lowerWhiteKnights = value;
		}
		
		public function get higherWhiteKnights():int { return _higherWhiteKnights; }
		
		public function set higherWhiteKnights(value:int):void 
		{
			_higherWhiteKnights = value;
		}
		
		public function get lowerWhiteBishops():int { return _lowerWhiteBishops; }
		
		public function set lowerWhiteBishops(value:int):void 
		{
			_lowerWhiteBishops = value;
		}
		
		public function get higherWhiteBishops():int { return _higherWhiteBishops; }
		
		public function set higherWhiteBishops(value:int):void 
		{
			_higherWhiteBishops = value;
		}
		
		public function get lowerWhiteQueen():int { return _lowerWhiteQueen; }
		
		public function set lowerWhiteQueen(value:int):void 
		{
			_lowerWhiteQueen = value;
		}
		
		public function get higherWhiteQueen():int { return _higherWhiteQueen; }
		
		public function set higherWhiteQueen(value:int):void 
		{
			_higherWhiteQueen = value;
		}
		
		public function get lowerWhiteKing():int { return _lowerWhiteKing; }
		
		public function set lowerWhiteKing(value:int):void 
		{
			_lowerWhiteKing = value;
		}
		
		public function get higherWhiteKing():int { return _higherWhiteKing; }
		
		public function set higherWhiteKing(value:int):void 
		{
			_higherWhiteKing = value;
		}

		// Black
		public function get lowerBlackPawns():int { return _lowerBlackPawns; }
		
		public function set lowerBlackPawns(value:int):void 
		{
			_lowerBlackPawns = value;
		}
		
		public function get higherBlackPawns():int { return _higherBlackPawns; }
		
		public function set higherBlackPawns(value:int):void 
		{
			_higherBlackPawns = value;
		}
		
		public function get lowerBlackRooks():int { return _lowerBlackRooks; }
		
		public function set lowerBlackRooks(value:int):void 
		{
			_lowerBlackRooks = value;
		}
		
		public function get higherBlackRooks():int { return _higherBlackRooks; }
		
		public function set higherBlackRooks(value:int):void 
		{
			_higherBlackRooks = value;
		}
		
		public function get lowerBlackKnights():int { return _lowerBlackKnights; }
		
		public function set lowerBlackKnights(value:int):void 
		{
			_lowerBlackKnights = value;
		}
		
		public function get higherBlackKnights():int { return _higherBlackKnights; }
		
		public function set higherBlackKnights(value:int):void 
		{
			_higherBlackKnights = value;
		}
		
		public function get lowerBlackBishops():int { return _lowerBlackBishops; }
		
		public function set lowerBlackBishops(value:int):void 
		{
			_lowerBlackBishops = value;
		}
		
		public function get higherBlackBishops():int { return _higherBlackBishops; }
		
		public function set higherBlackBishops(value:int):void 
		{
			_higherBlackBishops = value;
		}
		
		public function get lowerBlackQueen():int { return _lowerBlackQueen; }
		
		public function set lowerBlackQueen(value:int):void 
		{
			_lowerBlackQueen = value;
		}
		
		public function get higherBlackQueen():int { return _higherBlackQueen; }
		
		public function set higherBlackQueen(value:int):void 
		{
			_higherBlackQueen = value;
		}
		
		public function get lowerBlackKing():int { return _lowerBlackKing; }
		
		public function set lowerBlackKing(value:int):void 
		{
			_lowerBlackKing = value;
		}
		
		public function get higherBlackKing():int { return _higherBlackKing; }
		
		public function set higherBlackKing(value:int):void 
		{
			_higherBlackKing = value;
		}
		
	
	}
}