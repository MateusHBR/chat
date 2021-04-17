import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rx_notifier/rx_notifier.dart';

import 'chat_controller.dart';

class ChatPage extends StatefulWidget {
  final String name;
  final String room;

  const ChatPage({
    Key? key,
    required this.name,
    required this.room,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatController controller;
  late ScrollController listController;

  @override
  void initState() {
    super.initState();
    listController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    controller = ChatController(
      room: widget.room,
      name: widget.name,
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      extendBody: true,
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Sala: ${widget.room}'),
    );
  }

  Widget _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _messages(),
          Divider(),
          _input(),
        ],
      ),
    );
  }

  Widget _messages() {
    return Expanded(
      child: RxBuilder(builder: (_) {
        return Scrollbar(
          isAlwaysShown: true,
          controller: listController,
          child: ListView.builder(
            controller: listController,
            itemCount: controller.listEvent.length,
            itemBuilder: (context, index) {
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                listController.jumpTo(listController.position.maxScrollExtent);
              });

              final event = controller.listEvent[index];

              if (event.type == SocketEventType.enter_room) {
                return ListTile(
                  title: Text('${event.name} entrou na sala'),
                );
              }

              if (event.type == SocketEventType.leave_room) {
                return ListTile(
                  title: Text('${event.name} saiu na sala'),
                );
              }

              return ListTile(
                title: Text(event.name),
                subtitle: Text(event.text),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _input() {
    return TextField(
      controller: controller.textController,
      onSubmitted: (_) => controller.send,
      focusNode: controller.focus,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Insira sua mensagem',
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: controller.send,
        ),
      ),
    );
  }
}
