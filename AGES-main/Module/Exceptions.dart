class UIException implements Exception {
  final String message;

  UIException(this.message);

  @override
  String toString() {
    return message;
  }
}