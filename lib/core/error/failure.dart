abstract class Failure {
  final String message;
  final StackTrace? stackTrace;
  final Map<String, dynamic> _data = {};

  Failure({required this.message, this.stackTrace});

  Map<String, dynamic> get data => Map.unmodifiable(_data);

  void addData(String key, dynamic value) {
    _data[key] = value;
  }

  @override
  String toString() => '$runtimeType: $message';
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required super.message, super.stackTrace});

  factory DatabaseFailure.fromError(Object error, StackTrace stackTrace) {
    return DatabaseFailure(
      message: error.toString(),
      stackTrace: stackTrace,
    );
  }
}

class NotFoundFailure extends Failure {
  NotFoundFailure({required super.message, super.stackTrace});
}
