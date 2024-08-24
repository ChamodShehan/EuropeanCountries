// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      capital:
          (json['capital'] as List<dynamic>).map((e) => e as String).toList(),
      flags: Flags.fromJson(json['flags'] as Map<String, dynamic>),
      region: json['region'] as String,
      languages: Map<String, String>.from(json['languages'] as Map),
      population: (json['population'] as num).toInt(),
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'capital': instance.capital,
      'flags': instance.flags,
      'region': instance.region,
      'languages': instance.languages,
      'population': instance.population,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      common: json['common'] as String,
      official: json['official'] as String,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'common': instance.common,
      'official': instance.official,
    };

Flags _$FlagsFromJson(Map<String, dynamic> json) => Flags(
      png: json['png'] as String,
      svg: json['svg'] as String,
      alt: json['alt'] as String,
    );

Map<String, dynamic> _$FlagsToJson(Flags instance) => <String, dynamic>{
      'png': instance.png,
      'svg': instance.svg,
      'alt': instance.alt,
    };
