extends Node


var mirai_client:MiraiClient = MiraiClient.new()
var mirai_loader:MiraiLoader = MiraiLoader.new()
var mirai_config_manager:MiraiConfigManager = MiraiConfigManager.new()

var group_message_count:int = 0
var private_message_count:int = 0
var sent_message_count:int = 0


func start()->void:
	GuiManager.console_print_warning("正在加载模块: Mirai-Adapter | 版本: %s | 作者: Xwdit" % RainyBotCore.VERSION)
	add_to_group("console_command_mirai")
	var usages:Array = [
		"mirai status - 获取与Mirai框架的连接状态",
		"mirai restart - 在Mirai主进程被关闭后重新启动Mirai框架",
		"mirai command <命令> - 向Mirai框架发送命令并显示回调(不支持额外参数)",
	]
	CommandManager.register_console_command("mirai",true,usages,"Mirai-Adapter",false)
	mirai_config_manager.connect("config_loaded",_mirai_config_loaded)
	mirai_config_manager.name = "MiraiConfigManager"
	mirai_client.name = "MiraiClient"
	mirai_loader.name = "MiraiLoader"
	add_child(mirai_config_manager,true)
	add_child(mirai_client,true)
	add_child(mirai_loader,true)
	mirai_config_manager.init_config()


func _mirai_config_loaded()->void:
	mirai_client.connect_to_mirai(get_ws_url())


func _call_console_command(_cmd:String,args:Array)->void:
	match args[0]:
		"status":
			GuiManager.console_print_text("当前协议后端连接状态: "+("已连接" if is_bot_connected() else "未连接"))
			GuiManager.console_print_text("连接地址: "+get_ws_url())
		"restart":
			mirai_loader.load_mirai()
		"command":
			if args.size() > 1:
				var result:Dictionary = await send_bot_request(args[1])
				GuiManager.console_print_text("收到回调: "+str(result))


func get_ws_url()->String:
	return mirai_config_manager.get_ws_address(mirai_config_manager.loaded_config)


func is_bot_connected()->bool:
	return mirai_client.is_bot_connected()


func get_bot_id()->int:
	return mirai_config_manager.get_bot_id()
	
	
func send_bot_request(_command:String,_sub_command:String="",_content:Dictionary={},_timeout:float=-INF)->Dictionary:
	if _timeout <= -INF and mirai_config_manager.get_request_timeout() > 0.0:
		_timeout=mirai_config_manager.get_request_timeout()
	if _command.begins_with("send") and _command.ends_with("Message"):
		sent_message_count += 1
	return await mirai_client.send_bot_request(_command,_sub_command,_content,_timeout)
			
			
func parse_permission_text(perm:String)->int:
	match perm:
		"ADMINISTRATOR":
			return GroupMember.Permission.ADMINISTRATOR
		"OWNER":
			return GroupMember.Permission.OWNER
	return GroupMember.Permission.MEMBER
			
			
func parse_message_dic(dic:Dictionary)->Message:
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
		"MarketFace":
			return MarketFaceMessage.init_meta(dic)
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
		"Forward":
			return ForwardMessage.init_meta(dic)
		"File":
			return FileMessage.init_meta(dic)
		"MiraiCode":
			return BotCodeMessage.init_meta(dic)
	return null


func parse_event(result_dic:Dictionary)->void:
	var ins:Event
	var event_dic:Dictionary = result_dic["data"]
	var event_name:String = event_dic["type"]
	match event_name:
		"FriendMessage":
			ins = FriendMessageEvent.init_meta(event_dic)
			private_message_count += 1
		"GroupMessage":
			ins = GroupMessageEvent.init_meta(event_dic)
			group_message_count += 1
		"TempMessage":
			ins = TempMessageEvent.init_meta(event_dic)
			private_message_count += 1
		"StrangerMessage":
			ins = StrangerMessageEvent.init_meta(event_dic)
			private_message_count += 1
		"OtherClientMessage":
			ins = OtherClientMessageEvent.init_meta(event_dic)
			private_message_count += 1
		"NudgeEvent":
			ins = NudgeEvent.init_meta(event_dic)
		"BotOnlineEvent":
			ins = BotOnlineEvent.init_meta(event_dic)
		"BotOfflineEventActive":
			ins = BotOfflineEvent.init_meta(event_dic,BotOfflineEvent.ReasonType.ACTIVE)
		"BotOfflineEventForce":
			ins = BotOfflineEvent.init_meta(event_dic,BotOfflineEvent.ReasonType.FORCE)
		"BotOfflineEventDropped":
			ins = BotOfflineEvent.init_meta(event_dic,BotOfflineEvent.ReasonType.DROPPED)
		"BotReloginEvent":
			ins = BotReloginEvent.init_meta(event_dic)
		"FriendInputStatusChangedEvent":
			ins = FriendInputStatusChangeEvent.init_meta(event_dic)
		"FriendNickChangedEvent":
			ins = FriendNickChangeEvent.init_meta(event_dic)
		"FriendRecallEvent":
			ins = FriendRecallEvent.init_meta(event_dic)
		"BotGroupPermissionChangeEvent":
			ins = BotPermChangeEvent.init_meta(event_dic)
		"BotMuteEvent":
			ins = BotMuteEvent.init_meta(event_dic)
		"BotUnmuteEvent":
			ins = BotUnmuteEvent.init_meta(event_dic)
		"BotJoinGroupEvent":
			ins = BotJoinGroupEvent.init_meta(event_dic)
		"BotLeaveEventActive":
			ins = BotLeaveGroupEvent.init_meta(event_dic,BotLeaveGroupEvent.ReasonType.ACTIVE)
		"BotLeaveEventKick":
			ins = BotLeaveGroupEvent.init_meta(event_dic,BotLeaveGroupEvent.ReasonType.KICK)
		"BotLeaveEventDisband":
			ins = BotLeaveGroupEvent.init_meta(event_dic,BotLeaveGroupEvent.ReasonType.DISBAND)
		"GroupRecallEvent":
			ins = GroupRecallEvent.init_meta(event_dic)
		"GroupNameChangeEvent":
			ins = GroupNameChangeEvent.init_meta(event_dic)
		"GroupEntranceAnnouncementChangeEvent":
			ins = GroupAnnounceChangeEvent.init_meta(event_dic)
		"GroupMuteAllEvent":
			ins = GroupMuteAllEvent.init_meta(event_dic)
		"GroupAllowAnonymousChatEvent":
			ins = GroupAllowAnonyChatEvent.init_meta(event_dic)
		"GroupAllowConfessTalkEvent":
			ins = GroupAllowConfessTalkEvent.init_meta(event_dic)
		"GroupAllowMemberInviteEvent":
			ins = GroupAllowInviteEvent.init_meta(event_dic)
		"MemberJoinEvent":
			ins = MemberJoinEvent.init_meta(event_dic)
		"MemberLeaveEventKick":
			ins = MemberLeaveEvent.init_meta(event_dic,MemberLeaveEvent.ReasonType.KICK)
		"MemberLeaveEventQuit":
			ins = MemberLeaveEvent.init_meta(event_dic,MemberLeaveEvent.ReasonType.QUIT)
		"MemberMuteEvent":
			ins = MemberMuteEvent.init_meta(event_dic)
		"MemberUnmuteEvent":
			ins = MemberUnmuteEvent.init_meta(event_dic)
		"MemberHonorChangeEvent":
			ins = MemberHonorChangeEvent.init_meta(event_dic)
		"MemberCardChangeEvent":
			ins = MemberNameChangeEvent.init_meta(event_dic)
		"MemberPermissionChangeEvent":
			ins = MemberPermChangeEvent.init_meta(event_dic)
		"MemberSpecialTitleChangeEvent":
			ins = MemberTitleChangeEvent.init_meta(event_dic)
		"NewFriendRequestEvent":
			ins = NewFriendRequestEvent.init_meta(event_dic)
		"MemberJoinRequestEvent":
			ins = MemberJoinRequestEvent.init_meta(event_dic)
		"BotInvitedJoinGroupRequestEvent":
			ins = GroupInviteRequestEvent.init_meta(event_dic)
		"OtherClientOnlineEvent":
			ins = OtherClientOnlineEvent.init_meta(event_dic)
		"OtherClientOfflineEvent":
			ins = OtherClientOfflineEvent.init_meta(event_dic)
		_:
			return
			
	PluginManager.call_event(ins)
