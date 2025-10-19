import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazen/data/static/sqldb.dart';
import 'package:mazen/screens/alldatapage/controller/alldatapagecontroller.dart';
import 'package:mazen/screens/viewpage/controller/viewpagecontroller.dart';

abstract class EditPageController extends GetxController {
  editDiary();
}

class EditPageControllerImp extends EditPageController {
  SqlDb sqlDb = SqlDb();
  int id = 0;
  ViewPageControllerImp viewPageControllerImp =
      Get.put(ViewPageControllerImp());
  AllDataPageControllerImp allDataPageControllerImp = Get.put(AllDataPageControllerImp());
  TextEditingController date = TextEditingController();
  TextEditingController basisofthelawsuit = TextEditingController();
  TextEditingController partiestothecase = TextEditingController();
  TextEditingController reasonforpostponement = TextEditingController();

  @override
  editDiary() async {
    int response = await sqlDb.updateData('''
             UPDATE  diary SET 
             date = "${date.text}",
             Basis_of_the_lawsuit = ${basisofthelawsuit.text},
             parties_to_the_case = "${partiestothecase.text}",
             reason_for_postponement = "${reasonforpostponement.text}"
             WHERE id = $id
             ''');
    if (response > 0) {
      Get.back(result: [
        viewPageControllerImp.readDiary(),
        allDataPageControllerImp.readAllDiary()
      ]);
    }
  }

  @override
  void onInit() {
    id = Get.arguments["id"];
    date.text = Get.arguments["date"].toString();
    basisofthelawsuit.text = Get.arguments["Basis_of_the_lawsuit"].toString();
    partiestothecase.text = Get.arguments["parties_to_the_case"].toString();
    reasonforpostponement.text =
        Get.arguments["reason_for_postponement"].toString();
    super.onInit();
  }
}
