// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overdue_task_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOverdueTaskEntityCollection on Isar {
  IsarCollection<OverdueTaskEntity> get overdueTaskEntitys => this.collection();
}

const OverdueTaskEntitySchema = CollectionSchema(
  name: r'OverdueTaskEntity',
  id: 7357903256675267214,
  properties: {
    r'overdueDate': PropertySchema(
      id: 0,
      name: r'overdueDate',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _overdueTaskEntityEstimateSize,
  serialize: _overdueTaskEntitySerialize,
  deserialize: _overdueTaskEntityDeserialize,
  deserializeProp: _overdueTaskEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'task': LinkSchema(
      id: -8239546061385913898,
      name: r'task',
      target: r'TaskEntity',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _overdueTaskEntityGetId,
  getLinks: _overdueTaskEntityGetLinks,
  attach: _overdueTaskEntityAttach,
  version: '3.1.0+1',
);

int _overdueTaskEntityEstimateSize(
  OverdueTaskEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _overdueTaskEntitySerialize(
  OverdueTaskEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.overdueDate);
}

OverdueTaskEntity _overdueTaskEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OverdueTaskEntity(
    overdueDate: reader.readDateTime(offsets[0]),
  );
  object.id = id;
  return object;
}

P _overdueTaskEntityDeserializeProp<P>(
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

Id _overdueTaskEntityGetId(OverdueTaskEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _overdueTaskEntityGetLinks(
    OverdueTaskEntity object) {
  return [object.task];
}

void _overdueTaskEntityAttach(
    IsarCollection<dynamic> col, Id id, OverdueTaskEntity object) {
  object.id = id;
  object.task.attach(col, col.isar.collection<TaskEntity>(), r'task', id);
}

extension OverdueTaskEntityQueryWhereSort
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QWhere> {
  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OverdueTaskEntityQueryWhere
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QWhereClause> {
  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterWhereClause>
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

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterWhereClause>
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

extension OverdueTaskEntityQueryFilter
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QFilterCondition> {
  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
      overdueDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overdueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
      overdueDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overdueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
      overdueDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overdueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
      overdueDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overdueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OverdueTaskEntityQueryObject
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QFilterCondition> {}

extension OverdueTaskEntityQueryLinks
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QFilterCondition> {
  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
      task(FilterQuery<TaskEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'task');
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterFilterCondition>
      taskIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'task', 0, true, 0, true);
    });
  }
}

extension OverdueTaskEntityQuerySortBy
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QSortBy> {
  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterSortBy>
      sortByOverdueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueDate', Sort.asc);
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterSortBy>
      sortByOverdueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueDate', Sort.desc);
    });
  }
}

extension OverdueTaskEntityQuerySortThenBy
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QSortThenBy> {
  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterSortBy>
      thenByOverdueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueDate', Sort.asc);
    });
  }

  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QAfterSortBy>
      thenByOverdueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueDate', Sort.desc);
    });
  }
}

extension OverdueTaskEntityQueryWhereDistinct
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QDistinct> {
  QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QDistinct>
      distinctByOverdueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overdueDate');
    });
  }
}

extension OverdueTaskEntityQueryProperty
    on QueryBuilder<OverdueTaskEntity, OverdueTaskEntity, QQueryProperty> {
  QueryBuilder<OverdueTaskEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OverdueTaskEntity, DateTime, QQueryOperations>
      overdueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overdueDate');
    });
  }
}
