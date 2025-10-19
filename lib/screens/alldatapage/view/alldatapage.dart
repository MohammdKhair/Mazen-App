import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazen/core/constant/app_color.dart';
import 'package:mazen/screens/alldatapage/controller/alldatapagecontroller.dart';
import 'package:mazen/screens/widgets/search.dart';

class AllDataPage extends StatelessWidget {
  const AllDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    AllDataPageControllerImp allDataPageControllerImp =
        Get.put(AllDataPageControllerImp());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(
                Icons.search,
                size: 35,
                color: Colors.white,
              ),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              })
        ],
        title: const Text(
          "كل الدعاوي",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColors,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 40),
          FloatingActionButton(
            heroTag: "tag1",
            backgroundColor: AppColors.primaryColors,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              allDataPageControllerImp.gotoAddPage();
            },
          ),
          const Spacer(),
          GetBuilder<AllDataPageControllerImp>(builder: (controller) {
            return AnimatedSlide(
              offset: controller.isFabVisible
                  ? const Offset(0, 0)
                  : const Offset(0, 2),
              duration: const Duration(milliseconds: 300),
              child: AnimatedOpacity(
                opacity: controller.isFabVisible ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: FloatingActionButton(
                  shape: const CircleBorder(),
                    heroTag: "tag2",
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
        ],
      ),
      body: GetBuilder<AllDataPageControllerImp>(builder: (controller) {
        return ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.alldiary.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      controller.gotoDetailPage(i);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15),
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
                                  controller.alldiary[i]['parties_to_the_case'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${controller.alldiary[i]['Basis_of_the_lawsuit']}",
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "${controller.alldiary[i]['date']}",
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ],
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
                                                  dialogType:
                                                      DialogType.warning,
                                                  animType: AnimType.rightSlide,
                                                  title: 'delete',
                                                  desc: 'هل تريد الحذف ؟',
                                                  btnOkOnPress: () {
                                                    controller.deleteData(i);
                                                    controller.readAllDiary();
                                                  },
                                                  btnOkText: 'نعم',
                                                  btnCancelOnPress: () {
                                                    controller.readAllDiary();
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
                        )),
                  ),
                  controller.alldiary.length - 1 != i
                      ? const Divider(
                          color: Colors.black,
                        )
                      : const Column(
                          children: [
                            Divider(
                              color: Colors.black,
                            ),
                            SizedBox(height: 45),
                          ],
                        )
                ],
              );
            });
      }),
    );
  }
}
