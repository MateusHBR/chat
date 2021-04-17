import 'package:flutter/widgets.dart' show TextEditingController, FocusNode;
import 'package:rx_notifier/rx_notifier.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:common/common.dart';

class ChatController {
  final String room;
  final String name;

  ChatController({required this.room, required this.name}) {
    _init();
  }

  late Socket socket;
  final listEvent = RxList<SocketEvent>([]);
  final textController = TextEditingController(text: '');
  final focus = FocusNode();

  void _init() {
    socket = io(
      'http://localhost:3000',
      OptionBuilder().setTransports(
        ['websocket'],
      ).build(),
    );

    socket.connect();

    socket.onConnect(
      (_) {
        socket.emit(
          'enter_room',
          {
            'room': room,
            'name': name,
          },
        );
      },
    );

    socket.on(
      'message',
      (json) {
        final event = SocketEvent.fromJson(json);

        listEvent.add(event);
      },
    );
  }

  void dispose() {
    textController.dispose();
    socket.clearListeners();
    socket.dispose();
  }

  void send() {
    final event = SocketEvent(
      name: name,
      room: room,
      text: textController.text,
      type: SocketEventType.message,
    );

    listEvent.add(event);
    socket.emit('message', event);

    textController.clear();
    focus.requestFocus();
  }
}
