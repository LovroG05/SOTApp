import 'package:json_annotation/json_annotation.dart';

part 'Settings.model.g.dart';

@JsonSerializable()
class Settings {
  final List<String>? associations;
  final List<String>? bands;
  final bool? cw;
  final bool? ssb;
  final bool? fm;
  final bool? data;
  final bool? am;
  final bool? dv;
  final bool? other_modes;

  const Settings({
    required this.associations,
    required this.bands,
    required this.cw,
    required this.ssb,
    required this.fm,
    required this.data,
    required this.am,
    required this.dv,
    required this.other_modes
  });

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
}