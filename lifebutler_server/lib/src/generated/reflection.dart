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

abstract class Reflection
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = ReflectionTable();

  static const db = ReflectionRepository._();

  @override
  int? id;

  int userId;

  int? goalId;

  int type;

  String content;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static ReflectionInclude include() {
    return ReflectionInclude._();
  }

  static ReflectionIncludeList includeList({
    _i1.WhereExpressionBuilder<ReflectionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReflectionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReflectionTable>? orderByList,
    ReflectionInclude? include,
  }) {
    return ReflectionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reflection.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Reflection.t),
      include: include,
    );
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

class ReflectionUpdateTable extends _i1.UpdateTable<ReflectionTable> {
  ReflectionUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> goalId(int? value) => _i1.ColumnValue(
    table.goalId,
    value,
  );

  _i1.ColumnValue<int, int> type(int value) => _i1.ColumnValue(
    table.type,
    value,
  );

  _i1.ColumnValue<String, String> content(String value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReflectionTable extends _i1.Table<int?> {
  ReflectionTable({super.tableRelation}) : super(tableName: 'reflection') {
    updateTable = ReflectionUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    goalId = _i1.ColumnInt(
      'goalId',
      this,
    );
    type = _i1.ColumnInt(
      'type',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final ReflectionUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt goalId;

  late final _i1.ColumnInt type;

  late final _i1.ColumnString content;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    goalId,
    type,
    content,
    createdAt,
  ];
}

class ReflectionInclude extends _i1.IncludeObject {
  ReflectionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Reflection.t;
}

class ReflectionIncludeList extends _i1.IncludeList {
  ReflectionIncludeList._({
    _i1.WhereExpressionBuilder<ReflectionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Reflection.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Reflection.t;
}

class ReflectionRepository {
  const ReflectionRepository._();

  /// Returns a list of [Reflection]s matching the given query parameters.
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
  Future<List<Reflection>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReflectionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReflectionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReflectionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Reflection>(
      where: where?.call(Reflection.t),
      orderBy: orderBy?.call(Reflection.t),
      orderByList: orderByList?.call(Reflection.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Reflection] matching the given query parameters.
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
  Future<Reflection?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReflectionTable>? where,
    int? offset,
    _i1.OrderByBuilder<ReflectionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ReflectionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Reflection>(
      where: where?.call(Reflection.t),
      orderBy: orderBy?.call(Reflection.t),
      orderByList: orderByList?.call(Reflection.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Reflection] by its [id] or null if no such row exists.
  Future<Reflection?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Reflection>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Reflection]s in the list and returns the inserted rows.
  ///
  /// The returned [Reflection]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Reflection>> insert(
    _i1.Session session,
    List<Reflection> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Reflection>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Reflection] and returns the inserted row.
  ///
  /// The returned [Reflection] will have its `id` field set.
  Future<Reflection> insertRow(
    _i1.Session session,
    Reflection row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Reflection>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Reflection]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Reflection>> update(
    _i1.Session session,
    List<Reflection> rows, {
    _i1.ColumnSelections<ReflectionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Reflection>(
      rows,
      columns: columns?.call(Reflection.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Reflection]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Reflection> updateRow(
    _i1.Session session,
    Reflection row, {
    _i1.ColumnSelections<ReflectionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Reflection>(
      row,
      columns: columns?.call(Reflection.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Reflection] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Reflection?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<ReflectionUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Reflection>(
      id,
      columnValues: columnValues(Reflection.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Reflection]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Reflection>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<ReflectionUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ReflectionTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ReflectionTable>? orderBy,
    _i1.OrderByListBuilder<ReflectionTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Reflection>(
      columnValues: columnValues(Reflection.t.updateTable),
      where: where(Reflection.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Reflection.t),
      orderByList: orderByList?.call(Reflection.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Reflection]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Reflection>> delete(
    _i1.Session session,
    List<Reflection> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Reflection>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Reflection].
  Future<Reflection> deleteRow(
    _i1.Session session,
    Reflection row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Reflection>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Reflection>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ReflectionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Reflection>(
      where: where(Reflection.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ReflectionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Reflection>(
      where: where?.call(Reflection.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
