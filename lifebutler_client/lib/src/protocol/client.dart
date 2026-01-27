/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:lifebutler_client/src/protocol/goal.dart' as _i3;
import 'package:lifebutler_client/src/protocol/streak.dart' as _i4;
import 'package:lifebutler_client/src/protocol/greetings/greeting.dart' as _i5;
import 'protocol.dart' as _i6;

/// {@category Endpoint}
class EndpointGoal extends _i1.EndpointRef {
  EndpointGoal(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'goal';

  _i2.Future<_i3.Goal> createGoal({
    required int userId,
    required String title,
    String? description,
    String? affirmation,
    required int targetCount,
    required String periodType,
    String? consistencyStyle,
    DateTime? anchorTime,
    int? priority,
  }) => caller.callServerEndpoint<_i3.Goal>(
    'goal',
    'createGoal',
    {
      'userId': userId,
      'title': title,
      'description': description,
      'affirmation': affirmation,
      'targetCount': targetCount,
      'periodType': periodType,
      'consistencyStyle': consistencyStyle,
      'anchorTime': anchorTime,
      'priority': priority,
    },
  );

  _i2.Future<_i3.Goal> completeGoalSession(int goalId) =>
      caller.callServerEndpoint<_i3.Goal>(
        'goal',
        'completeGoalSession',
        {'goalId': goalId},
      );

  _i2.Future<_i3.Goal> restartGoal(int goalId) =>
      caller.callServerEndpoint<_i3.Goal>(
        'goal',
        'restartGoal',
        {'goalId': goalId},
      );

  _i2.Future<List<_i3.Goal>> getGoals(int userId) =>
      caller.callServerEndpoint<List<_i3.Goal>>(
        'goal',
        'getGoals',
        {'userId': userId},
      );

  _i2.Future<bool> updateGoal(_i3.Goal goal) => caller.callServerEndpoint<bool>(
    'goal',
    'updateGoal',
    {'goal': goal},
  );
}

/// {@category Endpoint}
class EndpointStreak extends _i1.EndpointRef {
  EndpointStreak(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'streak';

  _i2.Future<_i4.Streak> updateStreak({required int goalId}) =>
      caller.callServerEndpoint<_i4.Streak>(
        'streak',
        'updateStreak',
        {'goalId': goalId},
      );
}

/// {@category Endpoint}
class EndpointTask extends _i1.EndpointRef {
  EndpointTask(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'task';

  _i2.Future<void> completeTask({required int taskId}) =>
      caller.callServerEndpoint<void>(
        'task',
        'completeTask',
        {'taskId': taskId},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i5.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i5.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i6.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    goal = EndpointGoal(this);
    streak = EndpointStreak(this);
    task = EndpointTask(this);
    greeting = EndpointGreeting(this);
  }

  late final EndpointGoal goal;

  late final EndpointStreak streak;

  late final EndpointTask task;

  late final EndpointGreeting greeting;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'goal': goal,
    'streak': streak,
    'task': task,
    'greeting': greeting,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
