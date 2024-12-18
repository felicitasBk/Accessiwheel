/// Represent error with proper title and description  inside the app
class ErrorMessage {
  /// Error code - if there is any
  int? errorCode;

  /// Title of the error
  String title;

  /// Description of the error
  String description;

  /// Initializer
  ErrorMessage(this.description, this.title, this.errorCode);
}
