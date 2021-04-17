import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'no-name';
  String room = 'unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _roomField(),
          _verticalSpacing(16),
          _nameField(),
          _verticalSpacing(32),
          _button(),
        ],
      ),
    );
  }

  Widget _verticalSpacing(double size) {
    return SizedBox(
      height: size,
    );
  }

  Widget _roomField() {
    return TextField(
      onChanged: (newValue) => room = newValue,
      decoration: InputDecoration(
        labelText: 'Sala',
        hintText: 'Insira o nome da sala',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget _nameField() {
    return TextField(
      onChanged: (newValue) => name = newValue,
      decoration: InputDecoration(
        labelText: 'Nome',
        hintText: 'Insira seu nome',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget _button() {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(double.infinity, 48),
        ),
      ),
      child: Text('Acessar chat'),
      onPressed: () {
        Navigator.of(context).pushNamed('/chat', arguments: {
          'room': room,
          'name': name,
        });
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Home'),
    );
  }
}
