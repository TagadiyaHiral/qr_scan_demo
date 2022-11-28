import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scan_demo/sqlLite/controller.dart';

class UserScreen extends StatelessWidget {
  final UserController _controller = Get.put(UserController());

  UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          Padding(
            padding: EdgeInsets.all(20),
            child: InkWell(
              onTap: () {
                _controller.scanQR();
              },
              child: const Text('Scan'),
            ),
          )
        ],
      ),
      body: Obx(
        () {
          // userController.readData();
          return _controller.userdata.isEmpty
              ?const Center(
                  child: Text(
                    'No Record',
                  ),
                )
              : ListView.builder(
                  itemCount: _controller.userdata.length,
                  itemBuilder: (ctx, i) {
                    return ListTile(
                      leading: Text(_controller.userdata[i].id.toString()),
                      title: Text(_controller.userdata[i].name),
                      subtitle: Text(_controller.userdata[i].date),
                      trailing: SizedBox(

                        child: IconButton(
                          onPressed: () {
                            print(_controller.userdata[i].id);
                            _controller.deleteData(_controller.userdata[i].id);
                            _controller.userdata.removeAt(i);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
