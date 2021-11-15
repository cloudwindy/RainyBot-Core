extends Node


const message_type_name:Array = [
	"Source",
	"Quote",
	"At",
	"AtAll",
	"Face",
	"Plain",
	"Image",
	"FlashImage",
	"Voice",
	"Xml",
	"Json",
	"App",
	"Poke",
	"Dice",
	"MusicShare",
	"ForwardMessage",
	"File",
	"MiraiCode"
]


var mirai_client:= MiraiClient.new()
var mirai_config_manager:=MiraiConfigManager.new()


func init():
	GuiManager.console_print_warning("正在加载内置模块: Mirai-Adapter 版本:V1.0-dev, 作者:Xwdit")
	add_to_group("command")
	var usages = [
		"mirai status - 获取与Mirai框架的连接状态",
		"mirai command <命令> - 向Mirai框架发送命令并显示回调(不支持额外参数)",
	]
	CommandManager.register_command("mirai",true,usages,"RainyBot-Core")
	mirai_config_manager.connect("config_loaded",Callable(self,"_mirai_config_loaded"))
	add_child(mirai_config_manager,true)
	add_child(mirai_client,true)
	mirai_config_manager.init_config()


func _mirai_config_loaded():
	mirai_client.connect_to_mirai(get_ws_url())


func _command_mirai(args:Array):
	match args[0]:
		"status":
			GuiManager.console_print_text("当前连接状态:"+str(is_bot_connected()))
			GuiManager.console_print_text("连接地址:"+get_ws_url())
		"command":
			if args.size() > 1:
				var result = await send_bot_request(args[1])
				GuiManager.console_print_text("收到回调: "+str(result))


func get_ws_url()->String:
	return mirai_config_manager.get_ws_address(mirai_config_manager.loaded_config)


func is_bot_connected()->bool:
	return mirai_client.is_bot_connected()


func get_bot_id()->int:
	return mirai_config_manager.get_bot_id()
	
	
func send_bot_request(_command,_sub_command=null,_content={},_timeout:float=20.0):
	return await mirai_client.send_bot_request(_command,_sub_command,_content,_timeout)
			
			
func perm2enum(perm:String)->int:
	match perm:
		"ADMINISTRATOR":
			return GroupMember.Permissions.ADMINISTRATOR
		"OWNER":
			return GroupMember.Permissions.OWNER
		_:
			return GroupMember.Permissions.MEMBER
			
			
func dic2msg(dic:Dictionary)->Message:
	if !dic.has("type"):
		return null
	match dic.type:
		"Source":
			return SourceMessage.init_meta(dic)
		"Quote":
			return QuoteMessage.init_meta(dic)
		"At":
			return AtMessage.init_meta(dic)
		"AtAll":
			return AtAllMessage.init_meta(dic)
		"Face":
			return FaceMessage.init_meta(dic)
		"Plain":
			return TextMessage.init_meta(dic)
		"Image":
			return ImageMessage.init_meta(dic)
		"FlashImage":
			return FlashImageMessage.init_meta(dic)
		"Voice":
			return VoiceMessage.init_meta(dic)
		"Xml":
			return XmlMessage.init_meta(dic)
		"Json":
			return JsonMessage.init_meta(dic)
		"App":
			return AppMessage.init_meta(dic)
		"Poke":
			return PokeMessage.init_meta(dic)
		"Dice":
			return DiceMessage.init_meta(dic)
		"MusicShare":
			return MusicShareMessage.init_meta(dic)
		"ForwardMessage":
			return ForwardMessage.init_meta(dic)
		"File":
			return FileMessage.init_meta(dic)
		"MiraiCode":
			return RainyCodeMessage.init_meta(dic)
		_:
			return null
