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

abstract class Task implements _i1.SerializableModel {
  Task._({
    this.id,
    required this.goalId,
    required this.scheduledTime,
    required this.durationMinutes,
    required this.repeatDaily,
    required this.createdAt,
  });

  factory Task({
    int? id,
    required int goalId,
    required DateTime scheduledTime,
    required int durationMinutes,
    required bool repeatDaily,
    required DateTime createdAt,
  }) = _TaskImpl;

  factory Task.fromJson(Map<String, dynamic> jsonSerialization) {
    return Task(
      id: jsonSerialization['id'] as int?,
      goalId: jsonSerialization['goalId'] as int,
      scheduledTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['scheduledTime'],
      ),
      durationMinutes: jsonSerialization['durationMinutes'] as int,
      repeatDaily: jsonSerialization['repeatDaily'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int goalId;

  DateTime scheduledTime;

  int durationMinutes;

  bool repeatDaily;

  DateTime createdAt;

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Task copyWith({
    int? id,
    int? goalId,
    DateTime? scheduledTime,
    int? durationMinutes,
    bool? repeatDaily,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Task',
      if (id != null) 'id': id,
      'goalId': goalId,
      'scheduledTime': scheduledTime.toJson(),
      'durationMinutes': durationMinutes,
      'repeatDaily': repeatDaily,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskImpl extends Task {
  _TaskImpl({
    int? id,
    required int goalId,
    required DateTime scheduledTime,
    required int durationMinutes,
    required bool repeatDaily,
    required DateTime createdAt,
  }) : super._(
         id: id,
         goalId: goalId,
         scheduledTime: scheduledTime,
         durationMinutes: durationMinutes,
         repeatDaily: repeatDaily,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Task]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Task copyWith({
    Object? id = _Undefined,
    int? goalId,
    DateTime? scheduledTime,
    int? durationMinutes,
    bool? repeatDaily,
    DateTime? createdAt,
  }) {
    return Task(
      id: id is int? ? id : this.id,
      goalId: goalId ?? this.goalId,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      repeatDaily: repeatDaily ?? this.repeatDaily,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
