import 'package:json_annotation/json_annotation.dart';

part 'stock_settings.g.dart';

@JsonSerializable()
class StockSettings {
  @JsonKey(name: 'last_page_id')
  final int? lastPageId;

  StockSettings({this.lastPageId});

  
  factory StockSettings.fromJson(Map<String, dynamic> json) =>
      _$StockSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$StockSettingsToJson(this);

}
