class CodeConstant {
  static const int UNKNOWN = 1001;
  static const int CONNECT_ERROR = 1002;
  static const int VALIDATE = 1003;

  static const int BAD_REQUEST = 400;
  static const int TOKEN_EXPIRED = 401;
  static const int FORBIDDEN = 403;
  static const int NOT_FOUND = 404;
  static const int TIME_OUT = 408;
  static const int BAD_GATEWAY = 502;

  static const int OK = 1;
  static const int ERROR = 0;
  static const int INVALID_SIGN = -1;
  static const int INVALID_DATETIME = -2;
  static const int INVALID_TOKEN = -3;
  static const int VALIDATE_ERROR = -4;
  static const int ACCOUNT_INACTIVE = -5;
  static const int SERVER_ERROR = -99;
}

class HttpConstant {
  static const String CONNECT_ERROR = 'Không có kết nối. Vui lòng thử lại sau';
  static const String UNKNOWN = 'Đã có lỗi xảy ra. Vui lòng thử lại sau';
  static const String TIME_OUT = 'Hết hạn yêu cầu. Vui lòng thử lại sau';
  static const String BAD_GATEWAY = 'Server bận. Vui lòng thử lại sau';

  static const String NOT_FOUND = 'Không tìm thấy nội dung yêu cầu. Vui lòng thử lại sau';
  static const String FORBIDDEN = 'Truy cập bị hạn chế. Vui lòng thử lại sau';
  static const String TOKEN_EXPIRED = 'Phiên làm việc đã hết hạn. Vui lòng đăng nhập lại';

}
