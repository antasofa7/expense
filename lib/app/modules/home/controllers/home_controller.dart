import 'package:get/get.dart';

class HomeController extends GetxController {
  var months = <String>[
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  var month = "".obs;
  var transaction = <String>["Today", "Week", "Month", "Year"];

  var bottomNavIndex = 0.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    month(months[9]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
