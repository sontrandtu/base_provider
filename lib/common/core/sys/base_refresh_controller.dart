
import 'package:achitech_weup/common/core/sys/base_function.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseRefreshController {
  RefreshController? controller;
  Function? callData;
  int? pageIndex;
  bool? isRefreshing;
  bool? endPoint;

  BaseRefreshController(
      {RefreshController? controller,
      required this.callData,
      int? pageIndex,
      bool? isRefreshing,
      bool? endPoint}) {
    controller == null ? this.controller = RefreshController() : this.controller = controller;
    isRefreshing == null ? this.isRefreshing = false : this.isRefreshing = isRefreshing;
    pageIndex == null ? this.pageIndex = 1 : this.pageIndex = pageIndex;
    endPoint == null ? this.endPoint = false : this.endPoint = endPoint;
  }

  Future refreshData() async {
    showLog('Refresh data');
    isRefreshing = true;
    endPoint = false;
    await callData?.call();
    refreshed();
  }

  void refreshed() {
    if (controller != null) {
      controller?.resetNoData();
      controller?.refreshCompleted();
    }
  }

  Future loadMoreData() async {
    showLog('Load more data');
    if (endPoint == false) {
      isRefreshing = false;
      await callData?.call();
      controller?.loadComplete();
    } else {
      controller?.loadNoData();
    }
  }

  bool getRefreshing() => isRefreshing ?? false;

  void setEndPoint(bool b) => endPoint = b;

  void setPageIndex(int i) => pageIndex = i;

  void setFunction(Function f) => callData = f;

  void setController(RefreshController rc) => controller = rc;
}
