extends GroupBotEvent


class_name BotPermissionChangeEvent


var data_dic:Dictionary = {
	"type": "BotGroupPermissionChangeEvent",
	"origin": "",
	"current": "",
	"group": {
		"id": 0,
		"name": "",
		"permission": ""
	}
}


static func init_meta(dic:Dictionary)->BotPermissionChangeEvent:
	var ins:BotPermissionChangeEvent = BotPermissionChangeEvent.new()
	ins.data_dic = dic
	return ins
	
	
func get_origin_permission()->int:
	return BotAdapter.parse_permission_text(data_dic.origin)
	

func get_current_permission()->int:
	return BotAdapter.parse_permission_text(data_dic.current)
	
	
func get_group()->Group:
	return Group.init_meta(data_dic.group)
