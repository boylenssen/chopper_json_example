import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends JsonModel {
  int userId;
  int id;
  String title;
  String body;

  PostModel(this.userId, this.id, this.title, this.body);

  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

T fromJsonData<T>(Type type, String jsonData) {
  return JsonModel.create(T, json.decode(jsonData)) as T;
}

abstract class JsonModel {
  JsonModel();

  factory JsonModel.create(Type type, Map<String, dynamic> jsonMap) {
    switch (type) {
      case PostModel:
        return PostModel.fromJson(jsonMap);
    }
    return null;
  }
}


