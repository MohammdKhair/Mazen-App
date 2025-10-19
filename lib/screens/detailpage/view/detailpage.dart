import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazen/core/constant/app_color.dart';
import 'package:mazen/screens/detailpage/controller/detailpagecontroller.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    DetailPageControllerImp detailPageControllerImp =
        Get.put(DetailPageControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColors,
      ),
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 20, top: 20, right: 50),
            child: Text(
              "${detailPageControllerImp.basisofthelawsuit}",
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.end,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 20, top: 20, right: 50),
            child: Text(detailPageControllerImp.partiestothecase,
                style: const TextStyle(fontSize: 30), textAlign: TextAlign.end),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 20, top: 20, right: 50),
            child: Text(detailPageControllerImp.date,
                style: const TextStyle(fontSize: 30), textAlign: TextAlign.end),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 20, left: 20, top: 20, right: 50),
            child: Text(detailPageControllerImp.reasonforpostponement,
                style: const TextStyle(fontSize: 30), textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}
