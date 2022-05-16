import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_bot/model/message.dart';


void main () {
  group ('Message serialization and deserialization', () {

    test('Should deserialize JSON to Message', () {
    const _text = 'Test';
    const _isWrittenByHuman = true;
    const _timestampTimeDay = 17;
    final jsonMessage =
        '{"text": "$_text","isWrittenByHuman":$_isWrittenByHuman, "timestamp":"2022-05-${_timestampTimeDay
        .toString()}T12:21:15.000000"}';
    final deserialized = Message.fromJson(jsonDecode(jsonMessage));

    expect(deserialized.text, _text);
    expect(deserialized.isWrittenByHuman, _isWrittenByHuman);
    expect(deserialized.timestamp.day, _timestampTimeDay);
  });

    test('Should serialize JSON to Message', () {
    const _text = 'Test';
    const _isWrittenByHuman = true;
    const _timestampTimeYear = 2022;
    const _timestampTimeMonth = 10;
    const _timestampTimeDay = 17;
    const _timestampTimeHour = 17;
    const _timestampTimeMinutes = 17;

    final message = Message(
        isWrittenByHuman: _isWrittenByHuman,
        text: _text,
        timestamp: DateTime(
            _timestampTimeYear, _timestampTimeMonth, _timestampTimeDay,
            _timestampTimeHour, _timestampTimeMinutes));
    final serialized = jsonEncode(message);

    final expectedJsonMessage =
        '{"text":"$_text","timestamp":"${_timestampTimeYear
        .toString()}-${_timestampTimeMonth.toString()}-${_timestampTimeDay
        .toString()}T${_timestampTimeHour.toString()}:${_timestampTimeMinutes
        .toString()}:00.000","isWrittenByHuman":$_isWrittenByHuman}';
    expect(serialized, expectedJsonMessage);
  });

    test('Should serialize and desarialize', () {
     const _text = 'Test';
     const _isWrittenByHuman = true;
     const _timestampTimeYear = 2022;
     const _timestampTimeMonth = 05;
     const _timestampTimeDay = 17;
     const _timestampTimeHour = 17;
     const _timestampTimeMinutes = 17;

     final message = Message(
         isWrittenByHuman: _isWrittenByHuman,
         text: _text,
         timestamp: DateTime(
             _timestampTimeYear, _timestampTimeMonth, _timestampTimeDay,
             _timestampTimeHour, _timestampTimeMinutes));
     final serialized = jsonEncode(message);
     final deSerialized = Message.fromJson(jsonDecode(serialized));

     expect(message, deSerialized);
    });
  });
}