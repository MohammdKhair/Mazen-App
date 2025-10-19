import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazen/core/constant/app_color.dart';
import 'package:mazen/screens/addpage/controller/addpagecontroller.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    AddPageControllerImp addPageControllerImp = Get.put(AddPageControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColors,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(child: GetBuilder<AddPageControllerImp>(builder: (controller) {
              return Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.end,
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
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.end,
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
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.end,
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
                    controller: controller.date,
                    readOnly: true,
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2060),
                          barrierColor: AppColors.primaryColors);
                      if (picked != null) {
                        addPageControllerImp.date.text =
                            picked.toString().split(" ")[0];
                      }
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
                          addPageControllerImp.addDiary();
                        },
                        height: 42,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.all(10),
                        minWidth: 150,
                        color: AppColors.primaryColors,
                        child: const Text(
                          "إضافة",
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
