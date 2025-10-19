import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mazen/core/constant/app_color.dart';
import 'package:mazen/screens/homepage/controller/homepagecontroller.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp homePageControllerImp =
        Get.put(HomePageControllerImp());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColors,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: GetBuilder<HomePageControllerImp>(builder: (controller) {
                return TableCalendar(
                  locale: 'en_US',
                  firstDay: DateTime.utc(2022, 1, 1),
                  focusedDay: controller.focusedDay,
                  lastDay: DateTime.utc(2060, 12, 31),
                  rowHeight: 50,
                  weekendDays: const [5, 6],
                  pageAnimationEnabled: true,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontStyle: FontStyle.italic)),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) =>
                      isSameDay(day, controller.focusedDay),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                      weekendStyle: TextStyle(color: Colors.red)),
                  onDaySelected: (selectedDay, focusedDay) {
                    controller.focusedDay = focusedDay;
                    controller.selectedDay = selectedDay;
                    controller.update();
                    controller.gotoViewPage();
                  },
                  calendarFormat: CalendarFormat.month,
                  calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 77, 13, 189),
                          shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                          color: AppColors.primaryColors,
                          shape: BoxShape.circle),
                      selectedTextStyle:
                          TextStyle(fontSize: 20, color: Colors.white),
                      todayTextStyle:
                          TextStyle(fontSize: 20, color: Colors.white),
                      outsideDaysVisible: false,
                      holidayTextStyle: TextStyle(color: Colors.yellow)),
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                );
              }),
            ),
            GetBuilder<HomePageControllerImp>(builder: (controller) {
              return Text(
                  "Selected Day = ${controller.focusedDay.toString().split(" ")[0]}");
            }),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MaterialButton(
                onPressed: () {
                  homePageControllerImp.gotoAllDataPage();
                },
                height: 42,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(10),
                minWidth: 300,
                color: AppColors.primaryColors,
                child: const Text(
                  "الدعاوي",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
