library specta_bot_telegram;

import 'package:alfred/alfred.dart';
import 'package:galaxeus/galaxeus.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:telegram_client/telegram_client.dart';

import 'package:path/path.dart' as p;

Future<dynamic> bot({
  required UpdateBot updateBot,
  required TelegramBotApi tg,
  required Database database,
  required String path,
  required ProductionType productionType,
}) async {}

Future<void> runBot({
  required Alfred app,
  required EventEmitter emitter,
  required TelegramBotApi tg,
  required Database database,
  required String pathBot,
  required Map clientOption,
  required String eventBot,
  required ProductionType productionType,
  required Galaxeus galaxeus,
}) async {
  emitter.on(eventBot, null, (ev, context) async {
    if (ev.eventData is UpdateBot) {
      try {
        await bot(
          updateBot: (ev.eventData as UpdateBot),
          tg: tg,
          database: database,
          path: pathBot,
          productionType: productionType,
        );
      } catch (e) {}
      return;
    }
  });
  app.post("/telegram/webhook", (HttpRequest req, HttpResponse res) async {
    try {
      Map<String, String> query = req.uri.queryParameters;
      Map<String, dynamic> body = await req.bodyAsJsonMap;
      emitter.emit(
        eventBot,
        null,
        UpdateBot(body: body, query: query),
      );
      return {
        "status": 200,
        "result": {},
      };
    } catch (e) {
      return {
        "status": 200,
        "result": {},
      };
    }
  });
  // DatabaseTg dbBot = DatabaseTg(
  //   type: databaseType,
  //   supabaseDb: supabase_db,
  //   hiveBox: dbTelegram,
  //   from: "telegram",
  //   botUserId: 1213131,
  //   dataDefault: {},
  //   path: p.join(pathBot, "bot"),
  // );
  //initTaskBot(DatabaseTg: dbBot, tg: TelegramBotApi(tg.token_bot, clientOption: clientOption));
  print("init task bot");
  return;
}

class Database {}

class UpdateBot {
  final Map<String, dynamic> body;
  final Map<String, String> query;
  UpdateBot({
    required this.body,
    required this.query,
  });
}
