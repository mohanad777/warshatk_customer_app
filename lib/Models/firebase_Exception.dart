class FirebaseException implements Exception {
  final message;
  FirebaseException(this.message);
@override
  String toString() {
    // TODO: implement toString
    return this.message;
  }
}
