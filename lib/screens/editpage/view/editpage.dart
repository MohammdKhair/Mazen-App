import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazen/core/constant/app_color.dart';
import 'package:mazen/screens/editpage/controller/editpagecontroller.dart';

class Editpage extends StatelessWidget {
  const Editpage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EditPageControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColors,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
                child: GetBuilder<EditPageControllerImp>(builder: (controller) {
              return Column(
                children: [
                  TextFormField(
                    textAlign: TextAlign.end,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: controller.basisofthelawsuit,
                    decoration: const InputDecoration(
                        labelText: 'اساس الدعوى',
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textAlign: TextAlign.end,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller: controller.partiestothecase,
                    decoration: const InputDecoration(
                        labelText: 'أطراف الدعوى',
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textAlign: TextAlign.end,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller: controller.reasonforpostponement,
                    decoration: const InputDecoration(
                        labelText: 'سبب التأجيل',
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.datetime,
                    controller: controller.date,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2030),
                          barrierColor: AppColors.primaryColors);
                      if (picked != null) {
                        controller.date.text = picked.toString().split(" ")[0];
                      } else {}
                    },
                    decoration: const InputDecoration(
                        labelText: 'الجلسة القادمة',
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: MaterialButton(
                        onPressed: () {
                          controller.editDiary();
                        },
                        height: 42,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(10),
                        minWidth: 150,
                        color: AppColors.primaryColors,
                        child: const Text(
                          "حفظ",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ))
                ],
              );
            }))
          ],
        ),
      ),
    );
  }
}
