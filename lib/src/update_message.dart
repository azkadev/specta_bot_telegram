part of specta_bot_telegram;

FutureOr<Map?> updateMessage(
  Map update, {
  required UpdateBot updateBot,
  required String tokenBot,
  required TelegramBotApi tg,
  required int ownerUserId,
  required String typeBot,
  required DatabaseTg dbBot,
  required int bot_user_id,
  required String username_bot, 
  required ProductionType productionType,
}) async {}
