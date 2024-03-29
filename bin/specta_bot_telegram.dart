// ignore_for_file: non_constant_identifier_names, unused_local_variable, empty_catches, unused_import, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:hive/hive.dart';
import 'package:specta_bot_telegram/specta_bot_telegram.dart';
import 'package:supabase_client/supabase.dart';
import 'package:telegram_client/telegram_client.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
  String username_ws = Platform.environment["username_ws"] ?? "admin";
  String password_ws = Platform.environment["password_ws"] ?? "azka123";
  String host_name = Platform.environment["HOST_API"] ?? "wss://specta-apis.up.railway.app/ws";
  int port = int.parse(Platform.environment["PORT"] ?? "8080");
  String host = Platform.environment["HOST"] ?? "0.0.0.0";
  int tg_api_id = int.parse(Platform.environment["tg_api_id"] ?? "0");
  String tg_api_hash = Platform.environment["tg_api_hash"] ?? "0";
  String tg_token_bot = Platform.environment["tg_token_bot"] ?? "0";
  int tg_owner_user_id = int.parse(Platform.environment["tg_owner_user_id"] ?? "0");
  String supabase_id = Platform.environment["supabase_id"] ?? "0";
  String supabase_key = Platform.environment["supabase_key"] ?? "0";

  String tg_event_invoke = "tg_invoke";
  String tg_event_update = "tg_update";

  String current_path = Directory.current.path;
  Directory tg_bot_dir = Directory(p.join(current_path, "specta_bot_telegram"));
  Directory tg_bot_db_dir = Directory(p.join(tg_bot_dir.path, "db"));
  String database_bot_path = p.join(current_path, "db_bot");
  String tg_bot_api_path = p.join(current_path, "tg-bot-api");
  Directory tg_bot_api_dir = Directory(tg_bot_api_path);
  if (!tg_bot_api_dir.existsSync()) {
    tg_bot_api_dir.createSync(recursive: true);
  }
  EventEmitter emitter = EventEmitter();
  Alfred app = Alfred(
    onNotFound: (req, res) {
      return res.json({"@type": "error"});
    },
    onInternalError: (req, res) {
      return {"ok": false};
    },
  );
  TelegramBotApiServer telegramBotApiServer = TelegramBotApiServer();
  await telegramBotApiServer.run(
    executable: "./telegram_bot_api",
    arguments: telegramBotApiServer.optionsParameters(
      local: "yes",
      api_id: "${tg_api_id}",
      api_hash: tg_api_hash,
      http_port: "9000",
      dir: tg_bot_api_path,
    ),
  );

  Map clientOption = {};
  TelegramBotApi tg = TelegramBotApi(
    tg_token_bot,
    clientOption: clientOption,
  );
  WebSocketClient webSocketClient = WebSocketClient(
    host_name,
    eventEmitter: emitter,
    eventNameUpdate: "specta_apis_update_bot_tg",
    eventNameInvoke: "specta_apis_invoke_bot_tg",
  );
  Database supabase_db = Database(supabase_id, supabase_key);
  int bot_user_id = int.parse(tg_token_bot.split(":")[0]);
  Box boxBot = await Hive.openBox(bot_user_id.toString(), path: database_bot_path);
  var dataDefault = {
    "id": bot_user_id,
    "bot_user_id": bot_user_id,
    "type_bot": "typeBot",
    "token_bot": tg_token_bot,
    "owner_user_id": tg_owner_user_id,
  };

  dataDefault.forEach((key, value) async {
    try {
      var getData = boxBot.get(key);
      if (getData != value) {
        await boxBot.put(key, value);
      }
    } catch (e) {}
  });
  DatabaseTg databaseTg = DatabaseTg(
    databaseLib: DatabaseLib(
      databaseType: DatabaseType.hive,
      supabase_db: supabase_db,
      hive_db: boxBot,
    ),
    directory: tg_bot_db_dir,
  );

  app.all("/", (req, res) {
    return res.json({"@type": "ok"});
  });

  await runBot(
    app: app,
    emitter: emitter,
    tg: tg,
    databaseLib: databaseTg.databaseLib,
    tg_bot_dir: tg_bot_dir,
    tg_bot_db_dir: tg_bot_db_dir,
    clientOption: clientOption,
    productionType: ProductionType.live,
    event_update_bot: tg_event_update,
    webSocketClient: webSocketClient,
  );

  webSocketClient.on(webSocketClient.event_name_update, (update) {
    try {
      if (update is Map) {
        if (update["@type"] is String == false) {
          return;
        }
        String method = (update["@type"] as String);
        print(update);
      }
    } catch (e) {
      print(e);
    }
  });
  await webSocketClient.connect(
    onDataUpdate: (data) {
      if (data is String && data.isNotEmpty) {
        try {
          return webSocketClient.event_emitter.emit(webSocketClient.event_name_update, null, json.decode(data));
        } catch (e) {}
      }
    },
    onDataConnection: (data) {
      print(data);
    },
  );
  await app.listen(port, host);
}
