import 'package:serverpod/serverpod.dart';
import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

// 🔥 REQUIRED FOR ENDPOINT DISCOVERY
import 'src/endpoints/goal_endpoint.dart';
import 'src/endpoints/task_endpoint.dart';
import 'src/endpoints/streak_endpoint.dart';

class Server extends Serverpod {
  Server({
    required super.args,
  }) : super(
          protocol: Protocol(),
          endpoints: Endpoints(),
        ) {
    // ✅ ALLOW FLUTTER WEB / BROWSER REQUESTS
    webServer.addCorsHeaders = true;
  }
}
