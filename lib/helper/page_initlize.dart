
import 'package:get/get.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/details_controller.dart';
import 'package:gomechanic/controller/login_controller.dart';

class PageInit extends GetxController{
  final controller = Get.lazyPut<LoginController>(() => LoginController());
  final controller1 = Get.lazyPut<DetailsController>(() => DetailsController());

}