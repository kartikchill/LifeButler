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

abstract class Reflection implements _i1.SerializableModel {
  Reflection._({
    this.id,
    required this.userId,
    this.goalId,
    required this.type,
    required this.content,
    required this.createdAt,
  });

  factory Reflection({
    int? id,
    required int userId,
    int? goalId,
    required int type,
    required String content,
    required DateTime createdAt,
  }) = _ReflectionImpl;

  factory Reflection.fromJson(Map<String, dynamic> jsonSerialization) {
    return Reflection(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      goalId: jsonSerialization['goalId'] as int?,
      type: jsonSerialization['type'] as int,
      content: jsonSerialization['content'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int? goalId;

  int type;

  String content;

  DateTime createdAt;

  /// Returns a shallow copy of this [Reflection]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Reflection copyWith({
    int? id,
    int? userId,
    int? goalId,
    int? type,
    String? content,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Reflection',
      if (id != null) 'id': id,
      'userId': userId,
      if (goalId != null) 'goalId': goalId,
      'type': type,
      'content': content,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReflectionImpl extends Reflection {
  _ReflectionImpl({
    int? id,
    required int userId,
    int? goalId,
    required int type,
    required String content,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         goalId: goalId,
         type: type,
         content: content,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Reflection]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Reflection copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? goalId = _Undefined,
    int? type,
    String? content,
    DateTime? createdAt,
  }) {
    return Reflection(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      goalId: goalId is int? ? goalId : this.goalId,
      type: type ?? this.type,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
