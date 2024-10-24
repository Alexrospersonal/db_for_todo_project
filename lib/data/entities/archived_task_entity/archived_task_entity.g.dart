// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archived_task_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetArchivedTaskEntityCollection on Isar {
  IsarCollection<ArchivedTaskEntity> get archivedTaskEntitys =>
      this.collection();
}

const ArchivedTaskEntitySchema = CollectionSchema(
  name: r'ArchivedTaskEntity',
  id: -565678993477938737,
  properties: {
    r'finishedDate': PropertySchema(
      id: 0,
      name: r'finishedDate',
      type: IsarType.dateTime,
    ),
    r'isFinished': PropertySchema(
      id: 1,
      name: r'isFinished',
      type: IsarType.bool,
    ),
    r'originalId': PropertySchema(
      id: 2,
      name: r'originalId',
      type: IsarType.long,
    ),
    r'taskData': PropertySchema(
      id: 3,
      name: r'taskData',
      type: IsarType.string,
    )
  },
  estimateSize: _archivedTaskEntityEstimateSize,
  serialize: _archivedTaskEntitySerialize,
  deserialize: _archivedTaskEntityDeserialize,
  deserializeProp: _archivedTaskEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _archivedTaskEntityGetId,
  getLinks: _archivedTaskEntityGetLinks,
  attach: _archivedTaskEntityAttach,
  version: '3.1.0+1',
);

int _archivedTaskEntityEstimateSize(
  ArchivedTaskEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.taskData.length * 3;
  return bytesCount;
}

void _archivedTaskEntitySerialize(
  ArchivedTaskEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.finishedDate);
  writer.writeBool(offsets[1], object.isFinished);
  writer.writeLong(offsets[2], object.originalId);
  writer.writeString(offsets[3], object.taskData);
}

ArchivedTaskEntity _archivedTaskEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ArchivedTaskEntity(
    finishedDate: reader.readDateTime(offsets[0]),
    isFinished: reader.readBool(offsets[1]),
    originalId: reader.readLong(offsets[2]),
    taskData: reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _archivedTaskEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _archivedTaskEntityGetId(ArchivedTaskEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _archivedTaskEntityGetLinks(
    ArchivedTaskEntity object) {
  return [];
}

void _archivedTaskEntityAttach(
    IsarCollection<dynamic> col, Id id, ArchivedTaskEntity object) {
  object.id = id;
}

extension ArchivedTaskEntityQueryWhereSort
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QWhere> {
  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ArchivedTaskEntityQueryWhere
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QWhereClause> {
  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ArchivedTaskEntityQueryFilter
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QFilterCondition> {
  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      finishedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      finishedDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finishedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      finishedDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finishedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      finishedDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finishedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      isFinishedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      originalIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'originalId',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      originalIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'originalId',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      originalIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'originalId',
        value: value,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      originalIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'originalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'taskData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'taskData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'taskData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'taskData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskData',
        value: '',
      ));
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterFilterCondition>
      taskDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'taskData',
        value: '',
      ));
    });
  }
}

extension ArchivedTaskEntityQueryObject
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QFilterCondition> {}

extension ArchivedTaskEntityQueryLinks
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QFilterCondition> {}

extension ArchivedTaskEntityQuerySortBy
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QSortBy> {
  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      sortByFinishedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedDate', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      sortByFinishedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedDate', Sort.desc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      sortByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      sortByIsFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.desc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      sortByOriginalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalId', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      sortByOriginalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalId', Sort.desc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      sortByTaskData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskData', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      sortByTaskDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskData', Sort.desc);
    });
  }
}

extension ArchivedTaskEntityQuerySortThenBy
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QSortThenBy> {
  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByFinishedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedDate', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByFinishedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedDate', Sort.desc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByIsFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.desc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByOriginalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalId', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByOriginalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'originalId', Sort.desc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByTaskData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskData', Sort.asc);
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QAfterSortBy>
      thenByTaskDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskData', Sort.desc);
    });
  }
}

extension ArchivedTaskEntityQueryWhereDistinct
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QDistinct> {
  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QDistinct>
      distinctByFinishedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishedDate');
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QDistinct>
      distinctByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFinished');
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QDistinct>
      distinctByOriginalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'originalId');
    });
  }

  QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QDistinct>
      distinctByTaskData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskData', caseSensitive: caseSensitive);
    });
  }
}

extension ArchivedTaskEntityQueryProperty
    on QueryBuilder<ArchivedTaskEntity, ArchivedTaskEntity, QQueryProperty> {
  QueryBuilder<ArchivedTaskEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ArchivedTaskEntity, DateTime, QQueryOperations>
      finishedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishedDate');
    });
  }

  QueryBuilder<ArchivedTaskEntity, bool, QQueryOperations>
      isFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFinished');
    });
  }

  QueryBuilder<ArchivedTaskEntity, int, QQueryOperations> originalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'originalId');
    });
  }

  QueryBuilder<ArchivedTaskEntity, String, QQueryOperations>
      taskDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskData');
    });
  }
}
