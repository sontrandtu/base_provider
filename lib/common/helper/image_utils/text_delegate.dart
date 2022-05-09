import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AssetPickerTextDelegateVN extends AssetPickerTextDelegate {
  const AssetPickerTextDelegateVN();


  @override
  String get languageCode => LanguageCodeConstant.VI;

  @override
  String get cancel => 'Hủy';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get edit => 'Sửa';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'Có lỗi';

  @override
  String get original => 'Origin';

  @override
  String get preview => 'Preview';

  @override
  String get select => 'Select';

  @override
  String get emptyList => 'Chưa có dữ liệu';

  @override
  String get unSupportedAssetType => 'Unsupported HEIC asset type.';

  @override
  String get unableToAccessAll => 'Không thể truy cập tất cả nội dung trên thiết bị';

  @override
  String get viewingLimitedAssetsTip =>
      'Chỉ xem nội dung và album có thể truy cập vào ứng dụng.';

  @override
  String get changeAccessibleLimitedAssets =>
      'Nhấp để cập nhật nội dung có thể truy cập';

  @override
  String get accessAllTip => 'App can only access some assets on the device. '
      'Go to system settings and allow app to access all assets on the device.';

  @override
  String get goToSystemSettings => 'Đi tới cài đặt hệ thống';

  @override
  String get accessLimitedAssets => 'Tiếp tục với quyền truy cập hạn chế';

  @override
  String get accessiblePathName => 'Accessible assets';

  @override
  String get sTypeAudioLabel => 'Audio';

  @override
  String get sTypeImageLabel => 'Image';

  @override
  String get sTypeVideoLabel => 'Video';

  @override
  String get sTypeOtherLabel => 'Other asset';

  @override
  String get sActionPlayHint => 'play';

  @override
  String get sActionPreviewHint => 'preview';

  @override
  String get sActionSelectHint => 'select';

  @override
  String get sActionSwitchPathLabel => 'switch path';

  @override
  String get sActionUseCameraHint => 'use camera';

  @override
  String get sNameDurationLabel => 'duration';

  @override
  String get sUnitAssetCountLabel => 'count';
}
