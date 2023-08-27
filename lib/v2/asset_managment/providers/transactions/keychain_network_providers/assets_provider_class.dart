// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:ribn/v2/asset_managment/models/asset_details.dart';

// TODO SDK - Should this even be called transactions? Maybe it should be called crypto
abstract class AssetsNotifier extends StateNotifier<AsyncValue<List<AssetDetails>>> {
  AssetsNotifier() : super(AsyncLoading()) {
    getAssets().then((value) {
      state = AsyncData(value);
      onProviderLoad();
    });
  }

  Future<List<AssetDetails>> getAssets();

  Future<List<AssetDetails>> refreshAssets();

  Stream<List<AssetDetails>> streamAssets();

  void onProviderLoad();
}
