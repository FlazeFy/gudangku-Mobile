import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:gudangku/modules/global/global.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/add_inventory/index.dart';

class CameraInventory extends StatefulWidget {
  const CameraInventory({super.key});

  @override
  State<CameraInventory> createState() => StateCameraInventoryState();
}

class StateCameraInventoryState extends State<CameraInventory>
    with SingleTickerProviderStateMixin {
  CameraController? cameraCtrl;
  Future<void>? initControlFuture;

  FlashMode flashMode = FlashMode.off;

  Future<void> _loadPreferences() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraCtrl = CameraController(cameras.first, ResolutionPreset.medium);

      initControlFuture = cameraCtrl!.initialize();
      setState(() {});
    } else {
      Get.snackbar("Error", "No cameras found on device");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  void dispose() {
    cameraCtrl?.dispose();
    super.dispose();
  }

  Future<XFile?> captureImage() async {
    try {
      await cameraCtrl?.setFlashMode(flashMode);
      final imageFile = await cameraCtrl?.takePicture();
      return imageFile;
    } catch (e) {
      e.printError();
      Get.snackbar("Error", "Failed to capture image");
      return null;
    }
  }

  void navigateToShowImage(XFile imageFile) {
    setState(() {
      capturedImage = imageFile;
    });
    Get.to(const AddInventoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        automaticallyImplyLeading: false,
        title: const Text('Add Inventory Image',
            style: TextStyle(color: whiteColor)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to Add Inventory',
            onPressed: () {
              Get.back();
            },
            color: whiteColor,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: initControlFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (cameraCtrl != null && cameraCtrl!.value.isInitialized) {
              return Center(
                child: SizedBox(
                  width: Get.width,
                  height: Get.height,
                  child: CameraPreview(cameraCtrl!),
                ),
              );
            } else {
              return const Center(child: Text('Camera not initialized'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: SizedBox(
        height: 140,
        child: Column(
          children: [
            FloatingActionButton(
              heroTag: 1,
              backgroundColor: successBG,
              onPressed: () async {
                final imageFile = await captureImage();
                if (imageFile != null) {
                  navigateToShowImage(imageFile);
                }
              },
              child: const Icon(
                Icons.camera_alt,
                color: whiteColor,
              ),
            ),
            const SizedBox(height: 20),
            FloatingActionButton(
              heroTag: 2,
              backgroundColor: primaryColor,
              onPressed: () {
                setState(() {
                  if (flashMode == FlashMode.off) {
                    Get.snackbar("Alert", "Flash is switched on",
                        backgroundColor: whiteColor,
                        borderColor: primaryColor,
                        borderWidth: 1.0);
                    flashMode = FlashMode.torch;
                  } else {
                    Get.snackbar("Alert", "Flash is switched off",
                        backgroundColor: whiteColor,
                        borderColor: primaryColor,
                        borderWidth: 1.0);
                    flashMode = FlashMode.off;
                  }
                });
              },
              child: Icon(
                flashMode == FlashMode.off ? Icons.flash_off : Icons.flash_on,
                color: whiteColor,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
