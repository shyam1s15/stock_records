// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_record_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRecordList _$StockRecordListFromJson(Map<String, dynamic> json) =>
    StockRecordList(
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => StockRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockRecordListToJson(StockRecordList instance) =>
    <String, dynamic>{
      'records': instance.records,
    };
