import 'package:food_promise/app/shared/models/promise_model.dart';
import 'package:food_promise/app/shared/service/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final loading = false.obs;
  final Repository _repository = Get.find();

  final promises = <Promise>[].obs;

  @override
  onInit() {
    print("---> on init <---");
    loadPromises();
  }

  loadPromises() async {
    loading.value = true;

    _repository.getPromises().then((list) {
      promises.clear();
      promises.addAll(list);
      loading.value = false;
    });
  }
}
