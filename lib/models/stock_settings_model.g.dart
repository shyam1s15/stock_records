// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRecordModel _$StockRecordModelFromJson(Map<String, dynamic> json) =>
    StockRecordModel(
      settings: json['settings'] == null
          ? null
          : StockSettings.fromJson(json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockRecordModelToJson(StockRecordModel instance) =>
    <String, dynamic>{
      'settings': instance.settings,
    };
