import 'package:chat_bot/model/conversation.dart';
import 'package:chat_bot/pages/chatpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/chat_boot.dart';
import '../provider/data.dart';
import '../widgets/conversation_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final data = context.read<Data>();
    final odwrotny = ChatBot(
      name: 'Odwrotny',
      getAnswer: (input) => input.split('').reversed.join(''),
    );
    final nic = ChatBot(name: 'Powtarzający', getAnswer: (input) => input);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (data.conversations.isEmpty && data.bots.isEmpty) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          data.addChatBotAndStartConversation(odwrotny);
          data.addChatBotAndStartConversation(nic);
        });
      } else {
        data.loadChatBots([odwrotny, nic]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chats = context.watch<Data>().conversations;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Czat boty'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ConversationTile(
                  content: chats[index].messages.isEmpty
                      ? ''
                      : chats[index].messages.last.text,
                  timestamp: chats[index].messages.isEmpty
                      ? ''
                      : DateFormat.Hm()
                          .format(chats[index].messages.last.timestamp),
                  title: chats[index].chatBotName,
                  onTap: () => _navigateToChat(chats[index], index));
            },
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                ),
            itemCount: chats.length),
      ),
    );
  }

  void _navigateToChat(Conversation chat, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          id: chat.id,
        ),
      ),
    );
  }
}
