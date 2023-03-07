// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lyrics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lyrics _$LyricsFromJson(Map<String, dynamic> json) => Lyrics(
      lyricsId: json['lyrics_id'] as int?,
      restricted: json['restricted'] as int?,
      instrumental: json['instrumental'] as int?,
      lyricsBody: json['lyrics_body'] as String?,
      lyricsLanguage: json['lyrics_language'] as String?,
      scriptTrackingUrl: json['script_tracking_url'] as String?,
      pixelTrackingUrl: json['pixel_tracking_url'] as String?,
      htmlTrackingUrl: json['html_tracking_url'] as String?,
      lyricsCopyright: json['lyrics_copyright'] as String?,
      updatedTime: json['updated_time'] as String?,
    );

Map<String, dynamic> _$LyricsToJson(Lyrics instance) => <String, dynamic>{
      'lyrics_id': instance.lyricsId,
      'restricted': instance.restricted,
      'instrumental': instance.instrumental,
      'lyrics_body': instance.lyricsBody,
      'lyrics_language': instance.lyricsLanguage,
      'script_tracking_url': instance.scriptTrackingUrl,
      'pixel_tracking_url': instance.pixelTrackingUrl,
      'html_tracking_url': instance.htmlTrackingUrl,
      'lyrics_copyright': instance.lyricsCopyright,
      'updated_time': instance.updatedTime,
    };
