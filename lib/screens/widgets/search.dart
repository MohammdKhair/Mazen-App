import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:mazen/screens/alldatapage/controller/alldatapagecontroller.dart';

class DataSearch extends SearchDelegate {
  AllDataPageControllerImp controller = Get.put(AllDataPageControllerImp());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("data");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      List filterdiary = controller.alldiary
        .where((element) => element['parties_to_the_case'].startsWith(query))
        .toList();
    return GetBuilder<AllDataPageControllerImp>(builder: (controller) {
      return query == ""
          ? const Center(
              child: Text("محتوى البحث"),
            )
          : ListView.builder(
              itemCount: filterdiary.length,
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
                                   filterdiary[i]['parties_to_the_case'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${filterdiary[i]['Basis_of_the_lawsuit']}",
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "${filterdiary[i]['date']}",
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                                    animType:
                                                        AnimType.rightSlide,
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
                    const Divider(
                      color: Colors.black,
                    )
                  ],
                );
              });
    });
  }
}
