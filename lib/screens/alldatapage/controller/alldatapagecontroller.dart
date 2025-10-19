// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mazen/core/constant/app_route.dart';
import 'package:mazen/data/static/sqldb.dart';

abstract class AllDataPageController extends GetxController {
  gotoAddPage();
  gotoDetailPage(int i);
  gotoEditPage(int i);
  readAllDiary();
  deleteData(int i);
  scrollToBottom();
  void scrollListner();
}

class AllDataPageControllerImp extends AllDataPageController {
  SqlDb sqlDb = SqlDb();
  String? date;
  List alldiary = [];
  ScrollController scrollController = ScrollController();
  bool isFabVisible = true;

  @override
  gotoAddPage() {
    Get.toNamed(AppRoutes.add);
  }

  @override
  gotoDetailPage(int i) {
    Get.toNamed(AppRoutes.detail, arguments: {
      "id": alldiary[i]["id"],
      "date": alldiary[i]["date"],
      "Basis_of_the_lawsuit": alldiary[i]["Basis_of_the_lawsuit"],
      "parties_to_the_case": alldiary[i]["parties_to_the_case"],
      "next_session": alldiary[i]["next_session"],
      "reason_for_postponement": alldiary[i]["reason_for_postponement"],
      "x": "2",
    });
    update();
  }

  @override
  gotoEditPage(int i) {
    Get.toNamed(AppRoutes.edit, arguments: {
      "id": alldiary[i]["id"],
      "date": alldiary[i]["date"],
      "Basis_of_the_lawsuit": alldiary[i]["Basis_of_the_lawsuit"],
      "parties_to_the_case": alldiary[i]["parties_to_the_case"],
      "next_session": alldiary[i]["next_session"],
      "reason_for_postponement": alldiary[i]["reason_for_postponement"],
    });
    update();
  }

  @override
  Future readAllDiary() async {
    alldiary.clear();
    List<Map> response = await sqlDb
        .readData("SELECT * FROM diary ORDER BY Basis_of_the_lawsuit");
    alldiary.addAll(response);
    update();
  }

  @override
  deleteData(int i) async {
    int response = await sqlDb
        .deleteData("DELETE FROM diary WHERE id = ${alldiary[i]['id']}");
    if (response > 0) {
      alldiary.removeWhere((element) => element['id'] == alldiary[i]['id']);
      update();
    }
  }

  @override
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent, // نهاية الليست
      duration: const Duration(milliseconds: 500), // مدة الأنيميشن
      curve: Curves.easeOut,
    );
    isFabVisible = false;
    update();
    print(
        "========================${scrollController.position.maxScrollExtent}");
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
    readAllDiary();
    scrollListner();
    super.onInit();
  }
}
