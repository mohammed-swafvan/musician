import 'package:json_annotation/json_annotation.dart';
part 'lyrics.g.dart';

@JsonSerializable()
class Lyrics {
  @JsonKey(name: 'lyrics_id')
  int? lyricsId;
  int? restricted;
  int? instrumental;
  @JsonKey(name: 'lyrics_body')
  String? lyricsBody;
  @JsonKey(name: 'lyrics_language')
  String? lyricsLanguage;
  @JsonKey(name: 'script_tracking_url')
  String? scriptTrackingUrl;
  @JsonKey(name: 'pixel_tracking_url')
  String? pixelTrackingUrl;
  @JsonKey(name: 'html_tracking_url')
  String? htmlTrackingUrl;
  @JsonKey(name: 'lyrics_copyright')
  String? lyricsCopyright;
  @JsonKey(name: 'updated_time')
  String? updatedTime;

  Lyrics({
    this.lyricsId,
    this.restricted,
    this.instrumental,
    this.lyricsBody,
    this.lyricsLanguage,
    this.scriptTrackingUrl,
    this.pixelTrackingUrl,
    this.htmlTrackingUrl,
    this.lyricsCopyright,
    this.updatedTime,
  });

  factory Lyrics.fromJson(Map<String, dynamic> json) {
    return _$LyricsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsToJson(this);
}