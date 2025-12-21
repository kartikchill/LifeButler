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

abstract class UserMode
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  UserMode._({
    this.id,
    required this.userId,
    required this.mode,
    required this.createdAt,
  });

  factory UserMode({
    int? id,
    required int userId,
    required String mode,
    required DateTime createdAt,
  }) = _UserModeImpl;

  factory UserMode.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserMode(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      mode: jsonSerialization['mode'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = UserModeTable();

  static const db = UserModeRepository._();

  @override
  int? id;

  int userId;

  String mode;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [UserMode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserMode copyWith({
    int? id,
    int? userId,
    String? mode,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserMode',
      if (id != null) 'id': id,
      'userId': userId,
      'mode': mode,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserMode',
      if (id != null) 'id': id,
      'userId': userId,
      'mode': mode,
      'createdAt': createdAt.toJson(),
    };
  }

  static UserModeInclude include() {
    return UserModeInclude._();
  }

  static UserModeIncludeList includeList({
    _i1.WhereExpressionBuilder<UserModeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModeTable>? orderByList,
    UserModeInclude? include,
  }) {
    return UserModeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserMode.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserMode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserModeImpl extends UserMode {
  _UserModeImpl({
    int? id,
    required int userId,
    required String mode,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         mode: mode,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserMode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserMode copyWith({
    Object? id = _Undefined,
    int? userId,
    String? mode,
    DateTime? createdAt,
  }) {
    return UserMode(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      mode: mode ?? this.mode,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class UserModeUpdateTable extends _i1.UpdateTable<UserModeTable> {
  UserModeUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> mode(String value) => _i1.ColumnValue(
    table.mode,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class UserModeTable extends _i1.Table<int?> {
  UserModeTable({super.tableRelation}) : super(tableName: 'user_mode') {
    updateTable = UserModeUpdateTable(this);
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    mode = _i1.ColumnString(
      'mode',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final UserModeUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString mode;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    mode,
    createdAt,
  ];
}

class UserModeInclude extends _i1.IncludeObject {
  UserModeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserMode.t;
}

class UserModeIncludeList extends _i1.IncludeList {
  UserModeIncludeList._({
    _i1.WhereExpressionBuilder<UserModeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserMode.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserMode.t;
}

class UserModeRepository {
  const UserModeRepository._();

  /// Returns a list of [UserMode]s matching the given query parameters.
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
  Future<List<UserMode>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserModeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserMode>(
      where: where?.call(UserMode.t),
      orderBy: orderBy?.call(UserMode.t),
      orderByList: orderByList?.call(UserMode.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserMode] matching the given query parameters.
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
  Future<UserMode?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserModeTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserModeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserModeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserMode>(
      where: where?.call(UserMode.t),
      orderBy: orderBy?.call(UserMode.t),
      orderByList: orderByList?.call(UserMode.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserMode] by its [id] or null if no such row exists.
  Future<UserMode?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserMode>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserMode]s in the list and returns the inserted rows.
  ///
  /// The returned [UserMode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserMode>> insert(
    _i1.Session session,
    List<UserMode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserMode>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserMode] and returns the inserted row.
  ///
  /// The returned [UserMode] will have its `id` field set.
  Future<UserMode> insertRow(
    _i1.Session session,
    UserMode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserMode>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserMode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserMode>> update(
    _i1.Session session,
    List<UserMode> rows, {
    _i1.ColumnSelections<UserModeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserMode>(
      rows,
      columns: columns?.call(UserMode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserMode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserMode> updateRow(
    _i1.Session session,
    UserMode row, {
    _i1.ColumnSelections<UserModeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserMode>(
      row,
      columns: columns?.call(UserMode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserMode] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserMode?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserModeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserMode>(
      id,
      columnValues: columnValues(UserMode.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserMode]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserMode>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserModeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserModeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserModeTable>? orderBy,
    _i1.OrderByListBuilder<UserModeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserMode>(
      columnValues: columnValues(UserMode.t.updateTable),
      where: where(UserMode.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserMode.t),
      orderByList: orderByList?.call(UserMode.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserMode]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserMode>> delete(
    _i1.Session session,
    List<UserMode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserMode>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserMode].
  Future<UserMode> deleteRow(
    _i1.Session session,
    UserMode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserMode>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserMode>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserModeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserMode>(
      where: where(UserMode.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserModeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserMode>(
      where: where?.call(UserMode.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
