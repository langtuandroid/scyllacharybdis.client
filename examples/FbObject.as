package  
{
	import com.facebook.graph.Facebook;
	import core.BaseObject;
	import flash.events.MouseEvent;
	
	/**
	 */
	public class FbObject extends BaseObject
	{
		protected static const APP_ID:String = "YOUR_APP_ID";
		protected var friendsHash:Object;
		protected var friendsArrayList:Array;
		
		public override function awake():void
		{
			//Initialize Facebook library
			Facebook.init(APP_ID, onInit);	
			
			friendsHash = {};
			friendsArrayList = new Array();
		}
		
		protected function onInit(result:Object, fail:Object):void {						
			if (result) { //already logged in because of existing session
				//outputTxt.text = "onInit, Logged In\n";
				//loginToggleBtn.label = "Log Out";
			} else {
				//outputTxt.text = "onInit, Not Logged In\n";
			}
		}
		
		protected function onLogin(result:Object, fail:Object):void {
			if (result) { //successfully logged in
				//outputTxt.text = "Logged In";
				//loginToggleBtn.label = "Log Out";
			} else {
				//outputTxt.appendText("Login Failed\n");				
			}
		}
		
		protected function onLogout(success:Boolean):void {			
			//outputTxt.text = "Logged Out";
			//loginToggleBtn.label = "Log In";				
		}	
		
		protected function handleLoginClick(event:MouseEvent):void {
			/*
			if (loginToggleBtn.label == "Log In") {				
				var opts:Object = {perms:"publish_stream, user_photos"};
				Facebook.login(onLogin, opts);
			} else {
				Facebook.logout(onLogout);
			}
			*/
		}
		
		protected function handleReqTypeChange(event:MouseEvent):void {
			/*
			if (getRadio.selected) {			
				paramsLabel.visible = paramsInput.visible = false; 
			} else {
				paramsLabel.visible = paramsInput.visible = true; //only POST request types have params
			}
			*/
		}
		
		protected function handleCallApiClick(event:MouseEvent):void {
			/*
			var requestType:String = getRadio.selected ? "GET" : "POST";
			var params:Object = null;	
			if (requestType == "POST") {
				try {
					JSON.decode(paramsInput.text);
				} catch (e:Error) {
					outputTxt.appendText("\n\nERROR DECODING JSON: " + e.message);
				}
			}
			
			Facebook.api(methodInput.text, onCallApi, params, requestType); //use POST to send data (as per Facebook documentation)
			*/
		}
		
		protected function onCallApi(result:Object, fail:Object):void {
			if (result) {
				//outputTxt.appendText("\n\nRESULT:\n" + JSON.encode(result)); 
			} else {
				//outputTxt.appendText("\n\nFAIL:\n" + JSON.encode(fail)); 
			}
		}
		
		protected function handleClearClick(event:MouseEvent):void {
			//outputTxt.text = "";
		}
		
		public function get dataProvider():Array {
			return friendsArrayList;
		}
		
		public function load():void {
			Facebook.api('/me/friends', handleFriendsLoad);
		}
		
		protected function handleFriendsLoad(response:Object, fail:Object):void {
			friendsArrayList.removeAll();
			if (fail) { return }
			var friendsIds:Array = [];
			
			var friends:Array = response as Array;
			
			var l:uint=friends.length;
			for (var i:uint=0;i<l;i++) {
				var friend:Object = friends[i];
				friendsArrayList.addItem(friend);
				friendsHash[friend.id] = friend;
				
				friendsIds.push(friend.id);
			}
			
			//To keep down on requests, load some details about your friends via fql.
			var friendsFQL:String = 'SELECT uid, profile_update_time, birthday_date, hometown_location, sex FROM user WHERE uid IN (' + friendsIds.join(',') + ')';
			Facebook.fqlQuery(friendsFQL, handleFriendsDataLoad);
		}
		
		protected function handleFriendsDataLoad(response:Object, fail:Object):void {
			if (fail) { return; }
			var friendDetails:Array = response as Array;
			
			var l:uint = friendDetails.length;
			
			for (var i:uint=0;i<l;i++) {
				var detailsObj:Object = friendDetails[i];
				var friendObj:Object = friendsHash[detailsObj.uid];
				for (var n:String in detailsObj) {
					friendObj[n] = detailsObj[n];
				}
				
				friendsArrayList.itemUpdated(friendObj);
			}
		}		
	}
}