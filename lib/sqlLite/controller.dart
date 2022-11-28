import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:qr_scan_demo/sqlLite/sql_provider.dart';

class UserController extends GetxController {
  RxList<Rmd> userdata = <Rmd>[].obs;
  RxString scanBarcode = 'Unknown'.obs;

  @override
  void onInit() async {
    await readData();
    super.onInit();
  }

  //qr scan

  Future<void> scanQR() async {
    try {
      scanBarcode.value = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(scanBarcode.value);
      insertData();
    } on PlatformException {
      scanBarcode.value = 'Failed to get platform version.';
    }
  }


  void insertData() async {
    final db = await initdatabase;
    List<Map> select = await db!
        .rawQuery("SELECT * FROM UserQR WHERE name='${scanBarcode.value}'");
    if (select.isEmpty) {
      db.rawInsert(
          "INSERT into UserQR(name,date)VALUES('${scanBarcode.value.toString()}','${DateTime.now().microsecond.toString()}')");
      await readData();
    } else {
      return;
      // Get.defaultDialog(
      //   title: scanBarcode.value,
      //   middleText: 'Already Insert',
      //   actions: [
      //     TextButton(
      //       child: const Text("Close"),
      //       onPressed: () => Get.back(),
      //     ),
      //   ],
      // );
    }
  }

  void deleteData(int index) async {
    final db = await initdatabase;
    // final id=userdata.indexWhere((element) => element.id==index);
    db!.rawQuery("DELETE FROM UserQR WHERE id='$index'");
    print('delete record');

    await readData();
  }

  Future<dynamic> readData() async {
    userdata.clear();
    final db = await initdatabase;
    List<Map> alldata = await db!.rawQuery("SELECT * FROM UserQR");

    print("Read successfully");
    alldata.forEach((data) {
      Rmd finaldata = Rmd.fromMap(data);
      userdata.add(finaldata);

      // print('user data : ${userdata.obs}');
    });
  }

// List<Rmd> tablesdata = [];
//
// readsData(int? id) async {
//   // userdata.value.clear();
//   final db = await initdatabase;
//   List<Map> alldata = await db!.rawQuery("select * from data where id=${id}");
//   alldata.forEach((data) {
//     Rmd finaldata = Rmd.fromMap(data);
//     tablesdata.add(finaldata);
//   });
//   print(userdata);
// }
}
