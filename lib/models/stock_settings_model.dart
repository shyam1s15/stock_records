import 'package:json_annotation/json_annotation.dart';
import 'package:stock_records/models/stock_settings.dart';

part 'stock_settings_model.g.dart';

@JsonSerializable()
class StockRecordModel {
  @JsonKey(name: 'settings')
  final StockSettings? settings;

  StockRecordModel({this.settings});

  factory StockRecordModel.fromJson(Map<String, dynamic> json) => _$StockRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockRecordModelToJson(this);

}
