// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Settings.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) => Settings(
      associations: (json['associations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bands:
          (json['bands'] as List<dynamic>?)?.map((e) => e as String).toList(),
      cw: json['cw'] as bool?,
      ssb: json['ssb'] as bool?,
      fm: json['fm'] as bool?,
      data: json['data'] as bool?,
      am: json['am'] as bool?,
      dv: json['dv'] as bool?,
      other_modes: json['other_modes'] as bool?,
    );

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'associations': instance.associations,
      'bands': instance.bands,
      'cw': instance.cw,
      'ssb': instance.ssb,
      'fm': instance.fm,
      'data': instance.data,
      'am': instance.am,
      'dv': instance.dv,
      'other_modes': instance.other_modes,
    };
