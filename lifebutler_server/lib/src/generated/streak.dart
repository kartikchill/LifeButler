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

abstract class Streak implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = StreakTable();

  static const db = StreakRepository._();

  @override
  int? id;

  int goalId;

  int currentStreak;

  int bestStreak;

  DateTime? lastCompletedDate;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static StreakInclude include() {
    return StreakInclude._();
  }

  static StreakIncludeList includeList({
    _i1.WhereExpressionBuilder<StreakTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StreakTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StreakTable>? orderByList,
    StreakInclude? include,
  }) {
    return StreakIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Streak.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Streak.t),
      include: include,
    );
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

class StreakUpdateTable extends _i1.UpdateTable<StreakTable> {
  StreakUpdateTable(super.table);

  _i1.ColumnValue<int, int> goalId(int value) => _i1.ColumnValue(
    table.goalId,
    value,
  );

  _i1.ColumnValue<int, int> currentStreak(int value) => _i1.ColumnValue(
    table.currentStreak,
    value,
  );

  _i1.ColumnValue<int, int> bestStreak(int value) => _i1.ColumnValue(
    table.bestStreak,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> lastCompletedDate(DateTime? value) =>
      _i1.ColumnValue(
        table.lastCompletedDate,
        value,
      );
}

class StreakTable extends _i1.Table<int?> {
  StreakTable({super.tableRelation}) : super(tableName: 'streak') {
    updateTable = StreakUpdateTable(this);
    goalId = _i1.ColumnInt(
      'goalId',
      this,
    );
    currentStreak = _i1.ColumnInt(
      'currentStreak',
      this,
    );
    bestStreak = _i1.ColumnInt(
      'bestStreak',
      this,
    );
    lastCompletedDate = _i1.ColumnDateTime(
      'lastCompletedDate',
      this,
    );
  }

  late final StreakUpdateTable updateTable;

  late final _i1.ColumnInt goalId;

  late final _i1.ColumnInt currentStreak;

  late final _i1.ColumnInt bestStreak;

  late final _i1.ColumnDateTime lastCompletedDate;

  @override
  List<_i1.Column> get columns => [
    id,
    goalId,
    currentStreak,
    bestStreak,
    lastCompletedDate,
  ];
}

class StreakInclude extends _i1.IncludeObject {
  StreakInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Streak.t;
}

class StreakIncludeList extends _i1.IncludeList {
  StreakIncludeList._({
    _i1.WhereExpressionBuilder<StreakTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Streak.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Streak.t;
}

class StreakRepository {
  const StreakRepository._();

  /// Returns a list of [Streak]s matching the given query parameters.
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
  Future<List<Streak>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StreakTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StreakTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StreakTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Streak>(
      where: where?.call(Streak.t),
      orderBy: orderBy?.call(Streak.t),
      orderByList: orderByList?.call(Streak.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Streak] matching the given query parameters.
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
  Future<Streak?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StreakTable>? where,
    int? offset,
    _i1.OrderByBuilder<StreakTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StreakTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Streak>(
      where: where?.call(Streak.t),
      orderBy: orderBy?.call(Streak.t),
      orderByList: orderByList?.call(Streak.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Streak] by its [id] or null if no such row exists.
  Future<Streak?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Streak>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Streak]s in the list and returns the inserted rows.
  ///
  /// The returned [Streak]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Streak>> insert(
    _i1.Session session,
    List<Streak> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Streak>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Streak] and returns the inserted row.
  ///
  /// The returned [Streak] will have its `id` field set.
  Future<Streak> insertRow(
    _i1.Session session,
    Streak row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Streak>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Streak]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Streak>> update(
    _i1.Session session,
    List<Streak> rows, {
    _i1.ColumnSelections<StreakTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Streak>(
      rows,
      columns: columns?.call(Streak.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Streak]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Streak> updateRow(
    _i1.Session session,
    Streak row, {
    _i1.ColumnSelections<StreakTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Streak>(
      row,
      columns: columns?.call(Streak.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Streak] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Streak?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<StreakUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Streak>(
      id,
      columnValues: columnValues(Streak.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Streak]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Streak>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<StreakUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<StreakTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StreakTable>? orderBy,
    _i1.OrderByListBuilder<StreakTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Streak>(
      columnValues: columnValues(Streak.t.updateTable),
      where: where(Streak.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Streak.t),
      orderByList: orderByList?.call(Streak.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Streak]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Streak>> delete(
    _i1.Session session,
    List<Streak> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Streak>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Streak].
  Future<Streak> deleteRow(
    _i1.Session session,
    Streak row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Streak>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Streak>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StreakTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Streak>(
      where: where(Streak.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StreakTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Streak>(
      where: where?.call(Streak.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
