import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'GithubJob.g.dart';

@immutable
@JsonSerializable()
class GithubJob {
  final String id;
  final String type;
  final String url;

  @JsonKey(name: 'created_at')
  final String createdAt;

  final String company;

  @JsonKey(name: 'company_url')
  final String companyUrl;

  final String location;
  final String title;
  final String description;

  @JsonKey(name: 'how_to_apply')
  final String howToApply;

  @JsonKey(name: 'company_logo')
  final String companyLogo;

  const GithubJob({
    this.company,
    this.companyLogo,
    this.companyUrl,
    this.createdAt,
    this.description,
    this.howToApply,
    this.id,
    this.location,
    this.title,
    this.type,
    this.url,
  });

  Map<String, dynamic> toJson() => _$GithubJobToJson(this);

  factory GithubJob.fromJson(Map<String, dynamic> datamap) => _$GithubJobFromJson(datamap);
}
