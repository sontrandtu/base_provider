import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../sys/base_function.dart';

class BaseRefreshController {
  RefreshController? _controller;
  Function? callData;
  late int _pageIndex;
  bool? _isRefreshed;
  bool? _endPoint;

  BaseRefreshController(
      {RefreshController? controller,
        required this.callData,
        int? pageIndex,
        bool? isRefreshing,
        bool? endPoint}) {
    controller == null ? _controller = RefreshController() : _controller = controller;
    isRefreshing == null ? _isRefreshed = false : _isRefreshed = isRefreshing;
    pageIndex == null ? _pageIndex = 1 : _pageIndex = pageIndex;
    endPoint == null ? _endPoint = false : _endPoint = endPoint;
  }

  Future refreshData() async {
    showLog('Refresh data');
    _pageIndex = 1;
    _isRefreshed = true;
    _endPoint = false;
    await callData?.call();
    refreshed();
  }

  void refreshed() {
    if (_controller != null) {
      _controller?.resetNoData();
      _controller?.refreshCompleted();
    }
  }

  Future loadMoreData() async {
    showLog('Load more data');

    _isRefreshed = false;
    _pageIndex += 1;
    await callData?.call();

    _controller?.loadComplete();
    if (_endPoint == true) _controller?.loadNoData();
  }

  bool get isRefreshed => _isRefreshed!;

  RefreshController get controller => _controller!;

  bool get endPoint => _endPoint!;

  int get pageIndex => _pageIndex;

  void setEndPoint(bool b) => _endPoint = b;

  void setPageIndex(int i) => _pageIndex = i;

  void setFunction(Function f) => callData = f;

  void setController(RefreshController rc) => _controller = rc;
}
