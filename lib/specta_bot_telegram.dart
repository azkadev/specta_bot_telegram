// ignore_for_file: unused_import, non_constant_identifier_names

library specta_bot_telegram;

import 'dart:async';
import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:galaxeus/galaxeus.dart';
import 'package:galaxeus_lib/galaxeus_lib.dart';
import 'package:supabase_client/supabase.dart';
import 'package:telegram_client/telegram_client.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;

part "src/database.dart";
part "src/update_callback_query.dart";
part "src/update_message.dart";

Future<dynamic> bot({
  required UpdateBot updateBot,
  required TelegramBotApi tg,
  required DatabaseTg database,
  required String path,
  required ProductionType productionType,
}) async {
  try {
    late Map query = updateBot.query;
    Map update = updateBot.body;
    if (query["token"] == null || (query["token"] as String).isEmpty) {
      return {"ok": false, "message": "please add token"};
    }
    String tokenBot = (query["token"] as String);
    if (!RegExp(r"^[0-9]{8,10}:[a-zA-Z0-9_-]{35}$", caseSensitive: false).hasMatch(tokenBot)) {
      return {"ok": false, "message": "token invalid"};
    }
    late int ownerUserId = 0;
    late String typeBot = "";
    late String usernameBot = "";
    if (query["owner_user_id"] is String && RegExp(r"^([0-9]+)$", caseSensitive: false).hasMatch(query["owner_user_id"])) {
      ownerUserId = int.parse(query["owner_user_id"]);
    } else {
      late Map deleteWebhook = {};
      try {
        deleteWebhook = await tg.request("deleteWebhook", tokenBot: tokenBot);
      } catch (e) {
        if (e is Map) {
          deleteWebhook = e;
        }
      }
      return deleteWebhook;
    }

    if (query["type_bot"] is String) {
      typeBot = query["type_bot"];
    } else {
      try {
        await tg.request("deleteWebhook", tokenBot: tokenBot);
      } catch (e) {}
      return null;
    }
    if (query["username_bot"] is String) {
      usernameBot = query["username_bot"];
    }

    if ((!RegExp(r"bot$", caseSensitive: false).hasMatch(usernameBot) || usernameBot.isEmpty)) {
      try {
        Map getWebhook = await tg.request("getWebhookInfo", tokenBot: tokenBot);
        Map getMe = await tg.request("getMe", tokenBot: tokenBot);
        String urlWebhook = (getWebhook["result"]["url"] as String);
        await tg.request(
          "setWebhook",
          parameters: {
            "url": Uri.parse(urlWebhook).replace(queryParameters: {
              ...Uri.parse(urlWebhook).queryParameters,
              "username_bot": getMe["result"]["username"],
            }).toString(),
          },
          tokenBot: tokenBot,
        );
      } catch (e) {}
    }
    int bot_user_id = int.parse(tokenBot.split(":")[0]);
    Box boxBot = await Hive.openBox(bot_user_id.toString(), path: path);
    var dataDefault = {
      "id": bot_user_id,
      "bot_user_id": bot_user_id,
      "type_bot": typeBot,
      "token_bot": tokenBot,
      "owner_user_id": ownerUserId,
    };

    dataDefault.forEach((key, value) async {
      try {
        var getData = boxBot.get(key);
        if (getData != value) {
          await boxBot.put(key, value);
        }
      } catch (e) {}
    });
    DatabaseTg dbBot = DatabaseTg(
      databaseType: database.databaseType,
      supabaseDb: database.supabaseDb,
      hiveBox: boxBot,
      from: "telegram",
      botUserId: bot_user_id,
      dataDefault: dataDefault,
      path: path,
    );

    // if (update["inline_query"] is Map) {
    //   return await inlineQuery(
    //     update["inline_query"],
    //     tokenBot: tokenBot,
    //     tg: tg,
    //     dbTelegram: dbTelegram,
    //     ownerUserId: ownerUserId,
    //     typeBot: typeBot,
    //     dbBot: dbBot,
    //     bot_user_id: bot_user_id,
    //     username_bot: usernameBot,
    //     productionType: productionType,
    //   );
    // }

    // if (update["callback_query"] is Map) {
    //   return await callbackQuery(update["callback_query"], tokenBot: tokenBot, tg: tg, dbTelegram: dbTelegram, ownerUserId: ownerUserId, typeBot: typeBot, dbBot: dbBot, bot_user_id: bot_user_id, username_bot: usernameBot, walletApi: walletApi, productionType: productionType);
    // }

    if (update["edited_channel_post"] is Map) {
      return await updateMessage(update["edited_channel_post"], updateBot: updateBot, tokenBot: tokenBot, tg: tg, ownerUserId: ownerUserId, typeBot: typeBot, dbBot: dbBot, bot_user_id: bot_user_id, username_bot: usernameBot,  productionType: productionType);
    }
    if (update["edited_message"] is Map) {
      return await updateMessage(update["edited_message"], updateBot: updateBot, tokenBot: tokenBot, tg: tg, ownerUserId: ownerUserId, typeBot: typeBot, dbBot: dbBot, bot_user_id: bot_user_id, username_bot: usernameBot,  productionType: productionType);
    }
    if (update["channel_post"] is Map) {
      return await updateMessage(update["channel_post"], updateBot: updateBot, tokenBot: tokenBot, tg: tg, ownerUserId: ownerUserId, typeBot: typeBot, dbBot: dbBot, bot_user_id: bot_user_id, username_bot: usernameBot,  productionType: productionType);
    }
    if (update["message"] is Map) {
      return await updateMessage(update["message"], updateBot: updateBot, tokenBot: tokenBot, tg: tg, ownerUserId: ownerUserId, typeBot: typeBot, dbBot: dbBot, bot_user_id: bot_user_id, username_bot: usernameBot,  productionType: productionType);
    }

    return {
      "ok": true,
    };
  } catch (e) {
    return e;
  }
}

Future<void> runBot({
  required Alfred app,
  required EventEmitter emitter,
  required TelegramBotApi tg,
  required DatabaseTg database,
  required String pathBot,
  required Map clientOption,
  required String event_update_bot,
  required ProductionType productionType,
}) async {
  emitter.on(event_update_bot, null, (ev, context) async {
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
        event_update_bot,
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
  print("succes init bot");
  return;
}

class UpdateBot {
  final Map<String, dynamic> body;
  final Map<String, String> query;
  UpdateBot({
    required this.body,
    required this.query,
  });
}
