// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:telegram_client/telegram_client.dart';
import 'package:path/path.dart' as p;

void main(List<String> arguments) async {
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
  int port = int.parse(Platform.environment["PORT"] ?? "8080");
  String host = Platform.environment["HOST"] ?? "0.0.0.0";
  String token_bot = Platform.environment["TOKEN_BOT"] ?? "";
  Map clientOption = {};
  TelegramBotApi tg = TelegramBotApi(
    token_bot,
    clientOption: clientOption,
  );

  app.all("/", (req, res) {
    return res.json({"@type": "ok"});
  });

  await app.listen(port, host);
}
