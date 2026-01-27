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

abstract class Goal implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = GoalTable();

  static const db = GoalRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static GoalInclude include() {
    return GoalInclude._();
  }

  static GoalIncludeList includeList({
    _i1.WhereExpressionBuilder<GoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GoalTable>? orderByList,
    GoalInclude? include,
  }) {
    return GoalIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Goal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Goal.t),
      include: include,
    );
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

class GoalUpdateTable extends _i1.UpdateTable<GoalTable> {
  GoalUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String? value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<String, String> affirmation(String? value) => _i1.ColumnValue(
    table.affirmation,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<int, int> targetCount(int value) => _i1.ColumnValue(
    table.targetCount,
    value,
  );

  _i1.ColumnValue<int, int> completedCount(int value) => _i1.ColumnValue(
    table.completedCount,
    value,
  );

  _i1.ColumnValue<String, String> periodType(String value) => _i1.ColumnValue(
    table.periodType,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> periodStart(DateTime value) =>
      _i1.ColumnValue(
        table.periodStart,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> periodEnd(DateTime value) =>
      _i1.ColumnValue(
        table.periodEnd,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> lastCompletedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.lastCompletedAt,
        value,
      );

  _i1.ColumnValue<String, String> consistencyStyle(String? value) =>
      _i1.ColumnValue(
        table.consistencyStyle,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> anchorTime(DateTime? value) =>
      _i1.ColumnValue(
        table.anchorTime,
        value,
      );

  _i1.ColumnValue<int, int> priority(int? value) => _i1.ColumnValue(
    table.priority,
    value,
  );

  _i1.ColumnValue<int, int> currentStreak(int? value) => _i1.ColumnValue(
    table.currentStreak,
    value,
  );

  _i1.ColumnValue<int, int> longestStreak(int? value) => _i1.ColumnValue(
    table.longestStreak,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastEvaluatedPeriodEnd(DateTime? value) =>
      _i1.ColumnValue(
        table.lastEvaluatedPeriodEnd,
        value,
      );
}

class GoalTable extends _i1.Table<int?> {
  GoalTable({super.tableRelation}) : super(tableName: 'goal') {
    updateTable = GoalUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    affirmation = _i1.ColumnString(
      'affirmation',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    targetCount = _i1.ColumnInt(
      'targetCount',
      this,
    );
    completedCount = _i1.ColumnInt(
      'completedCount',
      this,
    );
    periodType = _i1.ColumnString(
      'periodType',
      this,
    );
    periodStart = _i1.ColumnDateTime(
      'periodStart',
      this,
    );
    periodEnd = _i1.ColumnDateTime(
      'periodEnd',
      this,
    );
    lastCompletedAt = _i1.ColumnDateTime(
      'lastCompletedAt',
      this,
    );
    consistencyStyle = _i1.ColumnString(
      'consistencyStyle',
      this,
    );
    anchorTime = _i1.ColumnDateTime(
      'anchorTime',
      this,
    );
    priority = _i1.ColumnInt(
      'priority',
      this,
    );
    currentStreak = _i1.ColumnInt(
      'currentStreak',
      this,
    );
    longestStreak = _i1.ColumnInt(
      'longestStreak',
      this,
    );
    lastEvaluatedPeriodEnd = _i1.ColumnDateTime(
      'lastEvaluatedPeriodEnd',
      this,
    );
  }

  late final GoalUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnString affirmation;

  late final _i1.ColumnBool isActive;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnInt targetCount;

  late final _i1.ColumnInt completedCount;

  late final _i1.ColumnString periodType;

  late final _i1.ColumnDateTime periodStart;

  late final _i1.ColumnDateTime periodEnd;

  late final _i1.ColumnDateTime lastCompletedAt;

  late final _i1.ColumnString consistencyStyle;

  late final _i1.ColumnDateTime anchorTime;

  late final _i1.ColumnInt priority;

  late final _i1.ColumnInt currentStreak;

  late final _i1.ColumnInt longestStreak;

  late final _i1.ColumnDateTime lastEvaluatedPeriodEnd;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    title,
    description,
    affirmation,
    isActive,
    createdAt,
    targetCount,
    completedCount,
    periodType,
    periodStart,
    periodEnd,
    lastCompletedAt,
    consistencyStyle,
    anchorTime,
    priority,
    currentStreak,
    longestStreak,
    lastEvaluatedPeriodEnd,
  ];
}

class GoalInclude extends _i1.IncludeObject {
  GoalInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Goal.t;
}

class GoalIncludeList extends _i1.IncludeList {
  GoalIncludeList._({
    _i1.WhereExpressionBuilder<GoalTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Goal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Goal.t;
}

class GoalRepository {
  const GoalRepository._();

  /// Returns a list of [Goal]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Goal>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GoalTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GoalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Goal>(
      where: where?.call(Goal.t),
      orderBy: orderBy?.call(Goal.t),
      orderByList: orderByList?.call(Goal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Goal] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Goal?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GoalTable>? where,
    int? offset,
    _i1.OrderByBuilder<GoalTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GoalTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Goal>(
      where: where?.call(Goal.t),
      orderBy: orderBy?.call(Goal.t),
      orderByList: orderByList?.call(Goal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Goal] by its [id] or null if no such row exists.
  Future<Goal?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Goal>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Goal]s in the list and returns the inserted rows.
  ///
  /// The returned [Goal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Goal>> insert(
    _i1.Session session,
    List<Goal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Goal>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Goal] and returns the inserted row.
  ///
  /// The returned [Goal] will have its `id` field set.
  Future<Goal> insertRow(
    _i1.Session session,
    Goal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Goal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Goal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Goal>> update(
    _i1.Session session,
    List<Goal> rows, {
    _i1.ColumnSelections<GoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Goal>(
      rows,
      columns: columns?.call(Goal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Goal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Goal> updateRow(
    _i1.Session session,
    Goal row, {
    _i1.ColumnSelections<GoalTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Goal>(
      row,
      columns: columns?.call(Goal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Goal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Goal?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<GoalUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Goal>(
      id,
      columnValues: columnValues(Goal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Goal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Goal>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<GoalUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<GoalTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GoalTable>? orderBy,
    _i1.OrderByListBuilder<GoalTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Goal>(
      columnValues: columnValues(Goal.t.updateTable),
      where: where(Goal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Goal.t),
      orderByList: orderByList?.call(Goal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Goal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Goal>> delete(
    _i1.Session session,
    List<Goal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Goal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Goal].
  Future<Goal> deleteRow(
    _i1.Session session,
    Goal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Goal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Goal>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GoalTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Goal>(
      where: where(Goal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GoalTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Goal>(
      where: where?.call(Goal.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
