// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finished_task_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFinishedTaskEntityCollection on Isar {
  IsarCollection<FinishedTaskEntity> get finishedTaskEntitys =>
      this.collection();
}

const FinishedTaskEntitySchema = CollectionSchema(
  name: r'FinishedTaskEntity',
  id: -6966951470965567673,
  properties: {
    r'finishedDate': PropertySchema(
      id: 0,
      name: r'finishedDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _finishedTaskEntityEstimateSize,
  serialize: _finishedTaskEntitySerialize,
  deserialize: _finishedTaskEntityDeserialize,
  deserializeProp: _finishedTaskEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'finishedDate': IndexSchema(
      id: -3104272787227336693,
      name: r'finishedDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'finishedDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'task': LinkSchema(
      id: -3123910574021622402,
      name: r'task',
      target: r'TaskEntity',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _finishedTaskEntityGetId,
  getLinks: _finishedTaskEntityGetLinks,
  attach: _finishedTaskEntityAttach,
  version: '3.1.0+1',
);

int _finishedTaskEntityEstimateSize(
  FinishedTaskEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _finishedTaskEntitySerialize(
  FinishedTaskEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.finishedDate);
}

FinishedTaskEntity _finishedTaskEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FinishedTaskEntity(
    finishedDate: reader.readDateTime(offsets[0]),
  );
  object.id = id;
  return object;
}

P _finishedTaskEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _finishedTaskEntityGetId(FinishedTaskEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _finishedTaskEntityGetLinks(
    FinishedTaskEntity object) {
  return [object.task];
}

void _finishedTaskEntityAttach(
    IsarCollection<dynamic> col, Id id, FinishedTaskEntity object) {
  object.id = id;
  object.task.attach(col, col.isar.collection<TaskEntity>(), r'task', id);
}

extension FinishedTaskEntityQueryWhereSort
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QWhere> {
  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhere>
      anyFinishedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'finishedDate'),
      );
    });
  }
}

extension FinishedTaskEntityQueryWhere
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QWhereClause> {
  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
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

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
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

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
      finishedDateEqualTo(DateTime finishedDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'finishedDate',
        value: [finishedDate],
      ));
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
      finishedDateNotEqualTo(DateTime finishedDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'finishedDate',
              lower: [],
              upper: [finishedDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'finishedDate',
              lower: [finishedDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'finishedDate',
              lower: [finishedDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'finishedDate',
              lower: [],
              upper: [finishedDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
      finishedDateGreaterThan(
    DateTime finishedDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'finishedDate',
        lower: [finishedDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
      finishedDateLessThan(
    DateTime finishedDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'finishedDate',
        lower: [],
        upper: [finishedDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterWhereClause>
      finishedDateBetween(
    DateTime lowerFinishedDate,
    DateTime upperFinishedDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'finishedDate',
        lower: [lowerFinishedDate],
        includeLower: includeLower,
        upper: [upperFinishedDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FinishedTaskEntityQueryFilter
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QFilterCondition> {
  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
      finishedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finishedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
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
}

extension FinishedTaskEntityQueryObject
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QFilterCondition> {}

extension FinishedTaskEntityQueryLinks
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QFilterCondition> {
  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
      task(FilterQuery<TaskEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'task');
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterFilterCondition>
      taskIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'task', 0, true, 0, true);
    });
  }
}

extension FinishedTaskEntityQuerySortBy
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QSortBy> {
  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterSortBy>
      sortByFinishedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedDate', Sort.asc);
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterSortBy>
      sortByFinishedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedDate', Sort.desc);
    });
  }
}

extension FinishedTaskEntityQuerySortThenBy
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QSortThenBy> {
  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterSortBy>
      thenByFinishedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedDate', Sort.asc);
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterSortBy>
      thenByFinishedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finishedDate', Sort.desc);
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension FinishedTaskEntityQueryWhereDistinct
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QDistinct> {
  QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QDistinct>
      distinctByFinishedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finishedDate');
    });
  }
}

extension FinishedTaskEntityQueryProperty
    on QueryBuilder<FinishedTaskEntity, FinishedTaskEntity, QQueryProperty> {
  QueryBuilder<FinishedTaskEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FinishedTaskEntity, DateTime, QQueryOperations>
      finishedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finishedDate');
    });
  }
}
