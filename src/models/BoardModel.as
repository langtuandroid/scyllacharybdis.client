package models 
{
	import flash.utils.Dictionary;
	/**
	 */
	public class BoardModel 
	{
		private var _board:Dictionary;
		public function BoardModel(board:Dictionary) 
		{
			_board = board;
		}
		
		public function get board():Dictionary { return _board; }
		
	}

}