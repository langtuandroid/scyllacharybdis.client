package models 
{
	/**
	 * ...
	 * @author ...
	 */
	public class MovePieceModel 
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
		
		public function get to():String { return _to; }
		
		public function get valid():Boolean { return _valid; }
		
	}

}