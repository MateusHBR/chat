import 'package:common/common.dart';
import 'package:test/test.dart';

void main() {
  test('from json to json', () {
    final json = {
      'name': 'Mateus',
      'room': 'sala1',
      'text': 'mensagem',
      'type': 'SocketEventType.enter_room',
    };

    final event = SocketEvent.fromJson(json);

    expect(event.toJson(), json);
    expect(event.name, 'Mateus');
    expect(event.type, SocketEventType.enter_room);
  });
}
