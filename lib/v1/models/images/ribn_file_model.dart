/**
 * @dev File contains properties used for storing file information
 * @notice This is currently used for uploading screenshots under the feedback section
 */
class RibnFileModel {
  final String filePath;
  final String fileType;
  const RibnFileModel({required this.filePath, required this.fileType});
}
