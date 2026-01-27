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
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/goal_endpoint.dart' as _i2;
import '../endpoints/streak_endpoint.dart' as _i3;
import '../endpoints/task_endpoint.dart' as _i4;
import '../greetings/greeting_endpoint.dart' as _i5;
import 'package:lifebutler_server/src/generated/goal.dart' as _i6;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'goal': _i2.GoalEndpoint()
        ..initialize(
          server,
          'goal',
          null,
        ),
      'streak': _i3.StreakEndpoint()
        ..initialize(
          server,
          'streak',
          null,
        ),
      'task': _i4.TaskEndpoint()
        ..initialize(
          server,
          'task',
          null,
        ),
      'greeting': _i5.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['goal'] = _i1.EndpointConnector(
      name: 'goal',
      endpoint: endpoints['goal']!,
      methodConnectors: {
        'createGoal': _i1.MethodConnector(
          name: 'createGoal',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'affirmation': _i1.ParameterDescription(
              name: 'affirmation',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'targetCount': _i1.ParameterDescription(
              name: 'targetCount',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'periodType': _i1.ParameterDescription(
              name: 'periodType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'consistencyStyle': _i1.ParameterDescription(
              name: 'consistencyStyle',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'anchorTime': _i1.ParameterDescription(
              name: 'anchorTime',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'priority': _i1.ParameterDescription(
              name: 'priority',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['goal'] as _i2.GoalEndpoint).createGoal(
                session,
                userId: params['userId'],
                title: params['title'],
                description: params['description'],
                affirmation: params['affirmation'],
                targetCount: params['targetCount'],
                periodType: params['periodType'],
                consistencyStyle: params['consistencyStyle'],
                anchorTime: params['anchorTime'],
                priority: params['priority'],
              ),
        ),
        'completeGoalSession': _i1.MethodConnector(
          name: 'completeGoalSession',
          params: {
            'goalId': _i1.ParameterDescription(
              name: 'goalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['goal'] as _i2.GoalEndpoint).completeGoalSession(
                    session,
                    params['goalId'],
                  ),
        ),
        'restartGoal': _i1.MethodConnector(
          name: 'restartGoal',
          params: {
            'goalId': _i1.ParameterDescription(
              name: 'goalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['goal'] as _i2.GoalEndpoint).restartGoal(
                session,
                params['goalId'],
              ),
        ),
        'getGoals': _i1.MethodConnector(
          name: 'getGoals',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['goal'] as _i2.GoalEndpoint).getGoals(
                session,
                params['userId'],
              ),
        ),
        'updateGoal': _i1.MethodConnector(
          name: 'updateGoal',
          params: {
            'goal': _i1.ParameterDescription(
              name: 'goal',
              type: _i1.getType<_i6.Goal>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['goal'] as _i2.GoalEndpoint).updateGoal(
                session,
                params['goal'],
              ),
        ),
      },
    );
    connectors['streak'] = _i1.EndpointConnector(
      name: 'streak',
      endpoint: endpoints['streak']!,
      methodConnectors: {
        'updateStreak': _i1.MethodConnector(
          name: 'updateStreak',
          params: {
            'goalId': _i1.ParameterDescription(
              name: 'goalId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['streak'] as _i3.StreakEndpoint).updateStreak(
                    session,
                    goalId: params['goalId'],
                  ),
        ),
      },
    );
    connectors['task'] = _i1.EndpointConnector(
      name: 'task',
      endpoint: endpoints['task']!,
      methodConnectors: {
        'completeTask': _i1.MethodConnector(
          name: 'completeTask',
          params: {
            'taskId': _i1.ParameterDescription(
              name: 'taskId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['task'] as _i4.TaskEndpoint).completeTask(
                session,
                taskId: params['taskId'],
              ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i5.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
  }
}
