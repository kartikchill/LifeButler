
import 'package:serverpod/serverpod.dart';


import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';


/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Initialize authentication services for the server.
  // Token managers will be used to validate and issue authentication keys,
  // and the identity providers will be the authentication options available for users.

  // Start the server.
  await pod.start();
}

