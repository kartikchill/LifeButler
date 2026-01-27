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

abstract class Goal implements _i1.SerializableModel {
  Goal._({
    this.id,
    required this.userId,
    required this.title,
    this.description,
    this.affirmation,
    required this.isActive,
    required this.createdAt,
    required this.targetCount,
    required this.completedCount,
    required this.periodType,
    required this.periodStart,
    required this.periodEnd,
    this.lastCompletedAt,
    this.consistencyStyle,
    this.anchorTime,
    this.priority,
    this.currentStreak,
    this.longestStreak,
    this.lastEvaluatedPeriodEnd,
  });

  factory Goal({
    int? id,
    required int userId,
    required String title,
    String? description,
    String? affirmation,
    required bool isActive,
    required DateTime createdAt,
    required int targetCount,
    required int completedCount,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    DateTime? lastCompletedAt,
    String? consistencyStyle,
    DateTime? anchorTime,
    int? priority,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastEvaluatedPeriodEnd,
  }) = _GoalImpl;

  factory Goal.fromJson(Map<String, dynamic> jsonSerialization) {
    return Goal(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      affirmation: jsonSerialization['affirmation'] as String?,
      isActive: jsonSerialization['isActive'] as bool,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      targetCount: jsonSerialization['targetCount'] as int,
      completedCount: jsonSerialization['completedCount'] as int,
      periodType: jsonSerialization['periodType'] as String,
      periodStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodStart'],
      ),
      periodEnd: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['periodEnd'],
      ),
      lastCompletedAt: jsonSerialization['lastCompletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastCompletedAt'],
            ),
      consistencyStyle: jsonSerialization['consistencyStyle'] as String?,
      anchorTime: jsonSerialization['anchorTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['anchorTime']),
      priority: jsonSerialization['priority'] as int?,
      currentStreak: jsonSerialization['currentStreak'] as int?,
      longestStreak: jsonSerialization['longestStreak'] as int?,
      lastEvaluatedPeriodEnd:
          jsonSerialization['lastEvaluatedPeriodEnd'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastEvaluatedPeriodEnd'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String title;

  String? description;

  String? affirmation;

  bool isActive;

  DateTime createdAt;

  int targetCount;

  int completedCount;

  String periodType;

  DateTime periodStart;

  DateTime periodEnd;

  DateTime? lastCompletedAt;

  String? consistencyStyle;

  DateTime? anchorTime;

  int? priority;

  int? currentStreak;

  int? longestStreak;

  DateTime? lastEvaluatedPeriodEnd;

  /// Returns a shallow copy of this [Goal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Goal copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? affirmation,
    bool? isActive,
    DateTime? createdAt,
    int? targetCount,
    int? completedCount,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    DateTime? lastCompletedAt,
    String? consistencyStyle,
    DateTime? anchorTime,
    int? priority,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastEvaluatedPeriodEnd,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Goal',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      if (description != null) 'description': description,
      if (affirmation != null) 'affirmation': affirmation,
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
      'targetCount': targetCount,
      'completedCount': completedCount,
      'periodType': periodType,
      'periodStart': periodStart.toJson(),
      'periodEnd': periodEnd.toJson(),
      if (lastCompletedAt != null) 'lastCompletedAt': lastCompletedAt?.toJson(),
      if (consistencyStyle != null) 'consistencyStyle': consistencyStyle,
      if (anchorTime != null) 'anchorTime': anchorTime?.toJson(),
      if (priority != null) 'priority': priority,
      if (currentStreak != null) 'currentStreak': currentStreak,
      if (longestStreak != null) 'longestStreak': longestStreak,
      if (lastEvaluatedPeriodEnd != null)
        'lastEvaluatedPeriodEnd': lastEvaluatedPeriodEnd?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GoalImpl extends Goal {
  _GoalImpl({
    int? id,
    required int userId,
    required String title,
    String? description,
    String? affirmation,
    required bool isActive,
    required DateTime createdAt,
    required int targetCount,
    required int completedCount,
    required String periodType,
    required DateTime periodStart,
    required DateTime periodEnd,
    DateTime? lastCompletedAt,
    String? consistencyStyle,
    DateTime? anchorTime,
    int? priority,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastEvaluatedPeriodEnd,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         description: description,
         affirmation: affirmation,
         isActive: isActive,
         createdAt: createdAt,
         targetCount: targetCount,
         completedCount: completedCount,
         periodType: periodType,
         periodStart: periodStart,
         periodEnd: periodEnd,
         lastCompletedAt: lastCompletedAt,
         consistencyStyle: consistencyStyle,
         anchorTime: anchorTime,
         priority: priority,
         currentStreak: currentStreak,
         longestStreak: longestStreak,
         lastEvaluatedPeriodEnd: lastEvaluatedPeriodEnd,
       );

  /// Returns a shallow copy of this [Goal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Goal copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    Object? description = _Undefined,
    Object? affirmation = _Undefined,
    bool? isActive,
    DateTime? createdAt,
    int? targetCount,
    int? completedCount,
    String? periodType,
    DateTime? periodStart,
    DateTime? periodEnd,
    Object? lastCompletedAt = _Undefined,
    Object? consistencyStyle = _Undefined,
    Object? anchorTime = _Undefined,
    Object? priority = _Undefined,
    Object? currentStreak = _Undefined,
    Object? longestStreak = _Undefined,
    Object? lastEvaluatedPeriodEnd = _Undefined,
  }) {
    return Goal(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      affirmation: affirmation is String? ? affirmation : this.affirmation,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      targetCount: targetCount ?? this.targetCount,
      completedCount: completedCount ?? this.completedCount,
      periodType: periodType ?? this.periodType,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      lastCompletedAt: lastCompletedAt is DateTime?
          ? lastCompletedAt
          : this.lastCompletedAt,
      consistencyStyle: consistencyStyle is String?
          ? consistencyStyle
          : this.consistencyStyle,
      anchorTime: anchorTime is DateTime? ? anchorTime : this.anchorTime,
      priority: priority is int? ? priority : this.priority,
      currentStreak: currentStreak is int? ? currentStreak : this.currentStreak,
      longestStreak: longestStreak is int? ? longestStreak : this.longestStreak,
      lastEvaluatedPeriodEnd: lastEvaluatedPeriodEnd is DateTime?
          ? lastEvaluatedPeriodEnd
          : this.lastEvaluatedPeriodEnd,
    );
  }
}
