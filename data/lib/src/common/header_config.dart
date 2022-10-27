class HeaderConfig {
  HeaderConfig._internal();

  static final HeaderConfig _config = HeaderConfig._internal();

  factory HeaderConfig() => _config;
  Map<String, dynamic> _defaultHeaders = {
     // 'token':
     //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJwaG9uZSI6IjA5NDM1NzQ1NTYifQ.LrOc2ZA-vE_vuQm-J8bjxPMQF7C8AkLyqnhVZiPEXuE',
     // 'id': '1660546372487t40li80k3'
  };

  void setDefaultHeader(Map<String, dynamic> headers) => _defaultHeaders = headers;

  Map<String, dynamic> getHeaders() => _defaultHeaders;

  void addHeaders(Map<String, dynamic> headers) => _defaultHeaders.addAll(headers);
}
