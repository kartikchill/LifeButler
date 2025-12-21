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
import 'goal.dart' as _i2;
import 'greetings/greeting.dart' as _i3;
import 'streak.dart' as _i4;
import 'task.dart' as _i5;
import 'task_completion.dart' as _i6;
import 'user_mode.dart' as _i7;
import 'package:lifebutler_client/src/protocol/goal.dart' as _i8;
export 'goal.dart';
export 'greetings/greeting.dart';
export 'streak.dart';
export 'task.dart';
export 'task_completion.dart';
export 'user_mode.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.Goal) {
      return _i2.Goal.fromJson(data) as T;
    }
    if (t == _i3.Greeting) {
      return _i3.Greeting.fromJson(data) as T;
    }
    if (t == _i4.Streak) {
      return _i4.Streak.fromJson(data) as T;
    }
    if (t == _i5.Task) {
      return _i5.Task.fromJson(data) as T;
    }
    if (t == _i6.TaskCompletion) {
      return _i6.TaskCompletion.fromJson(data) as T;
    }
    if (t == _i7.UserMode) {
      return _i7.UserMode.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Goal?>()) {
      return (data != null ? _i2.Goal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.Greeting?>()) {
      return (data != null ? _i3.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Streak?>()) {
      return (data != null ? _i4.Streak.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Task?>()) {
      return (data != null ? _i5.Task.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.TaskCompletion?>()) {
      return (data != null ? _i6.TaskCompletion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.UserMode?>()) {
      return (data != null ? _i7.UserMode.fromJson(data) : null) as T;
    }
    if (t == List<_i8.Goal>) {
      return (data as List).map((e) => deserialize<_i8.Goal>(e)).toList() as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Goal => 'Goal',
      _i3.Greeting => 'Greeting',
      _i4.Streak => 'Streak',
      _i5.Task => 'Task',
      _i6.TaskCompletion => 'TaskCompletion',
      _i7.UserMode => 'UserMode',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('lifebutler.', '');
    }

    switch (data) {
      case _i2.Goal():
        return 'Goal';
      case _i3.Greeting():
        return 'Greeting';
      case _i4.Streak():
        return 'Streak';
      case _i5.Task():
        return 'Task';
      case _i6.TaskCompletion():
        return 'TaskCompletion';
      case _i7.UserMode():
        return 'UserMode';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Goal') {
      return deserialize<_i2.Goal>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i3.Greeting>(data['data']);
    }
    if (dataClassName == 'Streak') {
      return deserialize<_i4.Streak>(data['data']);
    }
    if (dataClassName == 'Task') {
      return deserialize<_i5.Task>(data['data']);
    }
    if (dataClassName == 'TaskCompletion') {
      return deserialize<_i6.TaskCompletion>(data['data']);
    }
    if (dataClassName == 'UserMode') {
      return deserialize<_i7.UserMode>(data['data']);
    }
    return super.deserializeByClassName(data);
  }
}
