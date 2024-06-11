import 'package:json_annotation/json_annotation.dart';
import 'package:stock_records/models/stock_record.dart';

part 'stock_record_list.g.dart';

@JsonSerializable()
class StockRecordList {
  @JsonKey(name: 'records')
  final List<StockRecord>? records;

  StockRecordList({this.records});

  factory StockRecordList.fromJson(Map<String, dynamic> json) => _$StockRecordListFromJson(json);
  Map<String, dynamic> toJson() => _$StockRecordListToJson(this);
}