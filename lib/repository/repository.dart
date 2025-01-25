import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../utils/custom_alert_dialog.dart';

class Repository {
  String baseUrl = "https://yahmartindia.in/api/v1/";

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://yahmartindia.in/api/v1/",
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  initRepo() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    final cookieJar = PersistCookieJar(
        ignoreExpires: false, storage: FileStorage("$appDocPath/.cookies/"));

    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          log("Api Uri ->> ${options.uri}");
          // log("headers ->> ${options.headers}");
          if (options.path == '/auth/refresh') {
            return handler.next(options);
          }
          List<Cookie> cookies = await cookieJar
              .loadForRequest(Uri.parse('https://yahmartindia.in/api/v1/'));
          try {
            final at = cookies.firstWhere((c) => c.name == 'accessToken');
            if (at.expires!.millisecondsSinceEpoch <
                DateTime.now().millisecondsSinceEpoch) {
              throw StateError('Expired');
            }
          } on StateError {
            await refreshTokenApi(cookies: cookies);
            List<Cookie> cookies2 = await cookieJar
                .loadForRequest(Uri.parse('https://yahmartindia.in/api/v1/'));
            if (cookies2.isNotEmpty) {
              cookies2.firstWhere((c) {
                if (c.name == 'accessToken') {
                  options.headers['Authorization'] = 'Bearer ${c.value}';
                } else {
                  log('No elements matched the condition');
                }
                return true;
              });
            }
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<dynamic> getApiCall({required String url}) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient dioClient) {
          dioClient.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return dioClient;
        };
        Response response = await dio.get(url);
        // log("Get $url Body ->> ${json.encode(response.data)}");
        responseJson = response.data;
      } else {
        noInternetDialog(onRetry: () {
          getApiCall(url: url);
        });
      }
      return responseJson;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception("Receive  Timeout Exception");
      }
      log("Dio Exception Message ->> ${e.message.toString()}");
      log("Dio Exception Data ->> ${e.response!.data!.toString()}");
      throw Exception(e.message);
    }
  }

  Future<dynamic> postApiCall({required String url, required body}) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient dioClient) {
          dioClient.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return dioClient;
        };
        Response response = await dio.post(url, data: body);
        log("Post Body ->> ${body.toString()}");
        log("Get Body ->> ${json.encode(response.data)}");
        responseJson = response.data;
      } else {
        noInternetDialog(onRetry: () {
          postApiCall(url: url, body: body);
        });
      }
      return responseJson;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception("Receive  Timeout Exception");
      }
      log("Dio Exception Message ->> ${e.message.toString()}");
      log("Dio Exception Data ->> ${e.response!.data!.toString()}");
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  Future<dynamic> deleteApiCall({required String url}) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient dioClient) {
          dioClient.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return dioClient;
        };
        Response response = await dio.delete(url);
        log("Get Body ->> ${json.encode(response.data)}");
        responseJson = response.data;
      } else {
        noInternetDialog(onRetry: () {
          deleteApiCall(url: url);
        });
      }
      return responseJson;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception("Receive  Timeout Exception");
      }
      log("Dio Exception Message ->> ${e.message.toString()}");
      log("Dio Exception Data ->> ${e.response!.data!.toString()}");
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  Future<dynamic> uploadApiCall(
      {required String url, required XFile file}) async {
    bool internetAvailable = await isInternetAvailable();
    dynamic responseJson;
    try {
      if (internetAvailable) {
        String fileName = file.path.split('/').last;
        log(fileName);
        FormData data = FormData.fromMap({
          "files": await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        });
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (HttpClient dioClient) {
          dioClient.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return dioClient;
        };
        Response response = await dio.post(url, data: data);
        log("Upload Image Body ->> ${json.encode(response.data)}");
        responseJson = response.data;
      } else {
        noInternetDialog(onRetry: () {
          uploadApiCall(url: url, file: file);
        });
      }
      return responseJson;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      if (e.type == DioErrorType.receiveTimeout) {
        throw Exception("Receive  Timeout Exception");
      }
      log("Dio Exception Message ->> ${e.message.toString()}");
      log("Dio Exception Data ->> ${e.response!.data!.toString()}");
      throw Exception(e.response?.data['message'] ?? e.message);
    }
  }

  refreshTokenApi({List<Cookie>? cookies}) async {
    try {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      cookies!.firstWhere((c) => c.name == 'refreshToken');
      await dio.post('/auth/refresh');
    } on StateError catch (error) {
      log(error.toString());
    }
  }

  Future<bool> isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
