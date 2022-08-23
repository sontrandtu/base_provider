

abstract class AppConfigBase {
  bool _isAuthenticated = false;

  bool isAuthenticated() => _isAuthenticated;

  void setHasAuthenticated(bool b) => _isAuthenticated = b;


  Future<void> authenticate();

  Future<void> unAuthenticate();

  void setOrientation();
}
