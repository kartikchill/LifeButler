import 'package:lifebutler_client/lifebutler_client.dart';

late Client client;

Client createClient() {
  return Client(
    'http://localhost:8092/',
  );
}
