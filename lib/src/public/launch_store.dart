library launch_store;

import 'package:launch_store/src/private/generic_app_store.dart';
import 'package:launch_store/src/public/model/app_store_model.dart';
import 'package:device_apps/device_apps.dart';
import 'package:install_referrer/install_referrer.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppStore {
  Future<bool> launchAppStoreApplication({
    ApplicationAppStore? store,
  }) async {
    return _launch(
      store ?? _toApplicationAppStore(await InstallReferrer.referrer),
    );
  }

  Future<bool> launchAutomaticallyApplicationDetailsOnStore() async {
    InstallationApp app = await InstallReferrer.app;

    return launchApplicationDetailsOnAppStore(
      store: _toApplicationAppStore(app.referrer),
      packageName: app.packageName ?? '',
    );
  }

  Future<bool> launchApplicationDetailsOnAppStore({
    required ApplicationAppStore store,
    required String packageName,
  }) async {
    AbstractAppStore appStore = AbstractAppStore(store);

    var url1 = appStore.packageDetailsUri(packageName).toString();
    var url2 = appStore.packageDetailsUriAlternative(packageName).toString();

    var res = await _open(url1);
    if (res != true) {
      res = await _open(url2);
    }

    return res;
  }

  Future<bool> _open(String? url) async {
    if (url?.isNotEmpty != true) {
      return false;
    }

    if ((await canLaunchUrlString(url!)) == true) {
      return launchUrlString(url);
    }

    return false;
  }

  ApplicationAppStore _toApplicationAppStore(
    InstallationAppReferrer referrer,
  ) {
    switch (referrer) {
      case InstallationAppReferrer.iosAppStore:
        return ApplicationAppStore.appleAppStore;
      case InstallationAppReferrer.androidGooglePlay:
        return ApplicationAppStore.appleAppStore;
      case InstallationAppReferrer.androidAmazonAppStore:
        return ApplicationAppStore.appleAppStore;
      case InstallationAppReferrer.androidHuaweiAppGallery:
        return ApplicationAppStore.appleAppStore;
      case InstallationAppReferrer.androidSamsungAppShop:
        return ApplicationAppStore.appleAppStore;
      default:
        throw UnimplementedError();
    }
  }

  Future<bool> launchAppleAppStore() {
    return DeviceApps.openApp(
      AbstractAppStore(ApplicationAppStore.appleAppStore).packageName,
    );
  }

  Future<bool> launchGooglePlay() {
    return DeviceApps.openApp(
      AbstractAppStore(ApplicationAppStore.googlePlay).packageName,
    );
  }

  Future<bool> launchAmazonAppStore() {
    return DeviceApps.openApp(
      AbstractAppStore(ApplicationAppStore.amazonAppStore).packageName,
    );
  }

  Future<bool> launchHuaweiAppGallery() {
    return DeviceApps.openApp(
      AbstractAppStore(ApplicationAppStore.huaweiAppGallery).packageName,
    );
  }

  Future<bool> launchSamsungAppShop() {
    return DeviceApps.openApp(
      AbstractAppStore(ApplicationAppStore.samsungAppShop).packageName,
    );
  }

  Future<bool> _launch(ApplicationAppStore referrer) async {
    try {
      String packageName = AbstractAppStore(referrer).packageName;

      if (packageName.isNotEmpty) {
        return DeviceApps.openApp(packageName);
      }

      return false;
    } on UnimplementedError {
      return false;
    }
  }
}
