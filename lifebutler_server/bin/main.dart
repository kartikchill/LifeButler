import 'package:serverpod/serverpod.dart';
import 'package:lifebutler_server/src/generated/protocol.dart';
import 'package:lifebutler_server/src/generated/endpoints.dart';

void main(List<String> args) async {
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  await pod.start();
}
