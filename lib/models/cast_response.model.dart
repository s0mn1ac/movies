import 'dart:convert';

import 'package:movies/models/models.dart';

class CastResponseModel {

  CastResponseModel({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<CastModel> cast;
  List<CastModel> crew;

  factory CastResponseModel.fromJson(String str) => CastResponseModel.fromMap(json.decode(str));

  factory CastResponseModel.fromMap(Map<String, dynamic> json) => CastResponseModel(
    id: json["id"],
    cast: List<CastModel>.from(json["cast"].map((x) => CastModel.fromMap(x))),
    crew: List<CastModel>.from(json["crew"].map((x) => CastModel.fromMap(x))),
  );
}