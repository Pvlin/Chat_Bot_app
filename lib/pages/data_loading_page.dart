import 'dart:convert';
import 'package:chat_bot/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/data.dart';
import 'homepage.dart';

const _dataKey = 'data';

class DataLoadingPage extends StatefulWidget {
  const DataLoadingPage({Key? key}) : super(key: key);

  @override
  State<DataLoadingPage> createState() => _DataLoadingPageState();
}

class _DataLoadingPageState extends State<DataLoadingPage> {
  @override
  void initState() async {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final serialezed = prefs.getStringList(_dataKey) ?? [];
    List<Conversation> deserialezed =
        serialezed.map((e) => Conversation.fromJson(jsonDecode(e))).toList();
    context.read<Data>().loadConversation(deserialezed);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
