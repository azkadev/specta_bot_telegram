// ignore_for_file: non_constant_identifier_names, unused_local_variable, empty_catches, unused_import

import 'dart:convert';
import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
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
  String token_bot = Platform.environment["TOKEN_BOT"] ?? "";

  String current_path = Directory.current.path;
  String database_bot_path = p.join(current_path, "db_bot");
  EventEmitter emitter = EventEmitter();
  Alfred app = Alfred(
    onNotFound: (req, res) {
      return res.json({"@type": "error"});
    },
    onInternalError: (req, res) {
      return {"ok": false};
    },
  );
  Map clientOption = {};
  TelegramBotApi tg = TelegramBotApi(
    token_bot,
    clientOption: clientOption,
  );
  WebSocketClient webSocketClient = WebSocketClient(host_name, eventEmitter: emitter, eventNameUpdate: "specta_apis_update_bot_tg");
  Database supabase_db = Database("id", "");
  //DatabaseTg database = DatabaseTg(databaseType: databaseType, supabaseDb: supabase_db, hiveBox: hiveBox, from: from, botUserId: botUserId, dataDefault: dataDefault, path: database_bot_path);

  // app.get('/*', (req, res) {
  //   try {
  //     return Directory('web/');
  //   } catch (e) {}
  // });
  app.all("/", (req, res) {
    return res.json({"@type": "ok"});
    // try {
    //   res.headers.contentType = ContentType.html;
    //   return File(p.join(current_path, "web", "index.html"));
    // } catch (e) {
    //   return res.json({"@type": "ok"});
    // }
  });

  //await runBot(app: app, emitter: emitter, tg: tg, database: database, supabase_db: supabase_db, pathBot: pathBot, clientOption: clientOption, eventBot: eventBot, productionType: productionType, galaxeus: galaxeus);
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
  await app.listen(port, host);
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
}
