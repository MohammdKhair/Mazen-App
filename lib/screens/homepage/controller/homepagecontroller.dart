// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:mazen/core/constant/app_route.dart';
import 'package:mazen/core/services/services.dart';
import 'package:mazen/data/static/sqldb.dart';

abstract class HomePageController extends GetxController {
  gotoViewPage();
  gotoAllDataPage();
}

class HomePageControllerImp extends HomePageController {
  SqlDb sqlDb = SqlDb();
  MyServices myServices = Get.find();
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  gotoViewPage() {
    Get.toNamed(AppRoutes.view);
    myServices.sharedPreferences
        .setString("selected_dat", selectedDay.toString().split(" ")[0]);
  }

  @override
  gotoAllDataPage() {
    Get.toNamed(AppRoutes.alldata);
  }
}
