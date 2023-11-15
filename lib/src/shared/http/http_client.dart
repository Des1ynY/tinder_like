import 'package:http/http.dart' as http;

typedef ResponseConverter<T> = T Function(String response);

enum HttpSchemes {
  http,
  https;

  String get value {
    return switch (this) {
      HttpSchemes.http => 'http',
      HttpSchemes.https => 'https',
    };
  }
}

class HttpClient {
  final HttpSchemes scheme;
  final String host;

  const HttpClient({
    required this.host,
    this.scheme = HttpSchemes.https,
  });

  Future<T> get<T extends Object?>({
    required String path,
    required ResponseConverter<T> converter,
    String query = '',
    Map<String, String> queryParameters = const <String, String>{},
    Map<String, String> headers = const <String, String>{},
  }) async {
    final response = await http.get(
      Uri(
        scheme: scheme.value,
        host: host,
        path: path,
        query: query.isNotEmpty ? query : null,
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      ),
      headers: headers.isNotEmpty ? headers : null,
    );

    return converter.call(response.body);
  }

  Future<T> post<T extends Object?>({
    required String path,
    required ResponseConverter<T> converter,
    Object? body,
    String query = '',
    Map<String, String> queryParameters = const <String, String>{},
    Map<String, String> headers = const <String, String>{},
  }) async {
    final response = await http.post(
      Uri(
        scheme: scheme.value,
        host: host,
        path: path,
        query: query.isNotEmpty ? query : null,
        queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      ),
      headers: headers.isNotEmpty ? headers : null,
      body: body,
    );

    return converter.call(response.body);
  }
}
