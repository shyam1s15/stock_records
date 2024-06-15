// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockRecord _$StockRecordFromJson(Map<String, dynamic> json) => StockRecord(
      id: json['_id'] == null
          ? null
          : Id.fromJson(json['_id'] as Map<String, dynamic>),
      stockSymbol: json['stock_symbol'] as String?,
      stockName: json['stock_name'] as String?,
      priceDate: json['price_date'] as String?,
      lastUpdated: StockRecord._dateTimeFromJson(
          json['last_updated'] as Map<String, dynamic>?),
      currentPrice: (json['current_price'] as num?)?.toDouble(),
      previousPrice: (json['previous_price'] as num?)?.toDouble(),
      changePer: (json['change_per'] as num?)?.toDouble(),
      accelerate: json['accelerate'] as bool?,
      volume: (json['volume'] as num?)?.toInt(),
      note: json['note'] as String?,
      targetPrice: (json['target_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StockRecordToJson(StockRecord instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'stock_symbol': instance.stockSymbol,
      'stock_name': instance.stockName,
      'price_date': instance.priceDate,
      'last_updated': StockRecord._dateTimeToJson(instance.lastUpdated),
      'current_price': instance.currentPrice,
      'previous_price': instance.previousPrice,
      'change_per': instance.changePer,
      'accelerate': instance.accelerate,
      'volume': instance.volume,
      'target_price': instance.targetPrice,
      'note': instance.note,
    };

Id _$IdFromJson(Map<String, dynamic> json) => Id(
      oid: json[r'$oid'] as String?,
    );

Map<String, dynamic> _$IdToJson(Id instance) => <String, dynamic>{
      r'$oid': instance.oid,
    };
