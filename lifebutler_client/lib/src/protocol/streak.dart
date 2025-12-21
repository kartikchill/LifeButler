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

abstract class Streak implements _i1.SerializableModel {
  Streak._({
    this.id,
    required this.goalId,
    required this.currentStreak,
    required this.bestStreak,
    this.lastCompletedDate,
  });

  factory Streak({
    int? id,
    required int goalId,
    required int currentStreak,
    required int bestStreak,
    DateTime? lastCompletedDate,
  }) = _StreakImpl;

  factory Streak.fromJson(Map<String, dynamic> jsonSerialization) {
    return Streak(
      id: jsonSerialization['id'] as int?,
      goalId: jsonSerialization['goalId'] as int,
      currentStreak: jsonSerialization['currentStreak'] as int,
      bestStreak: jsonSerialization['bestStreak'] as int,
      lastCompletedDate: jsonSerialization['lastCompletedDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastCompletedDate'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int goalId;

  int currentStreak;

  int bestStreak;

  DateTime? lastCompletedDate;

  /// Returns a shallow copy of this [Streak]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Streak copyWith({
    int? id,
    int? goalId,
    int? currentStreak,
    int? bestStreak,
    DateTime? lastCompletedDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Streak',
      if (id != null) 'id': id,
      'goalId': goalId,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
      if (lastCompletedDate != null)
        'lastCompletedDate': lastCompletedDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StreakImpl extends Streak {
  _StreakImpl({
    int? id,
    required int goalId,
    required int currentStreak,
    required int bestStreak,
    DateTime? lastCompletedDate,
  }) : super._(
         id: id,
         goalId: goalId,
         currentStreak: currentStreak,
         bestStreak: bestStreak,
         lastCompletedDate: lastCompletedDate,
       );

  /// Returns a shallow copy of this [Streak]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Streak copyWith({
    Object? id = _Undefined,
    int? goalId,
    int? currentStreak,
    int? bestStreak,
    Object? lastCompletedDate = _Undefined,
  }) {
    return Streak(
      id: id is int? ? id : this.id,
      goalId: goalId ?? this.goalId,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      lastCompletedDate: lastCompletedDate is DateTime?
          ? lastCompletedDate
          : this.lastCompletedDate,
    );
  }
}
