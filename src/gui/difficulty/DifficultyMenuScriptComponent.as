package gui.difficulty 
{
	import chess.GameScene;
	import com.scyllacharybdis.components.ScriptComponent;
	import com.scyllacharybdis.core.events.EventHandler;
	import com.scyllacharybdis.core.events.NetworkEventHandler;
	import com.scyllacharybdis.core.events.NetworkEvents;
	import com.scyllacharybdis.core.scenes.SceneManager;
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import models.RandomGameModel;

	/**
	 * ...
	 * @author 
	 */
	public class DifficultyMenuScriptComponent extends ScriptComponent 
	{
		public function get listeners():Dictionary { return _listeners; }
		
		private var _listeners:Dictionary = null;
		private var _networkHandler:NetworkEventHandler = null;
		private var _sceneManager:SceneManager = null;
		private var _randomGameModel:RandomGameModel;
		
		public function DifficultyMenuScriptComponent() 
		{
			super();
			_randomGameModel = new RandomGameModel("sfsChess", "com.pikitus.games.chess.SFSChess", "", "public");
		}
		
		public override function awake():void
		{
			_listeners = new Dictionary(true);
			
			// Add listener functions to hash map
			_listeners["easy"] = onEasyClick;
			_listeners["medium"] = onMediumClick;
			_listeners["hard"] = onHardClick;
			
			_networkHandler = getDependency( NetworkEventHandler );
			_sceneManager = getDependency( SceneManager );
		}
		
		public override function destroy():void
		{
			for ( var key:String in _listeners )
			{
				delete _listeners[key];
			}
			
			_listeners = null;
			_networkHandler = null;
		}
		
		private function onEasyClick( e:MouseEvent ):void
		{
			_randomGameModel.difficulty = "easy";
			joinRandomRoom();
		}
		
		private function onMediumClick( e:MouseEvent ):void
		{
			_randomGameModel.difficulty = "medium";
			joinRandomRoom();
		}
		
		private function onHardClick( e:MouseEvent ):void
		{
			_randomGameModel.difficulty = "hard";
			joinRandomRoom();
		}
		
		private function joinRandomRoom():void
		{
			_networkHandler.addEventListener(NetworkEvents.JOINROOM_SUCCESS, this, foundRoom );
			var joinObj:ISFSObject = SFSObject.newInstance();
			joinObj.putClass("RandomGameModel", _randomGameModel)
			_networkHandler.sendZoneMessage("JOIN_RANDOM_ROOM", joinObj );
		}
		
		private function foundRoom(data:SFSEvent):void
		{
			_networkHandler.removeEventListener(NetworkEvents.JOINROOM_SUCCESS, this, foundRoom );
			_sceneManager.PushScene( GameScene );
		}
	}
}