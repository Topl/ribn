// Package imports:
import 'package:redux/redux.dart';

// Project imports:
import 'package:ribn/actions/user_details_actions.dart';
import 'package:ribn/models/asset_details.dart';
import 'package:ribn/models/user_details_state.dart';

final userDetailsReducer = combineReducers<UserDetailsState>(
  [
    TypedReducer<UserDetailsState, UpdateAssetDetailsAction>(
      _updateAssetDetails,
    ),
  ],
);

/// Handles [UpdateAssetDetailsAction] and updates the [assetDetails] that are stored locally, associated
/// with [action.assetCode].
UserDetailsState _updateAssetDetails(
  UserDetailsState userDetails,
  UpdateAssetDetailsAction action,
) {
  final AssetDetails? currAssetDetails =
      userDetails.assetDetails[action.assetCode];
  return userDetails.copyWith(
    assetDetails: {
      ...userDetails.assetDetails,
      action.assetCode: AssetDetails(
        icon: action.icon ?? currAssetDetails?.icon,
        longName: action.longName ?? currAssetDetails?.longName,
        unit: action.unit ?? currAssetDetails?.unit,
      ),
    },
  );
}

