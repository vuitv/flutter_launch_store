import 'package:flutter_launch_store/src/public/model/app_store_model.dart';

abstract class AbstractAppStore {
  const AbstractAppStore._();

  factory AbstractAppStore(ApplicationAppStore referrer) {
    switch (referrer) {
      case ApplicationAppStore.appleAppStore:
        return const AppStore._();
      case ApplicationAppStore.googlePlay:
        return const GooglePlay._();
      case ApplicationAppStore.amazonAppStore:
        return const AmazonAppStore._();
      case ApplicationAppStore.huaweiAppGallery:
        return const HuaweiAppGallery._();
      case ApplicationAppStore.samsungAppShop:
        return const SamsungAppShop._();
      default:
        throw UnimplementedError();
    }
  }

  String get packageName;

  Uri packageDetailsUri(String packageName);

  Uri? packageDetailsUriAlternative(String packageName) => null;
}

class AppStore extends AbstractAppStore {
  const AppStore._() : super._();

  @override
  String get packageName => throw UnimplementedError();

  @override
  Uri packageDetailsUri(String packageName) {
    assert(packageName.isNotEmpty);
    return Uri.parse(
      "itms-apps://itunes.apple.com/app/id$packageName",
    );
  }
}

class GooglePlay extends AbstractAppStore {
  const GooglePlay._() : super._();

  @override
  String get packageName => 'com.android.vending';

  @override
  Uri packageDetailsUri(String packageName) => Uri.parse(
        'market://details?id=$packageName',
      );

  @override
  Uri? packageDetailsUriAlternative(String packageName) => Uri.parse(
        "https://play.google.com/store/apps/details?id=$packageName",
      );
}

class AmazonAppStore extends AbstractAppStore {
  const AmazonAppStore._() : super._();

  @override
  String get packageName => 'com.amazon.venezia';

  @override
  Uri packageDetailsUri(String packageName) => Uri.parse(
        'amzn://apps/android?p=$packageName',
      );

  @override
  Uri? packageDetailsUriAlternative(String packageName) => Uri.parse(
        "https://www.amazon.com/gp/mas/dl/android?p=$packageName",
      );
}

class HuaweiAppGallery extends AbstractAppStore {
  const HuaweiAppGallery._() : super._();

  @override
  String get packageName => 'com.huawei.appmarket';

  @override
  Uri packageDetailsUri(String packageName) => Uri.parse(
        'appmarket://details?id=$packageName',
      );
}

class SamsungAppShop extends AbstractAppStore {
  const SamsungAppShop._() : super._();

  @override
  String get packageName => 'com.sec.android.app.samsungapps';

  @override
  Uri packageDetailsUri(String packageName) => Uri.parse(
        'samsungapps://ProductDetail/$packageName',
      );
}
