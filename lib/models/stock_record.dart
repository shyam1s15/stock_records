import 'package:json_annotation/json_annotation.dart';

part 'stock_record.g.dart';

@JsonSerializable()
class StockRecord {
  @JsonKey(name: '_id')
  final Id? id;

  @JsonKey(name: 'stock_symbol')
  final String? stockSymbol;

  @JsonKey(name: 'stock_name')
  final String? stockName;

  @JsonKey(name: 'price_date')
  final String? priceDate;

  @JsonKey(
      name: 'last_updated',
      fromJson: _dateTimeFromJson,
      toJson: _dateTimeToJson)
  final DateTime? lastUpdated;

  @JsonKey(name: 'current_price')
  final double? currentPrice;

  @JsonKey(name: 'previous_price')
  final double? previousPrice;

  @JsonKey(name: 'change_per')
  final double? changePer;

  final bool? accelerate;

  final int? volume;

  @JsonKey(name: 'target_price', fromJson: _stringToDoubleFromJson)
  double? targetPrice;

  @JsonKey(name: 'note')
  String? note;

  StockRecord(
      {this.id,
      this.stockSymbol,
      this.stockName,
      this.priceDate,
      this.lastUpdated,
      this.currentPrice,
      this.previousPrice,
      this.changePer,
      this.accelerate,
      this.volume,
      this.note,
      this.targetPrice});

  factory StockRecord.fromJson(Map<String, dynamic> json) =>
      _$StockRecordFromJson(json);
  Map<String, dynamic> toJson() => _$StockRecordToJson(this);

  static DateTime? _dateTimeFromJson(Map<String, dynamic>? json) {
    return json != null ? DateTime.parse(json[r'$date'] as String) : null;
  }

  static double? _stringToDoubleFromJson(String? targetPrice) {
    // final targetPrice = json?['target_price'] as String?;
    if (targetPrice != null) {
      return double.tryParse(targetPrice);
    } else {
      return null; // Handle null case
    }
  }

  static Map<String, dynamic>? _dateTimeToJson(DateTime? dateTime) =>
      dateTime != null
          ? {
              r'$date': dateTime.toIso8601String(),
            }
          : null;
}

@JsonSerializable()
class Id {
  @JsonKey(name: r'$oid')
  final String? oid;

  Id({this.oid});

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);
  Map<String, dynamic> toJson() => _$IdToJson(this);
}
