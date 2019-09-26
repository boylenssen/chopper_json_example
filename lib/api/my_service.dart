import "dart:async";
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'models/post_model.dart';

part "my_service.chopper.dart";

@ChopperApi(baseUrl: "/posts")
abstract class MyService extends ChopperService {
  static MyService create() {
    final client = ChopperClient(
        baseUrl: "https://jsonplaceholder.typicode.com",
        services: [
          _$MyService()
        ],
        converter: JsonToTypeConverter({
            PostModel: (jsonData) => PostModel.fromJson(jsonData)
          }
        )
    );

    return _$MyService(client);
  }

  @Get(path: "{id}")
  Future<Response<PostModel>> getResource(@Path() String id);
}

class JsonToTypeConverter extends JsonConverter {

  final Map<Type, Function> typeToJsonFactoryMap;

  JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.replace(
      body: fromJsonData<BodyType, InnerType>(response.body, typeToJsonFactoryMap[InnerType]),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser(jsonMap);
  }
}

