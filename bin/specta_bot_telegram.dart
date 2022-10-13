// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:telegram_client/telegram_client.dart';

void main(List<String> arguments) async {
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
