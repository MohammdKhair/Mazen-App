import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mazen/core/services/services.dart';
import 'package:mazen/data/static/sqldb.dart';
import 'package:mazen/screens/alldatapage/controller/alldatapagecontroller.dart';

abstract class AddPageController extends GetxController {
  addDiary();
}

class AddPageControllerImp extends AddPageController {
  MyServices myServices = Get.find();
  String? selectedDate;
  SqlDb sqlDb = SqlDb();
  AllDataPageControllerImp allDataPageControllerImp =
      Get.put(AllDataPageControllerImp());
  TextEditingController date = TextEditingController();
  TextEditingController basisofthelawsuit = TextEditingController();
  TextEditingController partiestothecase = TextEditingController();
  TextEditingController reasonforpostponement = TextEditingController();

  @override
  addDiary() async {
    int response = await sqlDb.insertData('''
     INSERT INTO diary('date','Basis_of_the_lawsuit','parties_to_the_case','reason_for_postponement')
     VALUES ("${date.text}",
      ${basisofthelawsuit.text},
     "${partiestothecase.text}",
     "${reasonforpostponement.text}"
     )
     ''');
    if (response > 0) {
      Get.back(result: allDataPageControllerImp.readAllDiary());
    }
  }

  @override
  void onInit() {
    selectedDate = myServices.sharedPreferences.getString("selected_dat");
    super.onInit();
  }

  @override
  void onClose() {
    date.clear();
    basisofthelawsuit.clear();
    partiestothecase.clear();
    reasonforpostponement.clear();
    super.onClose();
  }
}
