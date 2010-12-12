package models 
{
	import flash.utils.Dictionary;
	/**
	 */
	public class ValidMoveModel 
	{
		private var _validMoves:Dictionary;
		
		public function ValidMoveModel( validMoves:Dictionary ) 
		{
			_validMoves = validMoves;
		}
		
		public function get validMoves():Dictionary { return _validMoves; }
		
	}

}