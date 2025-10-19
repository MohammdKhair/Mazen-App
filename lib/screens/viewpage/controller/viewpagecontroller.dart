import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mazen/core/constant/app_route.dart';
import 'package:mazen/core/services/services.dart';
import 'package:mazen/data/static/sqldb.dart';

abstract class ViewPageController extends GetxController {
  gotoAddPage();
  gotoDetailPage(int i);
  gotoEditPage(int i);
  readDiary();
  deleteData(int i);
  void scrollToBottom();
  void scrollListner();
}

class ViewPageControllerImp extends ViewPageController {
  SqlDb sqlDb = SqlDb();
  MyServices myServices = Get.find();
  String? date;
  List diary = [];
  ScrollController scrollController = ScrollController();
  bool isFabVisible = true;

  @override
  gotoAddPage() {
    Get.toNamed(AppRoutes.add);
  }

  @override
  gotoDetailPage(int i) {
    Get.toNamed(AppRoutes.detail, arguments: {
      "id": diary[i]["id"],
      "date": diary[i]["date"],
      "Basis_of_the_lawsuit": diary[i]["Basis_of_the_lawsuit"],
      "parties_to_the_case": diary[i]["parties_to_the_case"],
      "next_session": diary[i]["next_session"],
      "reason_for_postponement": diary[i]["reason_for_postponement"],
      "x": "1",
    });
    update();
  }

  @override
  gotoEditPage(int i) {
    Get.toNamed(AppRoutes.edit, arguments: {
      "id": diary[i]["id"],
      "date": diary[i]["date"],
      "Basis_of_the_lawsuit": diary[i]["Basis_of_the_lawsuit"],
      "parties_to_the_case": diary[i]["parties_to_the_case"],
      "next_session": diary[i]["next_session"],
      "reason_for_postponement": diary[i]["reason_for_postponement"],
    });
    update();
  }

  @override
  Future readDiary() async {
    diary.clear();
    List<Map> response = await sqlDb.readData(
        "SELECT * FROM diary WHERE date = '${date.toString().split(" ")[0]}'");
    diary.addAll(response);
    update();
  }

  @override
  deleteData(int i) async {
    int response = await sqlDb
        .deleteData("DELETE FROM diary WHERE id = ${diary[i]['id']}");
    if (response > 0) {
      diary.removeWhere((element) => element['id'] == diary[i]['id']);
      update();
    }
  }

  @override
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent, // نهاية الليست
      duration: const Duration(milliseconds: 500), // مدة الأنيميشن
      curve: Curves.easeOut, // نوع الأنيميشن
    );
  }

  @override
  void scrollListner() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse ||
          scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        if (!isFabVisible) {
          isFabVisible = true;
          update();
        }
      }
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent) {
        if (isFabVisible) {
          isFabVisible = false;
          update();
        }
      }
    });
  }

  @override
  void onInit() {
    date = myServices.sharedPreferences.getString("selected_dat");
    readDiary();
    scrollListner();
    super.onInit();
  }
}
