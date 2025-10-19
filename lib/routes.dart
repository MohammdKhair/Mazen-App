import 'package:get/get.dart';
import 'package:mazen/core/constant/app_route.dart';
import 'package:mazen/screens/addpage/view/addpage.dart';
import 'package:mazen/screens/alldatapage/view/alldatapage.dart';
import 'package:mazen/screens/detailpage/view/detailpage.dart';
import 'package:mazen/screens/editpage/view/editpage.dart';
import 'package:mazen/screens/homepage/view/homepage.dart';
import 'package:mazen/screens/viewpage/view/viewpage.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoutes.home, page: () => const HomePage()),
  GetPage(name: AppRoutes.view, page: () => const ViewPage()),
  GetPage(name: AppRoutes.add, page: () => const AddPage()),
  GetPage(name: AppRoutes.edit, page: () => const Editpage()),
  GetPage(name: AppRoutes.detail, page: () => const DetailPage()),
  GetPage(name: AppRoutes.alldata, page: () => const AllDataPage()),
];
