extends Control


func _ready()->void:
	DisplayServer.window_set_title("RainyBot")
	ConfigManager.init_config()
	update_tabs()
	GuiManager.console_print_success("成功加载 RainyBot-Gui | 版本: %s | 作者: Xwdit" % RainyBotCore.VERSION)
	if ConfigManager.is_update_enabled() and !await UpdateManager.check_update():
		GuiManager.console_print_warning("将于10秒后继续启动RainyBot...")
		await get_tree().create_timer(10).timeout
	RainyBotCore.start()


func _physics_process(_delta:float)->void:
	$Status.text = "协议后端:Mirai | %s | Bot ID:%s" % ["已连接" if BotAdapter.is_bot_connected() else "未连接", str(BotAdapter.get_bot_id()) if BotAdapter.get_bot_id()!=0 else "未配置"]
	if !UpdateManager.updating:
		var times_dic:Dictionary = Time.get_time_dict_from_unix_time(GlobalManager.global_run_time)
		var time:String = "{hour}小时{minute}分钟".format(times_dic)
		DisplayServer.window_set_title("RainyBot - %s | 已运行时长: %s | 群聊消息: %s条 | 私聊消息: %s条 | 已发送消息: %s条" % [str(BotAdapter.get_bot_id()) if BotAdapter.get_bot_id()!=0 else "未配置账号",time,BotAdapter.group_message_count,BotAdapter.private_message_count,BotAdapter.sent_message_count])


func update_tabs():
	$TabContainer.set_tab_title(0,"控制台")
	$TabContainer.set_tab_icon(0,get_theme_icon("Window","EditorIcons"))
	$TabContainer.set_tab_title(1,"插件管理器")
	$TabContainer.set_tab_icon(1,get_theme_icon("PluginScript","EditorIcons"))
