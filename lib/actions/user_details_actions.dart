class UpdateAssetDetailsAction {
  final String assetCode;
  final String? longName;
  final String? unit;
  final String? icon;
  UpdateAssetDetailsAction({
    required this.assetCode,
    this.longName,
    this.unit,
    this.icon,
  });
}
