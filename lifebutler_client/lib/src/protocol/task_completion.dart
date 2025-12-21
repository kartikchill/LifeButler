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

abstract class TaskCompletion implements _i1.SerializableModel {
  TaskCompletion._({
    this.id,
    required this.taskId,
    required this.completedAt,
  });

  factory TaskCompletion({
    int? id,
    required int taskId,
    required DateTime completedAt,
  }) = _TaskCompletionImpl;

  factory TaskCompletion.fromJson(Map<String, dynamic> jsonSerialization) {
    return TaskCompletion(
      id: jsonSerialization['id'] as int?,
      taskId: jsonSerialization['taskId'] as int,
      completedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['completedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int taskId;

  DateTime completedAt;

  /// Returns a shallow copy of this [TaskCompletion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TaskCompletion copyWith({
    int? id,
    int? taskId,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TaskCompletion',
      if (id != null) 'id': id,
      'taskId': taskId,
      'completedAt': completedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TaskCompletionImpl extends TaskCompletion {
  _TaskCompletionImpl({
    int? id,
    required int taskId,
    required DateTime completedAt,
  }) : super._(
         id: id,
         taskId: taskId,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [TaskCompletion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TaskCompletion copyWith({
    Object? id = _Undefined,
    int? taskId,
    DateTime? completedAt,
  }) {
    return TaskCompletion(
      id: id is int? ? id : this.id,
      taskId: taskId ?? this.taskId,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
