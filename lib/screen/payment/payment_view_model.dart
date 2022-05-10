import 'package:achitecture_weup/common/core/sys/base_view_model.dart';
import 'package:achitecture_weup/common/core/widget/dialog/custom_dialog.dart';
import 'package:achitecture_weup/common/helper/file_utils.dart';

class PaymentViewModel extends BaseViewModel {

  void changeAlbum(List<Map<String, dynamic>> inputs) {

  }

  void download() async {
    // setStatus(Status.waiting);
    final String? path = await FileUtils().download(
        'https://www.eurofound.europa.eu/sites/default/files/ef_publication/field_ef_document/ef1710en.pdf',
        onProcess: (val) {});
    // setStatus(Status.success);
    if (path == '') return;
    if (path != '') {
      appNavigator.dialog(CustomDialog(
        title: 'title',
        description: 'description',
        onConfirm: () {},
        onCancel: () {
          appNavigator.back();
        },
      ));
    }
  }
}