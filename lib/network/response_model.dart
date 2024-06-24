class ResponseModel<T> {
  T? content;
  ErrorInfo errorInfo;

  ResponseModel({required this.content, required this.errorInfo});

  factory ResponseModel.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic> json)? fromJson) {
    // Parse error info
    ErrorInfo errorInfo = ErrorInfo.fromJson(json['response']);

    dynamic parsedContent;
    try {
      if (json['content'] != null && fromJson != null) {
        if (json['content'] is String) {
          parsedContent = fromJson(json);
        } else {
          parsedContent = fromJson(json['content']);
        }
      }
    } on Exception catch (exception) {
      print(exception);
    }

    return ResponseModel<T>(
      content: parsedContent,
      errorInfo: errorInfo,
    );
  }

  Map<String, dynamic> toJson(
      Map<String, dynamic> Function(T? content) toJson) {
    final Map<String, dynamic> data = {};
    data['content'] = toJson(this.content);
    data['response'] = this.errorInfo.toJson();
    return data;
  }
}

class ErrorInfo {
  int error;
  String message;

  ErrorInfo({required this.error, required this.message});

  ErrorInfo.fromJson(Map<String, dynamic> json)
      : error = json['error'] ?? 0,
        message = json['message'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    return data;
  }
}
