import 'package:chat_bot/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/data.dart';
import '../widgets/bubble.dart';
import 'dart:convert';

const dataKey = 'data';

class ChatPage extends StatefulWidget {
  const ChatPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Data data = context.watch<Data>();
    List<Conversation> chats = context.watch<Data>().conversations;
    final chat = chats.firstWhere((element) => element.id == widget.id);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(chat.chatBotName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: chat.messages.length,
                  itemBuilder: (context, index) {
                    final message = chat.messages[index];
                    return Bubble(
                      isWrittenByHuman: message.isWrittenByHuman,
                      timestamp: DateFormat.Hm().format(message.timestamp),
                      message: message.text,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        hintText: 'Napisz wiadomość',
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => _sendMessage(data)),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void _sendMessage(Data data) {
    print('TEST: ${controller.text}');
    data.addMessage(widget.id, controller.text);
    controller.clear();
    Future.delayed(const Duration(seconds: 5)).then((_) => _saveData());
  }

  void _saveData() async {
    if (mounted) {
      final prefs = await SharedPreferences.getInstance();
      final data = context.read<Data>().conversations;
      prefs.setStringList(dataKey, data.map((e) => jsonEncode(e)).toList());
    }
  }
}
