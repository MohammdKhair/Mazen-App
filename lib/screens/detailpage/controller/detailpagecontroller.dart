import 'package:get/get.dart';

abstract class DetailPageController extends GetxController {}

class DetailPageControllerImp extends DetailPageController {
  int id = 0;
  String date = "";
  int basisofthelawsuit = 0;
  String partiestothecase = "";
  String reasonforpostponement = "";
  String? x;

  @override
  void onInit() {
    id = Get.arguments["id"];
    date = Get.arguments["date"];
    basisofthelawsuit = Get.arguments["Basis_of_the_lawsuit"];
    partiestothecase = Get.arguments["parties_to_the_case"];
    reasonforpostponement = Get.arguments["reason_for_postponement"];
    x = Get.arguments["x"];
    super.onInit();
  }
}
