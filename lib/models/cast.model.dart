import 'dart:convert';

class CastModel {

  CastModel({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
              this.profilePath,
              this.castId,
              this.character,
    required this.creditId,
              this.order,
              this.department,
              this.job,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  String? department;
  String? job;

  get fullProfilePath {
    return this.profilePath != null ? 'https://image.tmdb.org/t/p/w500${this.profilePath}' : 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory CastModel.fromJson(String str) => CastModel.fromMap(json.decode(str));

  factory CastModel.fromMap(Map<String, dynamic> json) => CastModel(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"].toString(),
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"].toDouble(),
    profilePath: json["profile_path"] == null ? null : json["profile_path"],
    castId: json["cast_id"] == null ? null : json["cast_id"],
    character: json["character"] == null ? null : json["character"],
    creditId: json["credit_id"],
    order: json["order"] == null ? null : json["order"],
    department: json["department"] == null ? null : json["department"].toString(),
    job: json["job"] == null ? null : json["job"],
  );
}