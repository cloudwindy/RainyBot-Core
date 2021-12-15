extends CoreAPI


class_name Bot


static func get_id()->int:
	return BotAdapter.get_bot_id()
	

static func get_friend_list()->MemberList:
	var _result:Dictionary = await BotAdapter.send_bot_request("friendList",null,null)
	var _arr:Array = _result["data"]
	var _ins:MemberList = MemberList.init_meta(_arr)
	return _ins
	
	
static func get_group_list()->GroupList:
	var _result:Dictionary = await BotAdapter.send_bot_request("groupList",null,null)
	var _arr:Array = _result["data"]
	var _ins:GroupList = GroupList.init_meta(_arr)
	return _ins


static func get_profile()->MemberProfile:
	var _result:Dictionary = await BotAdapter.send_bot_request("botProfile",null,null)
	var _ins:MemberProfile = MemberProfile.init_meta(_result)
	return _ins


static func get_cache_message(msg_id:int)->CacheMessage:
	var _req_dic = {
		"id":msg_id
	}
	var _result_dic:Dictionary = await BotAdapter.send_bot_request("messageFromId",null,_req_dic)
	var ins = CacheMessage.init_meta(_result_dic["data"])
	return ins