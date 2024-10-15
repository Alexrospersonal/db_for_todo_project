// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repeated_task_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRepeatedTaskEntityCollection on Isar {
  IsarCollection<RepeatedTaskEntity> get repeatedTaskEntitys =>
      this.collection();
}

const RepeatedTaskEntitySchema = CollectionSchema(
  name: r'RepeatedTaskEntity',
  id: -6496382325375121872,
  properties: {
    r'endDateOfRepeatedly': PropertySchema(
      id: 0,
      name: r'endDateOfRepeatedly',
      type: IsarType.dateTime,
    ),
    r'isFinished': PropertySchema(
      id: 1,
      name: r'isFinished',
      type: IsarType.bool,
    ),
    r'repeatDuringDay': PropertySchema(
      id: 2,
      name: r'repeatDuringDay',
      type: IsarType.dateTimeList,
    ),
    r'repeatDuringWeek': PropertySchema(
      id: 3,
      name: r'repeatDuringWeek',
      type: IsarType.longList,
    )
  },
  estimateSize: _repeatedTaskEntityEstimateSize,
  serialize: _repeatedTaskEntitySerialize,
  deserialize: _repeatedTaskEntityDeserialize,
  deserializeProp: _repeatedTaskEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'endDateOfRepeatedly': IndexSchema(
      id: 5493750381249337925,
      name: r'endDateOfRepeatedly',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'endDateOfRepeatedly',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'task': LinkSchema(
      id: 3258881565764262616,
      name: r'task',
      target: r'TaskEntity',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _repeatedTaskEntityGetId,
  getLinks: _repeatedTaskEntityGetLinks,
  attach: _repeatedTaskEntityAttach,
  version: '3.1.0+1',
);

int _repeatedTaskEntityEstimateSize(
  RepeatedTaskEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.repeatDuringDay;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.repeatDuringWeek;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _repeatedTaskEntitySerialize(
  RepeatedTaskEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.endDateOfRepeatedly);
  writer.writeBool(offsets[1], object.isFinished);
  writer.writeDateTimeList(offsets[2], object.repeatDuringDay);
  writer.writeLongList(offsets[3], object.repeatDuringWeek);
}

RepeatedTaskEntity _repeatedTaskEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RepeatedTaskEntity();
  object.endDateOfRepeatedly = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.isFinished = reader.readBool(offsets[1]);
  object.repeatDuringDay = reader.readDateTimeOrNullList(offsets[2]);
  object.repeatDuringWeek = reader.readLongList(offsets[3]);
  return object;
}

P _repeatedTaskEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNullList(offset)) as P;
    case 3:
      return (reader.readLongList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _repeatedTaskEntityGetId(RepeatedTaskEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _repeatedTaskEntityGetLinks(
    RepeatedTaskEntity object) {
  return [object.task];
}

void _repeatedTaskEntityAttach(
    IsarCollection<dynamic> col, Id id, RepeatedTaskEntity object) {
  object.id = id;
  object.task.attach(col, col.isar.collection<TaskEntity>(), r'task', id);
}

extension RepeatedTaskEntityQueryWhereSort
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QWhere> {
  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhere>
      anyEndDateOfRepeatedly() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'endDateOfRepeatedly'),
      );
    });
  }
}

extension RepeatedTaskEntityQueryWhere
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QWhereClause> {
  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
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

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
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

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'endDateOfRepeatedly',
        value: [null],
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endDateOfRepeatedly',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyEqualTo(DateTime? endDateOfRepeatedly) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'endDateOfRepeatedly',
        value: [endDateOfRepeatedly],
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyNotEqualTo(DateTime? endDateOfRepeatedly) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endDateOfRepeatedly',
              lower: [],
              upper: [endDateOfRepeatedly],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endDateOfRepeatedly',
              lower: [endDateOfRepeatedly],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endDateOfRepeatedly',
              lower: [endDateOfRepeatedly],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endDateOfRepeatedly',
              lower: [],
              upper: [endDateOfRepeatedly],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyGreaterThan(
    DateTime? endDateOfRepeatedly, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endDateOfRepeatedly',
        lower: [endDateOfRepeatedly],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyLessThan(
    DateTime? endDateOfRepeatedly, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endDateOfRepeatedly',
        lower: [],
        upper: [endDateOfRepeatedly],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyBetween(
    DateTime? lowerEndDateOfRepeatedly,
    DateTime? upperEndDateOfRepeatedly, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endDateOfRepeatedly',
        lower: [lowerEndDateOfRepeatedly],
        includeLower: includeLower,
        upper: [upperEndDateOfRepeatedly],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension RepeatedTaskEntityQueryFilter
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QFilterCondition> {
  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDateOfRepeatedly',
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDateOfRepeatedly',
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDateOfRepeatedly',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDateOfRepeatedly',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDateOfRepeatedly',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDateOfRepeatedly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
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

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      isFinishedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayElementIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.elementIsNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayElementIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.elementIsNotNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayElementEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayElementGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayElementLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayElementBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatDuringDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringDayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'repeatDuringWeek',
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'repeatDuringWeek',
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatDuringWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatDuringWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatDuringWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatDuringWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      repeatDuringWeekLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension RepeatedTaskEntityQueryObject
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QFilterCondition> {}

extension RepeatedTaskEntityQueryLinks
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QFilterCondition> {
  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      task(FilterQuery<TaskEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'task');
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterFilterCondition>
      taskIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'task', 0, true, 0, true);
    });
  }
}

extension RepeatedTaskEntityQuerySortBy
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QSortBy> {
  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      sortByEndDateOfRepeatedly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateOfRepeatedly', Sort.asc);
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      sortByEndDateOfRepeatedlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateOfRepeatedly', Sort.desc);
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      sortByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.asc);
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      sortByIsFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.desc);
    });
  }
}

extension RepeatedTaskEntityQuerySortThenBy
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QSortThenBy> {
  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      thenByEndDateOfRepeatedly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateOfRepeatedly', Sort.asc);
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      thenByEndDateOfRepeatedlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateOfRepeatedly', Sort.desc);
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      thenByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.asc);
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QAfterSortBy>
      thenByIsFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.desc);
    });
  }
}

extension RepeatedTaskEntityQueryWhereDistinct
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QDistinct> {
  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QDistinct>
      distinctByEndDateOfRepeatedly() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDateOfRepeatedly');
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QDistinct>
      distinctByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFinished');
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QDistinct>
      distinctByRepeatDuringDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatDuringDay');
    });
  }

  QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QDistinct>
      distinctByRepeatDuringWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatDuringWeek');
    });
  }
}

extension RepeatedTaskEntityQueryProperty
    on QueryBuilder<RepeatedTaskEntity, RepeatedTaskEntity, QQueryProperty> {
  QueryBuilder<RepeatedTaskEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RepeatedTaskEntity, DateTime?, QQueryOperations>
      endDateOfRepeatedlyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDateOfRepeatedly');
    });
  }

  QueryBuilder<RepeatedTaskEntity, bool, QQueryOperations>
      isFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFinished');
    });
  }

  QueryBuilder<RepeatedTaskEntity, List<DateTime?>?, QQueryOperations>
      repeatDuringDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatDuringDay');
    });
  }

  QueryBuilder<RepeatedTaskEntity, List<int>?, QQueryOperations>
      repeatDuringWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatDuringWeek');
    });
  }
}
