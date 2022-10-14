// ignore_for_file: non_constant_identifier_names, empty_catches

part of specta_bot_telegram;

class DefaultDataBase {
  static Map<String, String> get check_user => {
        "all": "free",
        "last_name": "free",
        "username": "free",
        "profile_photo": "free",
        "bio": "free",
        "sender_chat": "free",
      };
  static Map<String, String> get media => {
        "all": "free",
        "photo": "free",
        "video": "free",
        "media_group_id": "free",
        "animation": "free",
        "voice": "free",
        "audio": "free",
        "sticker": "free",
        "sticker_is_animated": "free",
        "dice": "free",
        "emoji_animate": "free",
        "video_note": "free",
      };
  static Map<String, String> get media_more => {
        "all": "free",
        "document": "free",
        "game": "free",
        "contact": "free",
        "poll": "free",
        "location": "free",
        "invoice": "free",
        "bot_inline": "free",
        "forward_date": "free",
        "reply_to_message": "free",
      };
  static Map<String, String> get content_message => {
        "all": "free",
        "mention": "free",
        "hashtag": "free",
        "cashtag": "free",
        "bot_command": "free",
        "url": "free",
        "email": "free",
        "phone_number": "free",
        "bold": "free",
        "italic": "free",
        "underline": "free",
        "strikethrough": "free",
        "spoiler": "free",
        "pre": "free",
      };
  static Map<String, dynamic> get content_message_option => {
        "type": "all",
        "mention": 1,
        "hashtag": 1,
        "cashtag": 1,
        "bot_command": 1,
        "url": 1,
        "email": 1,
        "phone_number": 1,
        "bold": 1,
        "italic": 1,
        "underline": 1,
        "strikethrough": 1,
        "spoiler": 1,
        "pre": 1,
        "text_length": 4096,
        "caption_length": 1024,
        "all_length": 4096,
      };
  static Map<String, String> get service_message => {
        "all": "free",
        "new_chat_members": "free",
        "left_chat_member": "free",
        "new_chat_title": "free",
        "new_chat_photo": "free",
        "delete_chat_photo": "free",
        "group_chat_created": "free",
        "supergroup_chat_created": "free",
        "channel_chat_created": "free",
        "message_auto_delete_timer_changed": "free",
        "successful_payment": "free",
        "voice_chat_scheduled": "free",
        "voice_chat_started": "free",
        "voice_chat_ended": "free",
        "voice_chat_participants_invited": "free",
      };
  static Map<String, String> get ai => {
        "all": "off",
        "chatbot": "off",
        "anti_spam": "off",
        "task": "off",
      };

  static Map get initData => {
        "state": {},
        "chatbots": [],
        "is_new_chat_member": true,
        "welcome_msg": {"date": 1661182872, "can_reply_to_message_id": false, "can_disable_web_page_preview": false, "can_allow_sending_without_reply": true, "can_deep_link": false, "can_response_callback_data": false, "can_send_chat_action": false, "acces_msg": "all", "request_api": "sendMessage", "type": "text", "text": "Hai {from_mention}\nSelamat datang di {chat_title}", "file_unique_id": "cuvdjcxvofj11ka", "from_user_id": -1001602177943, "from_platform": "telegram"},
        "service_message": {"new_chat_members": "free", "left_chat_member": "delete", "new_chat_title": "delete", "new_chat_photo": "delete", "delete_chat_photo": "delete", "group_chat_created": "delete", "supergroup_chat_created": "delete", "channel_chat_created": "delete", "message_auto_delete_timer_changed": "delete", "successful_payment": "delete", "voice_chat_scheduled": "delete", "voice_chat_started": "delete", "voice_chat_ended": "delete", "voice_chat_participants_invited": "delete"},
        "check_user": {
          "last_name": "free",
          "username": "free",
          "profile_photo": "free",
          "bio": "free",
          "sender_chat": "delete",
        },
        "content_message": {"mention": "free", "hashtag": "free", "cashtag": "free", "bot_command": "free", "url": "free", "email": "free", "phone_number": "free", "bold": "free", "italic": "free", "underline": "free", "strikethrough": "free", "spoiler": "free", "pre": "free"},
        "content_message_option": {
          "type": "all",
          "mention": "free",
          "hashtag": "free",
          "cashtag": "free",
          "bot_command": 1,
          "url": "free",
          "email": "free",
          "phone_number": "free",
          "bold": 1,
          "italic": "free",
          "underline": "free",
          "strikethrough": "free",
          "spoiler": "free",
          "pre": "free",
          "text_length": 4096,
          "caption_length": 1024,
          "all_length": 4096,
        },
        "media": {
          "photo": "free",
          "video": "free",
          "media_group_id": "free",
          "animation": "free",
          "voice": "free",
          "audio": "free",
          "sticker": "free",
          "sticker_is_animated": "free",
          "dice": "free",
          "emoji_animate": "free",
          "video_note": "free",
        },
        "media_more": {
          "document": "free",
          "game": "free",
          "contact": "free",
          "poll": "free",
          "location": "free",
          "invoice": "free",
          "bot_inline": "free",
          "forward_date": "delete",
          "reply_to_message": "free",
        }
      };

  static Map get autoForwardChat => {
        "is_force_subscribe": false,
        "is_forward": false,
        "is_on": false,
        "forward_type_content": [],
        "users": [],
        "option": {},
        "respond_msd": {},
        "ignore_msg": {},
        "trigger": "",
        "ignore_trigger": "",
        "is_limit": false,
        "count_limit": 10,
      };
}
 
 enum DatabaseType {
  supabase,
  hive
 }

class DatabaseTg {
  late DatabaseType databaseType;
  late Database supabaseDb;
  late Box hiveBox;
  late String from;
  late int botUserId;
  late Map dataDefault;
  late String path;
  DatabaseTg({
    required this.databaseType,
    required this.supabaseDb,
    required this.hiveBox,
    required this.from,
    required this.botUserId,
    required this.dataDefault,
    required this.path,
  });

  Future<List<Map>> getAlls() async {
    if (databaseType == DatabaseType.supabase) {
      List<Map> es = await supabaseDb.getAll(from: from);
      return es;
    }
    if (databaseType == DatabaseType.hive) {
      Directory dir = Directory(path);
      List<FileSystemEntity> dirs = dir.listSync();
      List<String> array = [];
      for (var i = 0; i < dirs.length; i++) {
        try {
          FileSystemEntity loopData = dirs[i];
          if (RegExp(r"[0-9]+\.hive$", caseSensitive: false).hasMatch(loopData.path)) {
            String? getDataId = RegExp(r"[0-9]+\.hive").stringMatch(loopData.path);
            if (getDataId != null) {
              array.add(getDataId.replaceAll(RegExp(r"\.hive", caseSensitive: false), ""));
            }
          }
        } catch (e) {}
      }
      List<Map> jsonRes = [];
      for (var i = 0; i < array.length; i++) {
        try {
          var bot_user_id = array[i];
          Box boxBot = await Hive.openBox(bot_user_id);
          jsonRes.add(boxBot.toMap());
        } catch (e) {}
      }
      return jsonRes;
    }
    return [];
  }

  Future<Map?> getChat({
    required String chat_type,
    required int chat_id,
    bool isSaveNotFound = true,
    Map? value,
  }) async {
    value ??= {};
    List<Map> getDatas = await getChats(chat_type, defaultValue: []);
    value["id"] = chat_id;
    for (var i = 0; i < getDatas.length; i++) {
      Map loopData = getDatas[i];
      if (loopData["id"] == chat_id) {
        return loopData;
      }
    }
    if (isSaveNotFound) {
      try {
        getDatas.add(value);
      } catch (e) {
        late Map jsonData = {};
        jsonData.forEach((key, value) {
          jsonData[key] = value;
        });
        getDatas.add(jsonData);
      }
      await saveChats(chat_type, getDatas);
      return value;
    }
    return null;
  }

  Future<bool> saveChat({required String chat_type, required int chat_id, required Map newData}) async {
    List<Map> getDatas = await getChats(chat_type, defaultValue: [newData]);
    for (var i = 0; i < getDatas.length; i++) {
      Map loopData = getDatas[i];
      if (loopData["id"] == chat_id) {
        if (loopData.runtimeType.toString() == newData.runtimeType.toString()) {
          loopData.addAll(newData);
        } else {
          newData.forEach((key, value) {
            loopData[key] = value;
          });
        }
        return await saveChats(chat_type, getDatas);
      }
    }
    return false;
  }

  Future<List<Map>> getChats(
    String chat_type, {
    required List<Map> defaultValue,
  }) async {
    if (databaseType == DatabaseType.supabase) {
      Map? es = await supabaseDb.getMatch(from: from, query: {"bot_user_id": botUserId});
      if (es == null) {
        await supabaseDb.add(from: from, data: dataDefault);
        return defaultValue;
      }
      if (es.containsKey(chat_type)) {
        return (es[chat_type] as List).cast<Map>();
      } else {
        return defaultValue;
      }
    }
    if (databaseType == DatabaseType.hive) {
      var getData = hiveBox.get(chat_type, defaultValue: defaultValue);
      if (getData is List) {
        return getData.cast<Map>();
      } else {
        await hiveBox.put(chat_type, []);
        return [].cast<Map>();
      }
    }
    return [].cast<Map>();
  }

  Future<bool> saveChats(String chatType, List<Map> value) async {
    if (databaseType == DatabaseType.supabase) {
      late Map dataUpdate = {};
      dataUpdate[chatType] = value;
      await supabaseDb.update(
        from: from,
        dataOrigin: {
          "bot_user_id": botUserId,
        },
        dataUpdate: dataUpdate,
      );
      return true;
    }
    if (databaseType == DatabaseType.hive) {
      await hiveBox.put(chatType, value);
      return true;
    }
    return false;
  }

  Future<void> checkChat({
    required String chat_type,
    required List<Map> getDatas,
    required Map getData,
  }) async {
    late bool isFound = false;
    try {
      if (getData["admins"] is List == false) {
        isFound = true;
        getData["admins"] = [];
      }
      if (getData["admin_user_ids"] is List == false) {
        isFound = true;
        getData["admin_user_ids"] = [];
      }
      if (getData["chatbots"] is List == false) {
        isFound = true;
        getData["chatbots"] = [];
      }
      if (getData["state"] is Map == false) {
        isFound = true;
        getData["state"] = {};
      }
      if (getData["delay_spam"] is Map == false) {
        isFound = true;
        getData["delay_spam"] = {};
        if (getData["delay_spam"]["responds"] is List == false) {
          getData["delay_spam"]["responds"] = [];
        }
      }
      if (getData["auto_forwards"] is List == false) {
        isFound = true;
        getData["auto_forwards"] = [];
      }
      if (getData["users"] is List == false) {
        isFound = true;
        getData["users"] = [];
      }
      if (getData["check_user"] is Map == false) {
        isFound = true;
        getData["check_user"] = DefaultDataBase.check_user;
      }
      if (getData["content_message"] is Map == false) {
        isFound = true;
        getData["content_message"] = DefaultDataBase.content_message;
      }

      if (getData["content_message_option"] is Map == false) {
        isFound = true;
        getData["content_message_option"] = DefaultDataBase.content_message_option;
      }
      if (getData["media"] is Map == false) {
        isFound = true;
        getData["media"] = DefaultDataBase.media;
      }
      if (getData["media_more"] is Map == false) {
        isFound = true;
        getData["media_more"] = DefaultDataBase.media_more;
      }

      if (getData["service_message"] is Map == false) {
        isFound = true;
        getData["service_message"] = DefaultDataBase.service_message;
      }
    } catch (e) {}

    if (isFound) {
      try {
        await saveChats(chat_type, getDatas);
      } catch (e) {}
    }
  }
}
 