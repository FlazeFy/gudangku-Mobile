import 'package:get/get.dart';
import 'package:gudangku/modules/global/style.dart';
import 'package:gudangku/views/login/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

Future<void> getDestroyTrace(bool isSignOut) async {
  if (!isSignOut) {
    Get.to(const LoginPage(), preventDuplicates: false);
  }

  final prefs = await SharedPreferences.getInstance();
  // Client client = Client();

  // await Future.delayed(const Duration(seconds: 1));
  // client.close();

  if (isSignOut) {
    Get.to(() => const LoginPage());
  }
  await prefs.clear();
  final cacheDir = await getTemporaryDirectory();
  final appDir = await getApplicationSupportDirectory();

  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }

  // Get.reset();
  // Get.clearRouteTree();

  if (!isSignOut) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.to(() => const LoginPage());
    });
    Get.snackbar("Alert".tr, "Session lost, please sign in again",
        backgroundColor: whiteColor);
  }
}
