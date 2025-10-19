import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:mazen/core/constant/app_color.dart';
import 'package:mazen/screens/viewpage/controller/viewpagecontroller.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    ViewPageControllerImp viewPageControllerImp =
        Get.put(ViewPageControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${viewPageControllerImp.date}",
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColors,
      ),
      floatingActionButton:
          GetBuilder<ViewPageControllerImp>(builder: (controller) {
        return AnimatedSlide(
          offset:
              controller.isFabVisible ? const Offset(0, 0) : const Offset(0, 2),
          duration: const Duration(milliseconds: 300),
          child: AnimatedOpacity(
            opacity: controller.isFabVisible ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: FloatingActionButton(
                shape: const CircleBorder(),
                mini: true,
                backgroundColor: AppColors.primaryColors,
                child: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.scrollToBottom();
                }),
          ),
        );
      }),
      body: GetBuilder<ViewPageControllerImp>(builder: (controller) {
        return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.diary.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.gotoDetailPage(i);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Center(
                                  child: FittedBox(
                                child: Text(
                                  '${i + 1} )',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                              ))),
                          Expanded(
                            flex: 10,
                            child: ListTile(
                              title: Text(
                                controller.diary[i]['parties_to_the_case'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "${controller.diary[i]['Basis_of_the_lawsuit']}",
                                style: const TextStyle(color: Colors.black),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.gotoEditPage(i);
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.warning,
                                                animType: AnimType.rightSlide,
                                                title: 'delete',
                                                desc: 'هل تريد الحذف ؟',
                                                btnOkOnPress: () {
                                                  controller.deleteData(i);
                                                  controller.readDiary();
                                                },
                                                btnOkText: 'نعم',
                                                btnCancelOnPress: () {
                                                  controller.readDiary();
                                                },
                                                btnCancelText: 'لا')
                                            .show();
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  )
                ],
              );
            });
      }),
    );
  }
}
