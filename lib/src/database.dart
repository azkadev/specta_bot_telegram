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

enum DatabaseType { supabase, hive }

enum DatabaseDataType { bot, userbot }

class DatabaseLib {
  late DatabaseType databaseType;
  late Database supabase_db;
  late Box hive_db;
  DatabaseLib({
    required this.databaseType,
    required this.supabase_db,
    required this.hive_db,
  });
}

class DatabaseTg {
  late DatabaseLib databaseLib;
  late Directory directory;
  DatabaseTg({
    required this.databaseLib,
    required this.directory,
  });

  Directory getDirectory({DatabaseDataType databaseDataType = DatabaseDataType.bot}) {
    Directory dir = Directory(p.join(directory.path, databaseDataType.name));
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return dir;
  }

  Future<Map?> getData({
    required int account_id,
    required DatabaseDataType databaseDataType,
    bool isSaveNotFound = true,
    Map? value,
    String from = "telegram",
  }) async {
    value ??= {};
    if (databaseLib.databaseType == DatabaseType.supabase) {
      Map? get_data = await databaseLib.supabase_db.getMatch(from: from, query: {
        "id": account_id,
      });
      if (get_data == null) {
        if (isSaveNotFound) {
          Map new_data = {};
          try {
            new_data.addAll(value);
          } catch (e) {
            value.forEach((key, value) {
              new_data[key] = value;
            });
          }
          await saveData(account_id: account_id, databaseDataType: databaseDataType, newValue: value);
        } else {
          return null;
        }
        return null;
      }
      return get_data;
    }
    if (databaseLib.databaseType == DatabaseType.hive) {
      Directory dir = getDirectory(databaseDataType: databaseDataType);
      Box box = await Hive.openBox("${account_id}", path: dir.path);
      if (box.isEmpty) {
        if (isSaveNotFound) {
          late Map get_data = box.toMap();
          try {
            get_data.addAll(value);
          } catch (e) {
            value.forEach((key, value) {
              get_data[key] = value;
            });
          }
          await saveData(account_id: account_id, databaseDataType: databaseDataType, newValue: value);
          return get_data;
        } else {
          return null;
        }
      }
      return box.toMap();
    }
    return null;
  }

  Future<bool> saveData({
    required int account_id,
    required DatabaseDataType databaseDataType,
    required Map newValue,
    String from = "telegram",
  }) async {
    if (databaseLib.databaseType == DatabaseType.supabase) {
      await databaseLib.supabase_db.update(
        from: from,
        dataOrigin: {
          "id": account_id,
        },
        dataUpdate: newValue,
      );
      return true;
    }
    if (databaseLib.databaseType == DatabaseType.hive) {
      Directory dir = getDirectory(databaseDataType: databaseDataType);
      Box box = await Hive.openBox("${account_id}", path: dir.path);
      box.putAll(newValue);
      return true;
    }
    return false;
  }

  Future<List<Map>> getAlls({String from = "telegram"}) async {
    if (databaseLib.databaseType == DatabaseType.supabase) {
      List<Map> es = await databaseLib.supabase_db.getAll(from: from);
      return es;
    }
    if (databaseLib.databaseType == DatabaseType.hive) {
      Directory dir = getDirectory();
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
    required int bot_user_id,
  }) async {
    value ??= {};
    List<Map> getDatas = await getChats(chat_type: chat_type, defaultValue: {}, bot_user_id: bot_user_id);
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
      await saveChats(chat_type: chat_type, value: getDatas, bot_user_id: bot_user_id);
      return value;
    }
    return null;
  }

  Future<bool> saveChat({
    required String chat_type,
    required int chat_id,
    required Map newData,
    required int bot_user_id,
  }) async {
    List<Map> getDatas = await getChats(chat_type: chat_type, defaultValue: newData, bot_user_id: bot_user_id);
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
        await saveChats(chat_type: chat_type, value: getDatas, bot_user_id: bot_user_id);
      }
    }
    return false;
  }

  Future<List<Map>> getChats({
    required String chat_type,
    required Map defaultValue,
    required int bot_user_id,
    String from = "telegram",
  }) async {
    if (databaseLib.databaseType == DatabaseType.supabase) {
      Map? es = await databaseLib.supabase_db.getMatch(from: from, query: {"bot_user_id": bot_user_id});
      if (es == null) {
        await databaseLib.supabase_db.add(from: from, data: defaultValue);
        return [defaultValue];
      }
      if (es.containsKey(chat_type)) {
        return (es[chat_type] as List).cast<Map>();
      } else {
        return [defaultValue];
      }
    }
    if (databaseLib.databaseType == DatabaseType.hive) {
      var getData = databaseLib.hive_db.get(chat_type, defaultValue: defaultValue);
      if (getData is List) {
        return getData.cast<Map>();
      } else {
        await databaseLib.hive_db.put(chat_type, []);
        return [].cast<Map>();
      }
    }
    return [].cast<Map>();
  }

  Future<bool> saveChats({required String chat_type, required List<Map> value, required int bot_user_id, String from = "telegram"}) async {
    if (databaseLib.databaseType == DatabaseType.supabase) {
      late Map dataUpdate = {};
      dataUpdate[chat_type] = value;
      await databaseLib.supabase_db.update(
        from: from,
        dataOrigin: {
          "bot_user_id": bot_user_id,
        },
        dataUpdate: dataUpdate,
      );
      return true;
    }
    if (databaseLib.databaseType == DatabaseType.hive) {
      await databaseLib.hive_db.put(chat_type, value);
      return true;
    }
    return false;
  }

  Future<void> checkChat({
    required String chat_type,
    required List<Map> getDatas,
    required Map getData,
    required int bot_user_id,
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
        await saveChats(chat_type: chat_type, value: getDatas, bot_user_id: bot_user_id);
      } catch (e) {}
    }
  }
}
