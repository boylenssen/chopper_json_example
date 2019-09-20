import 'api/my_service.dart';

void main() async {
  final myService = MyService.create();

  final response = await myService.getResource("1");

  var post = response.body;
  print("title: ${post.title}");
}