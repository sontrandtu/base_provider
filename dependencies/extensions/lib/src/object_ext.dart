// call api loi thi dung lai
extension ObjectExtension on dynamic {
  // bool _isNotNull() {
  //   return this != null;
  // }
  //
  // bool _isNull() {
  //   return this == null;
  // }
  //
  // bool _isNotNullBlank() {
  //   if (this != null) {
  //     if (this is String) {
  //       return toString().trim().isNotEmpty;
  //     }
  //     return false;
  //   }
  //   return false;
  // }

  bool systemIsEmpty([bool hasZero = false]) {
    if (this == null) return true;
    if ((this is Map || this is List) && this.length == 0) return true;
    if ((this is Map || this is Iterable) && this.isEmpty) return true;
    if (this is bool) return !this;
    if ((this is String || this is num) && (this == '0' || this == 0)) return hasZero;

    return toString().isEmpty;
  }




  bool get isEmpty => systemIsEmpty();
  // bool get isNotNull => _isNotNull();
  //
  // bool get isNulled => _isNull();
  //
  // bool get isNotNullBlank => _isNotNullBlank();
}
