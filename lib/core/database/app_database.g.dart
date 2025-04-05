// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AdsManagerTableTable extends AdsManagerTable
    with TableInfo<$AdsManagerTableTable, AdsManagerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdsManagerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _functionCallCountMeta = const VerificationMeta(
    'functionCallCount',
  );
  @override
  late final GeneratedColumn<int> functionCallCount = GeneratedColumn<int>(
    'function_call_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, functionCallCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ads_manager_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdsManagerTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('function_call_count')) {
      context.handle(
        _functionCallCountMeta,
        functionCallCount.isAcceptableOrUnknown(
          data['function_call_count']!,
          _functionCallCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_functionCallCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AdsManagerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdsManagerTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      functionCallCount:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}function_call_count'],
          )!,
    );
  }

  @override
  $AdsManagerTableTable createAlias(String alias) {
    return $AdsManagerTableTable(attachedDatabase, alias);
  }
}

class AdsManagerTableData extends DataClass
    implements Insertable<AdsManagerTableData> {
  final int id;
  final int functionCallCount;
  const AdsManagerTableData({
    required this.id,
    required this.functionCallCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['function_call_count'] = Variable<int>(functionCallCount);
    return map;
  }

  AdsManagerTableCompanion toCompanion(bool nullToAbsent) {
    return AdsManagerTableCompanion(
      id: Value(id),
      functionCallCount: Value(functionCallCount),
    );
  }

  factory AdsManagerTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdsManagerTableData(
      id: serializer.fromJson<int>(json['id']),
      functionCallCount: serializer.fromJson<int>(json['functionCallCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'functionCallCount': serializer.toJson<int>(functionCallCount),
    };
  }

  AdsManagerTableData copyWith({int? id, int? functionCallCount}) =>
      AdsManagerTableData(
        id: id ?? this.id,
        functionCallCount: functionCallCount ?? this.functionCallCount,
      );
  AdsManagerTableData copyWithCompanion(AdsManagerTableCompanion data) {
    return AdsManagerTableData(
      id: data.id.present ? data.id.value : this.id,
      functionCallCount:
          data.functionCallCount.present
              ? data.functionCallCount.value
              : this.functionCallCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdsManagerTableData(')
          ..write('id: $id, ')
          ..write('functionCallCount: $functionCallCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, functionCallCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdsManagerTableData &&
          other.id == this.id &&
          other.functionCallCount == this.functionCallCount);
}

class AdsManagerTableCompanion extends UpdateCompanion<AdsManagerTableData> {
  final Value<int> id;
  final Value<int> functionCallCount;
  const AdsManagerTableCompanion({
    this.id = const Value.absent(),
    this.functionCallCount = const Value.absent(),
  });
  AdsManagerTableCompanion.insert({
    this.id = const Value.absent(),
    required int functionCallCount,
  }) : functionCallCount = Value(functionCallCount);
  static Insertable<AdsManagerTableData> custom({
    Expression<int>? id,
    Expression<int>? functionCallCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (functionCallCount != null) 'function_call_count': functionCallCount,
    });
  }

  AdsManagerTableCompanion copyWith({
    Value<int>? id,
    Value<int>? functionCallCount,
  }) {
    return AdsManagerTableCompanion(
      id: id ?? this.id,
      functionCallCount: functionCallCount ?? this.functionCallCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (functionCallCount.present) {
      map['function_call_count'] = Variable<int>(functionCallCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdsManagerTableCompanion(')
          ..write('id: $id, ')
          ..write('functionCallCount: $functionCallCount')
          ..write(')'))
        .toString();
  }
}

class $AccountDetailsTableTable extends AccountDetailsTable
    with TableInfo<$AccountDetailsTableTable, AccountDetailsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountDetailsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profilePathMeta = const VerificationMeta(
    'profilePath',
  );
  @override
  late final GeneratedColumn<String> profilePath = GeneratedColumn<String>(
    'profile_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, username, profilePath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_details_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountDetailsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('profile_path')) {
      context.handle(
        _profilePathMeta,
        profilePath.isAcceptableOrUnknown(
          data['profile_path']!,
          _profilePathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountDetailsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountDetailsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      username:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}username'],
          )!,
      profilePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_path'],
      ),
    );
  }

  @override
  $AccountDetailsTableTable createAlias(String alias) {
    return $AccountDetailsTableTable(attachedDatabase, alias);
  }
}

class AccountDetailsTableData extends DataClass
    implements Insertable<AccountDetailsTableData> {
  final int id;
  final String username;
  final String? profilePath;
  const AccountDetailsTableData({
    required this.id,
    required this.username,
    this.profilePath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || profilePath != null) {
      map['profile_path'] = Variable<String>(profilePath);
    }
    return map;
  }

  AccountDetailsTableCompanion toCompanion(bool nullToAbsent) {
    return AccountDetailsTableCompanion(
      id: Value(id),
      username: Value(username),
      profilePath:
          profilePath == null && nullToAbsent
              ? const Value.absent()
              : Value(profilePath),
    );
  }

  factory AccountDetailsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountDetailsTableData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      profilePath: serializer.fromJson<String?>(json['profilePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'profilePath': serializer.toJson<String?>(profilePath),
    };
  }

  AccountDetailsTableData copyWith({
    int? id,
    String? username,
    Value<String?> profilePath = const Value.absent(),
  }) => AccountDetailsTableData(
    id: id ?? this.id,
    username: username ?? this.username,
    profilePath: profilePath.present ? profilePath.value : this.profilePath,
  );
  AccountDetailsTableData copyWithCompanion(AccountDetailsTableCompanion data) {
    return AccountDetailsTableData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      profilePath:
          data.profilePath.present ? data.profilePath.value : this.profilePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountDetailsTableData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('profilePath: $profilePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, profilePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountDetailsTableData &&
          other.id == this.id &&
          other.username == this.username &&
          other.profilePath == this.profilePath);
}

class AccountDetailsTableCompanion
    extends UpdateCompanion<AccountDetailsTableData> {
  final Value<int> id;
  final Value<String> username;
  final Value<String?> profilePath;
  const AccountDetailsTableCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.profilePath = const Value.absent(),
  });
  AccountDetailsTableCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    this.profilePath = const Value.absent(),
  }) : username = Value(username);
  static Insertable<AccountDetailsTableData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? profilePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (profilePath != null) 'profile_path': profilePath,
    });
  }

  AccountDetailsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String?>? profilePath,
  }) {
    return AccountDetailsTableCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (profilePath.present) {
      map['profile_path'] = Variable<String>(profilePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountDetailsTableCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('profilePath: $profilePath')
          ..write(')'))
        .toString();
  }
}

class $MoviesTableTable extends MoviesTable
    with TableInfo<$MoviesTableTable, MoviesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoviesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List>
  popular = GeneratedColumn<Uint8List>(
    'popular',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<MoviesListModel>($MoviesTableTable.$converterpopular);
  @override
  late final GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List>
  inTheatre = GeneratedColumn<Uint8List>(
    'in_theatre',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<MoviesListModel>($MoviesTableTable.$converterinTheatre);
  @override
  late final GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List>
  trending = GeneratedColumn<Uint8List>(
    'trending',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<MoviesListModel>($MoviesTableTable.$convertertrending);
  @override
  late final GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List>
  topRated = GeneratedColumn<Uint8List>(
    'top_rated',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<MoviesListModel>($MoviesTableTable.$convertertopRated);
  @override
  late final GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List>
  upComing = GeneratedColumn<Uint8List>(
    'up_coming',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<MoviesListModel>($MoviesTableTable.$converterupComing);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    popular,
    inTheatre,
    trending,
    topRated,
    upComing,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movies_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoviesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoviesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoviesTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      popular: $MoviesTableTable.$converterpopular.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}popular'],
        )!,
      ),
      inTheatre: $MoviesTableTable.$converterinTheatre.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}in_theatre'],
        )!,
      ),
      trending: $MoviesTableTable.$convertertrending.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}trending'],
        )!,
      ),
      topRated: $MoviesTableTable.$convertertopRated.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}top_rated'],
        )!,
      ),
      upComing: $MoviesTableTable.$converterupComing.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}up_coming'],
        )!,
      ),
    );
  }

  @override
  $MoviesTableTable createAlias(String alias) {
    return $MoviesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MoviesListModel, Uint8List, Object?>
  $converterpopular = MoviesListModel.binaryConverter;
  static JsonTypeConverter2<MoviesListModel, Uint8List, Object?>
  $converterinTheatre = MoviesListModel.binaryConverter;
  static JsonTypeConverter2<MoviesListModel, Uint8List, Object?>
  $convertertrending = MoviesListModel.binaryConverter;
  static JsonTypeConverter2<MoviesListModel, Uint8List, Object?>
  $convertertopRated = MoviesListModel.binaryConverter;
  static JsonTypeConverter2<MoviesListModel, Uint8List, Object?>
  $converterupComing = MoviesListModel.binaryConverter;
}

class MoviesTableData extends DataClass implements Insertable<MoviesTableData> {
  final int id;
  final MoviesListModel popular;
  final MoviesListModel inTheatre;
  final MoviesListModel trending;
  final MoviesListModel topRated;
  final MoviesListModel upComing;
  const MoviesTableData({
    required this.id,
    required this.popular,
    required this.inTheatre,
    required this.trending,
    required this.topRated,
    required this.upComing,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['popular'] = Variable<Uint8List>(
        $MoviesTableTable.$converterpopular.toSql(popular),
      );
    }
    {
      map['in_theatre'] = Variable<Uint8List>(
        $MoviesTableTable.$converterinTheatre.toSql(inTheatre),
      );
    }
    {
      map['trending'] = Variable<Uint8List>(
        $MoviesTableTable.$convertertrending.toSql(trending),
      );
    }
    {
      map['top_rated'] = Variable<Uint8List>(
        $MoviesTableTable.$convertertopRated.toSql(topRated),
      );
    }
    {
      map['up_coming'] = Variable<Uint8List>(
        $MoviesTableTable.$converterupComing.toSql(upComing),
      );
    }
    return map;
  }

  MoviesTableCompanion toCompanion(bool nullToAbsent) {
    return MoviesTableCompanion(
      id: Value(id),
      popular: Value(popular),
      inTheatre: Value(inTheatre),
      trending: Value(trending),
      topRated: Value(topRated),
      upComing: Value(upComing),
    );
  }

  factory MoviesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoviesTableData(
      id: serializer.fromJson<int>(json['id']),
      popular: $MoviesTableTable.$converterpopular.fromJson(
        serializer.fromJson<Object?>(json['popular']),
      ),
      inTheatre: $MoviesTableTable.$converterinTheatre.fromJson(
        serializer.fromJson<Object?>(json['inTheatre']),
      ),
      trending: $MoviesTableTable.$convertertrending.fromJson(
        serializer.fromJson<Object?>(json['trending']),
      ),
      topRated: $MoviesTableTable.$convertertopRated.fromJson(
        serializer.fromJson<Object?>(json['topRated']),
      ),
      upComing: $MoviesTableTable.$converterupComing.fromJson(
        serializer.fromJson<Object?>(json['upComing']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'popular': serializer.toJson<Object?>(
        $MoviesTableTable.$converterpopular.toJson(popular),
      ),
      'inTheatre': serializer.toJson<Object?>(
        $MoviesTableTable.$converterinTheatre.toJson(inTheatre),
      ),
      'trending': serializer.toJson<Object?>(
        $MoviesTableTable.$convertertrending.toJson(trending),
      ),
      'topRated': serializer.toJson<Object?>(
        $MoviesTableTable.$convertertopRated.toJson(topRated),
      ),
      'upComing': serializer.toJson<Object?>(
        $MoviesTableTable.$converterupComing.toJson(upComing),
      ),
    };
  }

  MoviesTableData copyWith({
    int? id,
    MoviesListModel? popular,
    MoviesListModel? inTheatre,
    MoviesListModel? trending,
    MoviesListModel? topRated,
    MoviesListModel? upComing,
  }) => MoviesTableData(
    id: id ?? this.id,
    popular: popular ?? this.popular,
    inTheatre: inTheatre ?? this.inTheatre,
    trending: trending ?? this.trending,
    topRated: topRated ?? this.topRated,
    upComing: upComing ?? this.upComing,
  );
  MoviesTableData copyWithCompanion(MoviesTableCompanion data) {
    return MoviesTableData(
      id: data.id.present ? data.id.value : this.id,
      popular: data.popular.present ? data.popular.value : this.popular,
      inTheatre: data.inTheatre.present ? data.inTheatre.value : this.inTheatre,
      trending: data.trending.present ? data.trending.value : this.trending,
      topRated: data.topRated.present ? data.topRated.value : this.topRated,
      upComing: data.upComing.present ? data.upComing.value : this.upComing,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoviesTableData(')
          ..write('id: $id, ')
          ..write('popular: $popular, ')
          ..write('inTheatre: $inTheatre, ')
          ..write('trending: $trending, ')
          ..write('topRated: $topRated, ')
          ..write('upComing: $upComing')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, popular, inTheatre, trending, topRated, upComing);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoviesTableData &&
          other.id == this.id &&
          other.popular == this.popular &&
          other.inTheatre == this.inTheatre &&
          other.trending == this.trending &&
          other.topRated == this.topRated &&
          other.upComing == this.upComing);
}

class MoviesTableCompanion extends UpdateCompanion<MoviesTableData> {
  final Value<int> id;
  final Value<MoviesListModel> popular;
  final Value<MoviesListModel> inTheatre;
  final Value<MoviesListModel> trending;
  final Value<MoviesListModel> topRated;
  final Value<MoviesListModel> upComing;
  const MoviesTableCompanion({
    this.id = const Value.absent(),
    this.popular = const Value.absent(),
    this.inTheatre = const Value.absent(),
    this.trending = const Value.absent(),
    this.topRated = const Value.absent(),
    this.upComing = const Value.absent(),
  });
  MoviesTableCompanion.insert({
    this.id = const Value.absent(),
    required MoviesListModel popular,
    required MoviesListModel inTheatre,
    required MoviesListModel trending,
    required MoviesListModel topRated,
    required MoviesListModel upComing,
  }) : popular = Value(popular),
       inTheatre = Value(inTheatre),
       trending = Value(trending),
       topRated = Value(topRated),
       upComing = Value(upComing);
  static Insertable<MoviesTableData> custom({
    Expression<int>? id,
    Expression<Uint8List>? popular,
    Expression<Uint8List>? inTheatre,
    Expression<Uint8List>? trending,
    Expression<Uint8List>? topRated,
    Expression<Uint8List>? upComing,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (popular != null) 'popular': popular,
      if (inTheatre != null) 'in_theatre': inTheatre,
      if (trending != null) 'trending': trending,
      if (topRated != null) 'top_rated': topRated,
      if (upComing != null) 'up_coming': upComing,
    });
  }

  MoviesTableCompanion copyWith({
    Value<int>? id,
    Value<MoviesListModel>? popular,
    Value<MoviesListModel>? inTheatre,
    Value<MoviesListModel>? trending,
    Value<MoviesListModel>? topRated,
    Value<MoviesListModel>? upComing,
  }) {
    return MoviesTableCompanion(
      id: id ?? this.id,
      popular: popular ?? this.popular,
      inTheatre: inTheatre ?? this.inTheatre,
      trending: trending ?? this.trending,
      topRated: topRated ?? this.topRated,
      upComing: upComing ?? this.upComing,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (popular.present) {
      map['popular'] = Variable<Uint8List>(
        $MoviesTableTable.$converterpopular.toSql(popular.value),
      );
    }
    if (inTheatre.present) {
      map['in_theatre'] = Variable<Uint8List>(
        $MoviesTableTable.$converterinTheatre.toSql(inTheatre.value),
      );
    }
    if (trending.present) {
      map['trending'] = Variable<Uint8List>(
        $MoviesTableTable.$convertertrending.toSql(trending.value),
      );
    }
    if (topRated.present) {
      map['top_rated'] = Variable<Uint8List>(
        $MoviesTableTable.$convertertopRated.toSql(topRated.value),
      );
    }
    if (upComing.present) {
      map['up_coming'] = Variable<Uint8List>(
        $MoviesTableTable.$converterupComing.toSql(upComing.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoviesTableCompanion(')
          ..write('id: $id, ')
          ..write('popular: $popular, ')
          ..write('inTheatre: $inTheatre, ')
          ..write('trending: $trending, ')
          ..write('topRated: $topRated, ')
          ..write('upComing: $upComing')
          ..write(')'))
        .toString();
  }
}

class $TvShowsTableTable extends TvShowsTable
    with TableInfo<$TvShowsTableTable, TvShowsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TvShowsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TvShowsListModel, Uint8List>
  airingToday = GeneratedColumn<Uint8List>(
    'airing_today',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<TvShowsListModel>($TvShowsTableTable.$converterairingToday);
  @override
  late final GeneratedColumnWithTypeConverter<TvShowsListModel, Uint8List>
  trending = GeneratedColumn<Uint8List>(
    'trending',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<TvShowsListModel>($TvShowsTableTable.$convertertrending);
  @override
  late final GeneratedColumnWithTypeConverter<TvShowsListModel, Uint8List>
  topRated = GeneratedColumn<Uint8List>(
    'top_rated',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<TvShowsListModel>($TvShowsTableTable.$convertertopRated);
  @override
  late final GeneratedColumnWithTypeConverter<TvShowsListModel, Uint8List>
  popular = GeneratedColumn<Uint8List>(
    'popular',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<TvShowsListModel>($TvShowsTableTable.$converterpopular);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    airingToday,
    trending,
    topRated,
    popular,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tv_shows_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TvShowsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TvShowsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TvShowsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      airingToday: $TvShowsTableTable.$converterairingToday.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}airing_today'],
        )!,
      ),
      trending: $TvShowsTableTable.$convertertrending.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}trending'],
        )!,
      ),
      topRated: $TvShowsTableTable.$convertertopRated.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}top_rated'],
        )!,
      ),
      popular: $TvShowsTableTable.$converterpopular.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}popular'],
        )!,
      ),
    );
  }

  @override
  $TvShowsTableTable createAlias(String alias) {
    return $TvShowsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TvShowsListModel, Uint8List, Object?>
  $converterairingToday = TvShowsListModel.binaryConverter;
  static JsonTypeConverter2<TvShowsListModel, Uint8List, Object?>
  $convertertrending = TvShowsListModel.binaryConverter;
  static JsonTypeConverter2<TvShowsListModel, Uint8List, Object?>
  $convertertopRated = TvShowsListModel.binaryConverter;
  static JsonTypeConverter2<TvShowsListModel, Uint8List, Object?>
  $converterpopular = TvShowsListModel.binaryConverter;
}

class TvShowsTableData extends DataClass
    implements Insertable<TvShowsTableData> {
  final int id;
  final TvShowsListModel airingToday;
  final TvShowsListModel trending;
  final TvShowsListModel topRated;
  final TvShowsListModel popular;
  const TvShowsTableData({
    required this.id,
    required this.airingToday,
    required this.trending,
    required this.topRated,
    required this.popular,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['airing_today'] = Variable<Uint8List>(
        $TvShowsTableTable.$converterairingToday.toSql(airingToday),
      );
    }
    {
      map['trending'] = Variable<Uint8List>(
        $TvShowsTableTable.$convertertrending.toSql(trending),
      );
    }
    {
      map['top_rated'] = Variable<Uint8List>(
        $TvShowsTableTable.$convertertopRated.toSql(topRated),
      );
    }
    {
      map['popular'] = Variable<Uint8List>(
        $TvShowsTableTable.$converterpopular.toSql(popular),
      );
    }
    return map;
  }

  TvShowsTableCompanion toCompanion(bool nullToAbsent) {
    return TvShowsTableCompanion(
      id: Value(id),
      airingToday: Value(airingToday),
      trending: Value(trending),
      topRated: Value(topRated),
      popular: Value(popular),
    );
  }

  factory TvShowsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TvShowsTableData(
      id: serializer.fromJson<int>(json['id']),
      airingToday: $TvShowsTableTable.$converterairingToday.fromJson(
        serializer.fromJson<Object?>(json['airingToday']),
      ),
      trending: $TvShowsTableTable.$convertertrending.fromJson(
        serializer.fromJson<Object?>(json['trending']),
      ),
      topRated: $TvShowsTableTable.$convertertopRated.fromJson(
        serializer.fromJson<Object?>(json['topRated']),
      ),
      popular: $TvShowsTableTable.$converterpopular.fromJson(
        serializer.fromJson<Object?>(json['popular']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'airingToday': serializer.toJson<Object?>(
        $TvShowsTableTable.$converterairingToday.toJson(airingToday),
      ),
      'trending': serializer.toJson<Object?>(
        $TvShowsTableTable.$convertertrending.toJson(trending),
      ),
      'topRated': serializer.toJson<Object?>(
        $TvShowsTableTable.$convertertopRated.toJson(topRated),
      ),
      'popular': serializer.toJson<Object?>(
        $TvShowsTableTable.$converterpopular.toJson(popular),
      ),
    };
  }

  TvShowsTableData copyWith({
    int? id,
    TvShowsListModel? airingToday,
    TvShowsListModel? trending,
    TvShowsListModel? topRated,
    TvShowsListModel? popular,
  }) => TvShowsTableData(
    id: id ?? this.id,
    airingToday: airingToday ?? this.airingToday,
    trending: trending ?? this.trending,
    topRated: topRated ?? this.topRated,
    popular: popular ?? this.popular,
  );
  TvShowsTableData copyWithCompanion(TvShowsTableCompanion data) {
    return TvShowsTableData(
      id: data.id.present ? data.id.value : this.id,
      airingToday:
          data.airingToday.present ? data.airingToday.value : this.airingToday,
      trending: data.trending.present ? data.trending.value : this.trending,
      topRated: data.topRated.present ? data.topRated.value : this.topRated,
      popular: data.popular.present ? data.popular.value : this.popular,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TvShowsTableData(')
          ..write('id: $id, ')
          ..write('airingToday: $airingToday, ')
          ..write('trending: $trending, ')
          ..write('topRated: $topRated, ')
          ..write('popular: $popular')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, airingToday, trending, topRated, popular);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TvShowsTableData &&
          other.id == this.id &&
          other.airingToday == this.airingToday &&
          other.trending == this.trending &&
          other.topRated == this.topRated &&
          other.popular == this.popular);
}

class TvShowsTableCompanion extends UpdateCompanion<TvShowsTableData> {
  final Value<int> id;
  final Value<TvShowsListModel> airingToday;
  final Value<TvShowsListModel> trending;
  final Value<TvShowsListModel> topRated;
  final Value<TvShowsListModel> popular;
  const TvShowsTableCompanion({
    this.id = const Value.absent(),
    this.airingToday = const Value.absent(),
    this.trending = const Value.absent(),
    this.topRated = const Value.absent(),
    this.popular = const Value.absent(),
  });
  TvShowsTableCompanion.insert({
    this.id = const Value.absent(),
    required TvShowsListModel airingToday,
    required TvShowsListModel trending,
    required TvShowsListModel topRated,
    required TvShowsListModel popular,
  }) : airingToday = Value(airingToday),
       trending = Value(trending),
       topRated = Value(topRated),
       popular = Value(popular);
  static Insertable<TvShowsTableData> custom({
    Expression<int>? id,
    Expression<Uint8List>? airingToday,
    Expression<Uint8List>? trending,
    Expression<Uint8List>? topRated,
    Expression<Uint8List>? popular,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (airingToday != null) 'airing_today': airingToday,
      if (trending != null) 'trending': trending,
      if (topRated != null) 'top_rated': topRated,
      if (popular != null) 'popular': popular,
    });
  }

  TvShowsTableCompanion copyWith({
    Value<int>? id,
    Value<TvShowsListModel>? airingToday,
    Value<TvShowsListModel>? trending,
    Value<TvShowsListModel>? topRated,
    Value<TvShowsListModel>? popular,
  }) {
    return TvShowsTableCompanion(
      id: id ?? this.id,
      airingToday: airingToday ?? this.airingToday,
      trending: trending ?? this.trending,
      topRated: topRated ?? this.topRated,
      popular: popular ?? this.popular,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (airingToday.present) {
      map['airing_today'] = Variable<Uint8List>(
        $TvShowsTableTable.$converterairingToday.toSql(airingToday.value),
      );
    }
    if (trending.present) {
      map['trending'] = Variable<Uint8List>(
        $TvShowsTableTable.$convertertrending.toSql(trending.value),
      );
    }
    if (topRated.present) {
      map['top_rated'] = Variable<Uint8List>(
        $TvShowsTableTable.$convertertopRated.toSql(topRated.value),
      );
    }
    if (popular.present) {
      map['popular'] = Variable<Uint8List>(
        $TvShowsTableTable.$converterpopular.toSql(popular.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TvShowsTableCompanion(')
          ..write('id: $id, ')
          ..write('airingToday: $airingToday, ')
          ..write('trending: $trending, ')
          ..write('topRated: $topRated, ')
          ..write('popular: $popular')
          ..write(')'))
        .toString();
  }
}

class $CelebsTableTable extends CelebsTable
    with TableInfo<$CelebsTableTable, CelebsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CelebsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CelebritiesListModel, Uint8List>
  popular = GeneratedColumn<Uint8List>(
    'popular',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<CelebritiesListModel>($CelebsTableTable.$converterpopular);
  @override
  late final GeneratedColumnWithTypeConverter<CelebritiesListModel, Uint8List>
  trending = GeneratedColumn<Uint8List>(
    'trending',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<CelebritiesListModel>($CelebsTableTable.$convertertrending);
  @override
  List<GeneratedColumn> get $columns => [id, popular, trending];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'celebs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CelebsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CelebsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CelebsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      popular: $CelebsTableTable.$converterpopular.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}popular'],
        )!,
      ),
      trending: $CelebsTableTable.$convertertrending.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.blob,
          data['${effectivePrefix}trending'],
        )!,
      ),
    );
  }

  @override
  $CelebsTableTable createAlias(String alias) {
    return $CelebsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CelebritiesListModel, Uint8List, Object?>
  $converterpopular = CelebritiesListModel.binaryConverter;
  static JsonTypeConverter2<CelebritiesListModel, Uint8List, Object?>
  $convertertrending = CelebritiesListModel.binaryConverter;
}

class CelebsTableData extends DataClass implements Insertable<CelebsTableData> {
  final int id;
  final CelebritiesListModel popular;
  final CelebritiesListModel trending;
  const CelebsTableData({
    required this.id,
    required this.popular,
    required this.trending,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['popular'] = Variable<Uint8List>(
        $CelebsTableTable.$converterpopular.toSql(popular),
      );
    }
    {
      map['trending'] = Variable<Uint8List>(
        $CelebsTableTable.$convertertrending.toSql(trending),
      );
    }
    return map;
  }

  CelebsTableCompanion toCompanion(bool nullToAbsent) {
    return CelebsTableCompanion(
      id: Value(id),
      popular: Value(popular),
      trending: Value(trending),
    );
  }

  factory CelebsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CelebsTableData(
      id: serializer.fromJson<int>(json['id']),
      popular: $CelebsTableTable.$converterpopular.fromJson(
        serializer.fromJson<Object?>(json['popular']),
      ),
      trending: $CelebsTableTable.$convertertrending.fromJson(
        serializer.fromJson<Object?>(json['trending']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'popular': serializer.toJson<Object?>(
        $CelebsTableTable.$converterpopular.toJson(popular),
      ),
      'trending': serializer.toJson<Object?>(
        $CelebsTableTable.$convertertrending.toJson(trending),
      ),
    };
  }

  CelebsTableData copyWith({
    int? id,
    CelebritiesListModel? popular,
    CelebritiesListModel? trending,
  }) => CelebsTableData(
    id: id ?? this.id,
    popular: popular ?? this.popular,
    trending: trending ?? this.trending,
  );
  CelebsTableData copyWithCompanion(CelebsTableCompanion data) {
    return CelebsTableData(
      id: data.id.present ? data.id.value : this.id,
      popular: data.popular.present ? data.popular.value : this.popular,
      trending: data.trending.present ? data.trending.value : this.trending,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CelebsTableData(')
          ..write('id: $id, ')
          ..write('popular: $popular, ')
          ..write('trending: $trending')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, popular, trending);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CelebsTableData &&
          other.id == this.id &&
          other.popular == this.popular &&
          other.trending == this.trending);
}

class CelebsTableCompanion extends UpdateCompanion<CelebsTableData> {
  final Value<int> id;
  final Value<CelebritiesListModel> popular;
  final Value<CelebritiesListModel> trending;
  const CelebsTableCompanion({
    this.id = const Value.absent(),
    this.popular = const Value.absent(),
    this.trending = const Value.absent(),
  });
  CelebsTableCompanion.insert({
    this.id = const Value.absent(),
    required CelebritiesListModel popular,
    required CelebritiesListModel trending,
  }) : popular = Value(popular),
       trending = Value(trending);
  static Insertable<CelebsTableData> custom({
    Expression<int>? id,
    Expression<Uint8List>? popular,
    Expression<Uint8List>? trending,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (popular != null) 'popular': popular,
      if (trending != null) 'trending': trending,
    });
  }

  CelebsTableCompanion copyWith({
    Value<int>? id,
    Value<CelebritiesListModel>? popular,
    Value<CelebritiesListModel>? trending,
  }) {
    return CelebsTableCompanion(
      id: id ?? this.id,
      popular: popular ?? this.popular,
      trending: trending ?? this.trending,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (popular.present) {
      map['popular'] = Variable<Uint8List>(
        $CelebsTableTable.$converterpopular.toSql(popular.value),
      );
    }
    if (trending.present) {
      map['trending'] = Variable<Uint8List>(
        $CelebsTableTable.$convertertrending.toSql(trending.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CelebsTableCompanion(')
          ..write('id: $id, ')
          ..write('popular: $popular, ')
          ..write('trending: $trending')
          ..write(')'))
        .toString();
  }
}

class $TrendingSearchTableTable extends TrendingSearchTable
    with TableInfo<$TrendingSearchTableTable, TrendingSearchTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrendingSearchTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SearchesModel, Uint8List>
  trendingSearch = GeneratedColumn<Uint8List>(
    'trending_search',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  ).withConverter<SearchesModel>(
    $TrendingSearchTableTable.$convertertrendingSearch,
  );
  @override
  List<GeneratedColumn> get $columns => [id, trendingSearch];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trending_search_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrendingSearchTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrendingSearchTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrendingSearchTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      trendingSearch: $TrendingSearchTableTable.$convertertrendingSearch
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.blob,
              data['${effectivePrefix}trending_search'],
            )!,
          ),
    );
  }

  @override
  $TrendingSearchTableTable createAlias(String alias) {
    return $TrendingSearchTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SearchesModel, Uint8List, Object?>
  $convertertrendingSearch = SearchesModel.binaryConverter;
}

class TrendingSearchTableData extends DataClass
    implements Insertable<TrendingSearchTableData> {
  final int id;
  final SearchesModel trendingSearch;
  const TrendingSearchTableData({
    required this.id,
    required this.trendingSearch,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['trending_search'] = Variable<Uint8List>(
        $TrendingSearchTableTable.$convertertrendingSearch.toSql(
          trendingSearch,
        ),
      );
    }
    return map;
  }

  TrendingSearchTableCompanion toCompanion(bool nullToAbsent) {
    return TrendingSearchTableCompanion(
      id: Value(id),
      trendingSearch: Value(trendingSearch),
    );
  }

  factory TrendingSearchTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrendingSearchTableData(
      id: serializer.fromJson<int>(json['id']),
      trendingSearch: $TrendingSearchTableTable.$convertertrendingSearch
          .fromJson(serializer.fromJson<Object?>(json['trendingSearch'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'trendingSearch': serializer.toJson<Object?>(
        $TrendingSearchTableTable.$convertertrendingSearch.toJson(
          trendingSearch,
        ),
      ),
    };
  }

  TrendingSearchTableData copyWith({int? id, SearchesModel? trendingSearch}) =>
      TrendingSearchTableData(
        id: id ?? this.id,
        trendingSearch: trendingSearch ?? this.trendingSearch,
      );
  TrendingSearchTableData copyWithCompanion(TrendingSearchTableCompanion data) {
    return TrendingSearchTableData(
      id: data.id.present ? data.id.value : this.id,
      trendingSearch:
          data.trendingSearch.present
              ? data.trendingSearch.value
              : this.trendingSearch,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrendingSearchTableData(')
          ..write('id: $id, ')
          ..write('trendingSearch: $trendingSearch')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, trendingSearch);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrendingSearchTableData &&
          other.id == this.id &&
          other.trendingSearch == this.trendingSearch);
}

class TrendingSearchTableCompanion
    extends UpdateCompanion<TrendingSearchTableData> {
  final Value<int> id;
  final Value<SearchesModel> trendingSearch;
  const TrendingSearchTableCompanion({
    this.id = const Value.absent(),
    this.trendingSearch = const Value.absent(),
  });
  TrendingSearchTableCompanion.insert({
    this.id = const Value.absent(),
    required SearchesModel trendingSearch,
  }) : trendingSearch = Value(trendingSearch);
  static Insertable<TrendingSearchTableData> custom({
    Expression<int>? id,
    Expression<Uint8List>? trendingSearch,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (trendingSearch != null) 'trending_search': trendingSearch,
    });
  }

  TrendingSearchTableCompanion copyWith({
    Value<int>? id,
    Value<SearchesModel>? trendingSearch,
  }) {
    return TrendingSearchTableCompanion(
      id: id ?? this.id,
      trendingSearch: trendingSearch ?? this.trendingSearch,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (trendingSearch.present) {
      map['trending_search'] = Variable<Uint8List>(
        $TrendingSearchTableTable.$convertertrendingSearch.toSql(
          trendingSearch.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrendingSearchTableCompanion(')
          ..write('id: $id, ')
          ..write('trendingSearch: $trendingSearch')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AdsManagerTableTable adsManagerTable = $AdsManagerTableTable(
    this,
  );
  late final $AccountDetailsTableTable accountDetailsTable =
      $AccountDetailsTableTable(this);
  late final $MoviesTableTable moviesTable = $MoviesTableTable(this);
  late final $TvShowsTableTable tvShowsTable = $TvShowsTableTable(this);
  late final $CelebsTableTable celebsTable = $CelebsTableTable(this);
  late final $TrendingSearchTableTable trendingSearchTable =
      $TrendingSearchTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    adsManagerTable,
    accountDetailsTable,
    moviesTable,
    tvShowsTable,
    celebsTable,
    trendingSearchTable,
  ];
}

typedef $$AdsManagerTableTableCreateCompanionBuilder =
    AdsManagerTableCompanion Function({
      Value<int> id,
      required int functionCallCount,
    });
typedef $$AdsManagerTableTableUpdateCompanionBuilder =
    AdsManagerTableCompanion Function({
      Value<int> id,
      Value<int> functionCallCount,
    });

class $$AdsManagerTableTableFilterComposer
    extends Composer<_$AppDatabase, $AdsManagerTableTable> {
  $$AdsManagerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get functionCallCount => $composableBuilder(
    column: $table.functionCallCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AdsManagerTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AdsManagerTableTable> {
  $$AdsManagerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get functionCallCount => $composableBuilder(
    column: $table.functionCallCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AdsManagerTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdsManagerTableTable> {
  $$AdsManagerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get functionCallCount => $composableBuilder(
    column: $table.functionCallCount,
    builder: (column) => column,
  );
}

class $$AdsManagerTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AdsManagerTableTable,
          AdsManagerTableData,
          $$AdsManagerTableTableFilterComposer,
          $$AdsManagerTableTableOrderingComposer,
          $$AdsManagerTableTableAnnotationComposer,
          $$AdsManagerTableTableCreateCompanionBuilder,
          $$AdsManagerTableTableUpdateCompanionBuilder,
          (
            AdsManagerTableData,
            BaseReferences<
              _$AppDatabase,
              $AdsManagerTableTable,
              AdsManagerTableData
            >,
          ),
          AdsManagerTableData,
          PrefetchHooks Function()
        > {
  $$AdsManagerTableTableTableManager(
    _$AppDatabase db,
    $AdsManagerTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$AdsManagerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AdsManagerTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$AdsManagerTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> functionCallCount = const Value.absent(),
              }) => AdsManagerTableCompanion(
                id: id,
                functionCallCount: functionCallCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int functionCallCount,
              }) => AdsManagerTableCompanion.insert(
                id: id,
                functionCallCount: functionCallCount,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AdsManagerTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AdsManagerTableTable,
      AdsManagerTableData,
      $$AdsManagerTableTableFilterComposer,
      $$AdsManagerTableTableOrderingComposer,
      $$AdsManagerTableTableAnnotationComposer,
      $$AdsManagerTableTableCreateCompanionBuilder,
      $$AdsManagerTableTableUpdateCompanionBuilder,
      (
        AdsManagerTableData,
        BaseReferences<
          _$AppDatabase,
          $AdsManagerTableTable,
          AdsManagerTableData
        >,
      ),
      AdsManagerTableData,
      PrefetchHooks Function()
    >;
typedef $$AccountDetailsTableTableCreateCompanionBuilder =
    AccountDetailsTableCompanion Function({
      Value<int> id,
      required String username,
      Value<String?> profilePath,
    });
typedef $$AccountDetailsTableTableUpdateCompanionBuilder =
    AccountDetailsTableCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String?> profilePath,
    });

class $$AccountDetailsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AccountDetailsTableTable> {
  $$AccountDetailsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get profilePath => $composableBuilder(
    column: $table.profilePath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountDetailsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountDetailsTableTable> {
  $$AccountDetailsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profilePath => $composableBuilder(
    column: $table.profilePath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountDetailsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountDetailsTableTable> {
  $$AccountDetailsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get profilePath => $composableBuilder(
    column: $table.profilePath,
    builder: (column) => column,
  );
}

class $$AccountDetailsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountDetailsTableTable,
          AccountDetailsTableData,
          $$AccountDetailsTableTableFilterComposer,
          $$AccountDetailsTableTableOrderingComposer,
          $$AccountDetailsTableTableAnnotationComposer,
          $$AccountDetailsTableTableCreateCompanionBuilder,
          $$AccountDetailsTableTableUpdateCompanionBuilder,
          (
            AccountDetailsTableData,
            BaseReferences<
              _$AppDatabase,
              $AccountDetailsTableTable,
              AccountDetailsTableData
            >,
          ),
          AccountDetailsTableData,
          PrefetchHooks Function()
        > {
  $$AccountDetailsTableTableTableManager(
    _$AppDatabase db,
    $AccountDetailsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$AccountDetailsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$AccountDetailsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$AccountDetailsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String?> profilePath = const Value.absent(),
              }) => AccountDetailsTableCompanion(
                id: id,
                username: username,
                profilePath: profilePath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                Value<String?> profilePath = const Value.absent(),
              }) => AccountDetailsTableCompanion.insert(
                id: id,
                username: username,
                profilePath: profilePath,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountDetailsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountDetailsTableTable,
      AccountDetailsTableData,
      $$AccountDetailsTableTableFilterComposer,
      $$AccountDetailsTableTableOrderingComposer,
      $$AccountDetailsTableTableAnnotationComposer,
      $$AccountDetailsTableTableCreateCompanionBuilder,
      $$AccountDetailsTableTableUpdateCompanionBuilder,
      (
        AccountDetailsTableData,
        BaseReferences<
          _$AppDatabase,
          $AccountDetailsTableTable,
          AccountDetailsTableData
        >,
      ),
      AccountDetailsTableData,
      PrefetchHooks Function()
    >;
typedef $$MoviesTableTableCreateCompanionBuilder =
    MoviesTableCompanion Function({
      Value<int> id,
      required MoviesListModel popular,
      required MoviesListModel inTheatre,
      required MoviesListModel trending,
      required MoviesListModel topRated,
      required MoviesListModel upComing,
    });
typedef $$MoviesTableTableUpdateCompanionBuilder =
    MoviesTableCompanion Function({
      Value<int> id,
      Value<MoviesListModel> popular,
      Value<MoviesListModel> inTheatre,
      Value<MoviesListModel> trending,
      Value<MoviesListModel> topRated,
      Value<MoviesListModel> upComing,
    });

class $$MoviesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MoviesTableTable> {
  $$MoviesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MoviesListModel, MoviesListModel, Uint8List>
  get popular => $composableBuilder(
    column: $table.popular,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<MoviesListModel, MoviesListModel, Uint8List>
  get inTheatre => $composableBuilder(
    column: $table.inTheatre,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<MoviesListModel, MoviesListModel, Uint8List>
  get trending => $composableBuilder(
    column: $table.trending,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<MoviesListModel, MoviesListModel, Uint8List>
  get topRated => $composableBuilder(
    column: $table.topRated,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<MoviesListModel, MoviesListModel, Uint8List>
  get upComing => $composableBuilder(
    column: $table.upComing,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$MoviesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MoviesTableTable> {
  $$MoviesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get popular => $composableBuilder(
    column: $table.popular,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get inTheatre => $composableBuilder(
    column: $table.inTheatre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get trending => $composableBuilder(
    column: $table.trending,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get topRated => $composableBuilder(
    column: $table.topRated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get upComing => $composableBuilder(
    column: $table.upComing,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MoviesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MoviesTableTable> {
  $$MoviesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List> get popular =>
      $composableBuilder(column: $table.popular, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List> get inTheatre =>
      $composableBuilder(column: $table.inTheatre, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List> get trending =>
      $composableBuilder(column: $table.trending, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List> get topRated =>
      $composableBuilder(column: $table.topRated, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoviesListModel, Uint8List> get upComing =>
      $composableBuilder(column: $table.upComing, builder: (column) => column);
}

class $$MoviesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MoviesTableTable,
          MoviesTableData,
          $$MoviesTableTableFilterComposer,
          $$MoviesTableTableOrderingComposer,
          $$MoviesTableTableAnnotationComposer,
          $$MoviesTableTableCreateCompanionBuilder,
          $$MoviesTableTableUpdateCompanionBuilder,
          (
            MoviesTableData,
            BaseReferences<_$AppDatabase, $MoviesTableTable, MoviesTableData>,
          ),
          MoviesTableData,
          PrefetchHooks Function()
        > {
  $$MoviesTableTableTableManager(_$AppDatabase db, $MoviesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MoviesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MoviesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$MoviesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<MoviesListModel> popular = const Value.absent(),
                Value<MoviesListModel> inTheatre = const Value.absent(),
                Value<MoviesListModel> trending = const Value.absent(),
                Value<MoviesListModel> topRated = const Value.absent(),
                Value<MoviesListModel> upComing = const Value.absent(),
              }) => MoviesTableCompanion(
                id: id,
                popular: popular,
                inTheatre: inTheatre,
                trending: trending,
                topRated: topRated,
                upComing: upComing,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required MoviesListModel popular,
                required MoviesListModel inTheatre,
                required MoviesListModel trending,
                required MoviesListModel topRated,
                required MoviesListModel upComing,
              }) => MoviesTableCompanion.insert(
                id: id,
                popular: popular,
                inTheatre: inTheatre,
                trending: trending,
                topRated: topRated,
                upComing: upComing,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MoviesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MoviesTableTable,
      MoviesTableData,
      $$MoviesTableTableFilterComposer,
      $$MoviesTableTableOrderingComposer,
      $$MoviesTableTableAnnotationComposer,
      $$MoviesTableTableCreateCompanionBuilder,
      $$MoviesTableTableUpdateCompanionBuilder,
      (
        MoviesTableData,
        BaseReferences<_$AppDatabase, $MoviesTableTable, MoviesTableData>,
      ),
      MoviesTableData,
      PrefetchHooks Function()
    >;
typedef $$TvShowsTableTableCreateCompanionBuilder =
    TvShowsTableCompanion Function({
      Value<int> id,
      required TvShowsListModel airingToday,
      required TvShowsListModel trending,
      required TvShowsListModel topRated,
      required TvShowsListModel popular,
    });
typedef $$TvShowsTableTableUpdateCompanionBuilder =
    TvShowsTableCompanion Function({
      Value<int> id,
      Value<TvShowsListModel> airingToday,
      Value<TvShowsListModel> trending,
      Value<TvShowsListModel> topRated,
      Value<TvShowsListModel> popular,
    });

class $$TvShowsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TvShowsTableTable> {
  $$TvShowsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TvShowsListModel, TvShowsListModel, Uint8List>
  get airingToday => $composableBuilder(
    column: $table.airingToday,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TvShowsListModel, TvShowsListModel, Uint8List>
  get trending => $composableBuilder(
    column: $table.trending,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TvShowsListModel, TvShowsListModel, Uint8List>
  get topRated => $composableBuilder(
    column: $table.topRated,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<TvShowsListModel, TvShowsListModel, Uint8List>
  get popular => $composableBuilder(
    column: $table.popular,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$TvShowsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TvShowsTableTable> {
  $$TvShowsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get airingToday => $composableBuilder(
    column: $table.airingToday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get trending => $composableBuilder(
    column: $table.trending,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get topRated => $composableBuilder(
    column: $table.topRated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get popular => $composableBuilder(
    column: $table.popular,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TvShowsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TvShowsTableTable> {
  $$TvShowsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TvShowsListModel, Uint8List>
  get airingToday => $composableBuilder(
    column: $table.airingToday,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TvShowsListModel, Uint8List> get trending =>
      $composableBuilder(column: $table.trending, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TvShowsListModel, Uint8List> get topRated =>
      $composableBuilder(column: $table.topRated, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TvShowsListModel, Uint8List> get popular =>
      $composableBuilder(column: $table.popular, builder: (column) => column);
}

class $$TvShowsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TvShowsTableTable,
          TvShowsTableData,
          $$TvShowsTableTableFilterComposer,
          $$TvShowsTableTableOrderingComposer,
          $$TvShowsTableTableAnnotationComposer,
          $$TvShowsTableTableCreateCompanionBuilder,
          $$TvShowsTableTableUpdateCompanionBuilder,
          (
            TvShowsTableData,
            BaseReferences<_$AppDatabase, $TvShowsTableTable, TvShowsTableData>,
          ),
          TvShowsTableData,
          PrefetchHooks Function()
        > {
  $$TvShowsTableTableTableManager(_$AppDatabase db, $TvShowsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TvShowsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TvShowsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$TvShowsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<TvShowsListModel> airingToday = const Value.absent(),
                Value<TvShowsListModel> trending = const Value.absent(),
                Value<TvShowsListModel> topRated = const Value.absent(),
                Value<TvShowsListModel> popular = const Value.absent(),
              }) => TvShowsTableCompanion(
                id: id,
                airingToday: airingToday,
                trending: trending,
                topRated: topRated,
                popular: popular,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required TvShowsListModel airingToday,
                required TvShowsListModel trending,
                required TvShowsListModel topRated,
                required TvShowsListModel popular,
              }) => TvShowsTableCompanion.insert(
                id: id,
                airingToday: airingToday,
                trending: trending,
                topRated: topRated,
                popular: popular,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TvShowsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TvShowsTableTable,
      TvShowsTableData,
      $$TvShowsTableTableFilterComposer,
      $$TvShowsTableTableOrderingComposer,
      $$TvShowsTableTableAnnotationComposer,
      $$TvShowsTableTableCreateCompanionBuilder,
      $$TvShowsTableTableUpdateCompanionBuilder,
      (
        TvShowsTableData,
        BaseReferences<_$AppDatabase, $TvShowsTableTable, TvShowsTableData>,
      ),
      TvShowsTableData,
      PrefetchHooks Function()
    >;
typedef $$CelebsTableTableCreateCompanionBuilder =
    CelebsTableCompanion Function({
      Value<int> id,
      required CelebritiesListModel popular,
      required CelebritiesListModel trending,
    });
typedef $$CelebsTableTableUpdateCompanionBuilder =
    CelebsTableCompanion Function({
      Value<int> id,
      Value<CelebritiesListModel> popular,
      Value<CelebritiesListModel> trending,
    });

class $$CelebsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CelebsTableTable> {
  $$CelebsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CelebritiesListModel,
    CelebritiesListModel,
    Uint8List
  >
  get popular => $composableBuilder(
    column: $table.popular,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CelebritiesListModel,
    CelebritiesListModel,
    Uint8List
  >
  get trending => $composableBuilder(
    column: $table.trending,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$CelebsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CelebsTableTable> {
  $$CelebsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get popular => $composableBuilder(
    column: $table.popular,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get trending => $composableBuilder(
    column: $table.trending,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CelebsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CelebsTableTable> {
  $$CelebsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CelebritiesListModel, Uint8List>
  get popular =>
      $composableBuilder(column: $table.popular, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CelebritiesListModel, Uint8List>
  get trending =>
      $composableBuilder(column: $table.trending, builder: (column) => column);
}

class $$CelebsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CelebsTableTable,
          CelebsTableData,
          $$CelebsTableTableFilterComposer,
          $$CelebsTableTableOrderingComposer,
          $$CelebsTableTableAnnotationComposer,
          $$CelebsTableTableCreateCompanionBuilder,
          $$CelebsTableTableUpdateCompanionBuilder,
          (
            CelebsTableData,
            BaseReferences<_$AppDatabase, $CelebsTableTable, CelebsTableData>,
          ),
          CelebsTableData,
          PrefetchHooks Function()
        > {
  $$CelebsTableTableTableManager(_$AppDatabase db, $CelebsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CelebsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CelebsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$CelebsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<CelebritiesListModel> popular = const Value.absent(),
                Value<CelebritiesListModel> trending = const Value.absent(),
              }) => CelebsTableCompanion(
                id: id,
                popular: popular,
                trending: trending,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required CelebritiesListModel popular,
                required CelebritiesListModel trending,
              }) => CelebsTableCompanion.insert(
                id: id,
                popular: popular,
                trending: trending,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CelebsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CelebsTableTable,
      CelebsTableData,
      $$CelebsTableTableFilterComposer,
      $$CelebsTableTableOrderingComposer,
      $$CelebsTableTableAnnotationComposer,
      $$CelebsTableTableCreateCompanionBuilder,
      $$CelebsTableTableUpdateCompanionBuilder,
      (
        CelebsTableData,
        BaseReferences<_$AppDatabase, $CelebsTableTable, CelebsTableData>,
      ),
      CelebsTableData,
      PrefetchHooks Function()
    >;
typedef $$TrendingSearchTableTableCreateCompanionBuilder =
    TrendingSearchTableCompanion Function({
      Value<int> id,
      required SearchesModel trendingSearch,
    });
typedef $$TrendingSearchTableTableUpdateCompanionBuilder =
    TrendingSearchTableCompanion Function({
      Value<int> id,
      Value<SearchesModel> trendingSearch,
    });

class $$TrendingSearchTableTableFilterComposer
    extends Composer<_$AppDatabase, $TrendingSearchTableTable> {
  $$TrendingSearchTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SearchesModel, SearchesModel, Uint8List>
  get trendingSearch => $composableBuilder(
    column: $table.trendingSearch,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$TrendingSearchTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TrendingSearchTableTable> {
  $$TrendingSearchTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get trendingSearch => $composableBuilder(
    column: $table.trendingSearch,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrendingSearchTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrendingSearchTableTable> {
  $$TrendingSearchTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SearchesModel, Uint8List>
  get trendingSearch => $composableBuilder(
    column: $table.trendingSearch,
    builder: (column) => column,
  );
}

class $$TrendingSearchTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrendingSearchTableTable,
          TrendingSearchTableData,
          $$TrendingSearchTableTableFilterComposer,
          $$TrendingSearchTableTableOrderingComposer,
          $$TrendingSearchTableTableAnnotationComposer,
          $$TrendingSearchTableTableCreateCompanionBuilder,
          $$TrendingSearchTableTableUpdateCompanionBuilder,
          (
            TrendingSearchTableData,
            BaseReferences<
              _$AppDatabase,
              $TrendingSearchTableTable,
              TrendingSearchTableData
            >,
          ),
          TrendingSearchTableData,
          PrefetchHooks Function()
        > {
  $$TrendingSearchTableTableTableManager(
    _$AppDatabase db,
    $TrendingSearchTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TrendingSearchTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$TrendingSearchTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$TrendingSearchTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<SearchesModel> trendingSearch = const Value.absent(),
              }) => TrendingSearchTableCompanion(
                id: id,
                trendingSearch: trendingSearch,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required SearchesModel trendingSearch,
              }) => TrendingSearchTableCompanion.insert(
                id: id,
                trendingSearch: trendingSearch,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrendingSearchTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrendingSearchTableTable,
      TrendingSearchTableData,
      $$TrendingSearchTableTableFilterComposer,
      $$TrendingSearchTableTableOrderingComposer,
      $$TrendingSearchTableTableAnnotationComposer,
      $$TrendingSearchTableTableCreateCompanionBuilder,
      $$TrendingSearchTableTableUpdateCompanionBuilder,
      (
        TrendingSearchTableData,
        BaseReferences<
          _$AppDatabase,
          $TrendingSearchTableTable,
          TrendingSearchTableData
        >,
      ),
      TrendingSearchTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AdsManagerTableTableTableManager get adsManagerTable =>
      $$AdsManagerTableTableTableManager(_db, _db.adsManagerTable);
  $$AccountDetailsTableTableTableManager get accountDetailsTable =>
      $$AccountDetailsTableTableTableManager(_db, _db.accountDetailsTable);
  $$MoviesTableTableTableManager get moviesTable =>
      $$MoviesTableTableTableManager(_db, _db.moviesTable);
  $$TvShowsTableTableTableManager get tvShowsTable =>
      $$TvShowsTableTableTableManager(_db, _db.tvShowsTable);
  $$CelebsTableTableTableManager get celebsTable =>
      $$CelebsTableTableTableManager(_db, _db.celebsTable);
  $$TrendingSearchTableTableTableManager get trendingSearchTable =>
      $$TrendingSearchTableTableTableManager(_db, _db.trendingSearchTable);
}
