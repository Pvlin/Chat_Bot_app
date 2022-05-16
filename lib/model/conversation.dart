import 'package:chat_bot/model/message.dart';

const _messages = 'messages';
const _chatBotName = 'chatBotName';
const _id = 'id';

class Conversation {
  late List<Message> messages;
  late final String chatBotName;
  late final String id;

  Conversation({required this.chatBotName, required this.id}) {
    messages = [];
  }

  void addMessage(Message message) {
    messages.add(message);
  }

  Conversation.fromJson(Map<String, dynamic> json)
      : messages =
            (json[_messages] as List).map((e) => Message.fromJson(e)).toList(),
        chatBotName = json[_chatBotName],
        id = json[_id];

  Map<String, dynamic> toJson() => {
        _messages: messages.map((e) => e.toJson()).toList(),
        _chatBotName: chatBotName,
        _id: id,
      };

  @override
  String toString() {
    return id;
  }
}
