import 'package:food_promise/app/shared/models/promise_model.dart';
import 'package:food_promise/app/shared/service/mocked_data.dart';
import 'package:meta/meta.dart';

class Repository {
  final client;

  Repository({@required this.client});

  Future<List<Promise>> getPromises() {
    return Future.delayed(Duration(seconds: 2),
        () => PROMISSES.map((p) => Promise.fromJson(p)).toList());
  }
}
