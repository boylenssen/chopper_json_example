import "dart:async";

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
        converter: MyConverter()
    );

    return _$MyService(client);
  }

  @Get(path: "{id}")
  Future<Response<PostModel>> getResource(@Path() String id);
}

class MyConverter extends JsonConverter {

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.replace(
      body: fromJsonData<BodyType>(BodyType, response.body),
    );
  }

}