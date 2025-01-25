// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
// import 'package:connectivity/connectivity.dart';
// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:yahmart/repository/app_exception.dart';
// import '../main.dart';
// import '../utils/common_logics.dart';
// import '../utils/custom_alert_dialog.dart';
// import '../utils/shared_preferences.dart';
//
// class Repository {
//   String baseUrl = "http://195.110.59.110:84/api/v1/";
//
//   final Dio dio = Dio(
//     BaseOptions(
//         baseUrl: "http://195.110.59.110:84/api/v1/",
//         connectTimeout: const Duration(seconds: 40),
//         receiveTimeout: const Duration(seconds: 40),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//         }),
//   );
//
//   final cookieJar = PersistCookieJar(ignoreExpires: false);
//
//   initRepo() async {
//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String appDocPath = appDocDir.path;
//
//     cookieJar.storage = FileStorage("$appDocPath/.cookies/");
//     dio.interceptors.add(CookieManager(cookieJar));
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           List<Cookie> cookies =
//           await cookieJar.loadForRequest(Uri.parse(baseUrl));
//
//           try {
//             final accessToken =
//             cookies.firstWhere((c) => c.name == 'accessToken');
//             options.headers['Authorization'] = 'Bearer $accessToken';
//           } on StateError catch (error) {
//             callRefreshTokenApi();
//           }
//
//           return handler.next(options);
//         },
//       ),
//     );
//   }
//
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }
//
//   Future<dynamic> getApiCall({required String url}) async {
//     bool internetAvailable = await isInternetAvailable();
//     String jwtToken = await sp!.getString(SpUtil.accessToken) ?? "";
//     var responseJson;
//     if (!checkJWTExpire(jwt: jwtToken)) {
//
//       try {
//         if (internetAvailable) {
//           Response response = await dio.get(baseUrl + url);
//           debugPrint("baseUrl ->> ${baseUrl + url}");
//           debugPrint("statusCode ->> ${response.statusCode.toString()}");
//           log("body ->> ${response.data}");
//           log("headers ->> ${response.headers}");
//           if (checkStatus(
//               jsonData: jsonDecode(response.data),
//               status: response.statusCode.toString())) {
//             responseJson = jsonDecode(response.data);
//           }
//         } else {
//           noInternetDialog(onRetry: () {
//             getApiCall(url: url);
//           });
//         }
//
//         return responseJson;
//       } on DioError catch (e) {
//         if (e.type == DioErrorType.connectionTimeout) {
//           throw Exception("Connection  Timeout Exception");
//         }
//         if (e.type == DioErrorType.receiveTimeout) {
//           throw Exception("Receive  Timeout Exception");
//         }
//         throw Exception(e.message);
//       }
//     } else {
//       await callRefreshTokenApi();
//       return getApiCall(url: url);
//     }
//   }
//
//   Future<dynamic> postApiCall({required String url, required body}) async {
//     bool internetAvailable = await isInternetAvailable();
//     String jwtToken = sp!.getString(SpUtil.accessToken) ?? "";
//     var responseJson;
//     if (!checkJWTExpire(jwt: jwtToken)) {
//       var apiHeader = {
//         'Authorization': 'Bearer $jwtToken',
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//       };
//       try {
//         if (internetAvailable) {
//           Response response = await dio.post(baseUrl + url,
//               options: Options(headers: apiHeader), data: body);
//           log("baseUrl ->> ${baseUrl + url}");
//           log("Post Body ->> ${body.toString()}");
//           log("statusCode ->> ${response.statusCode}");
//           log("body ->> ${response.data}");
//           log("headers ->> ${response.headers}");
//           _updateCookie(response);
//           if (checkStatus(
//               jsonData: json.decode(response.data),
//               status: response.statusCode.toString())) {
//             responseJson = jsonDecode(response.data);
//           }
//         } else {
//           noInternetDialog(onRetry: () {
//             postApiCall(url: url, body: body);
//           });
//         }
//         return responseJson;
//       } on DioError catch (e) {
//         if (e.type == DioErrorType.connectionTimeout) {
//           throw Exception("Connection  Timeout Exception");
//         }
//         if (e.type == DioErrorType.receiveTimeout) {
//           throw Exception("Receive  Timeout Exception");
//         }
//         throw Exception(e.message);
//       }
//     } else {
//       await callRefreshTokenApi();
//       return postApiCall(url: url, body: body);
//     }
//   }
//
//   callRefreshTokenApi({refreshJwt}) async {
//     bool internetAvailable = await isInternetAvailable();
//     String refreshJwtToken =
//         await sp!.getString(SpUtil.refreshToken) ?? refreshJwt;
//     String jwtToken = await sp!.getString(SpUtil.accessToken) ?? "";
//     String body = json.encode({
//       'refreshToken': refreshJwtToken,
//     });
//     var cookies = [
//       'refreshToken=$refreshJwtToken',
//     ];
//     var apiHeader = {
//       'Authorization': 'Bearer $jwtToken',
//       'Accept': 'application/json',
//       'Content-Type': 'application/json',
//       'Cookie': cookies.join('; '),
//     };
//     try {
//       if (internetAvailable) {
//         Response response = await dio!.post('${baseUrl}auth/refresh',
//             options: Options(headers: apiHeader), data: body);
//         log("baseUrl ->> ${baseUrl}auth/refresh");
//         log("Post Body ->> ${body.toString()}");
//         log("statusCode ->> ${response.statusCode}");
//         log("body ->> ${response.data}");
//         log("headers ->> ${response.headers}");
//         _updateCookie(response);
//         if (checkStatus(
//             jsonData: json.decode(response.data),
//             status: response.statusCode.toString())) {}
//       } else {
//         noInternetDialog(onRetry: () {
//           getApiCall(url: '${baseUrl}auth/refresh');
//         });
//       }
//     } on SocketException {
//       throw FetchDataException('Bad connection');
//     }
//   }
//
//   Map<String, String> cookies = {};
//
//   void _updateCookie(Response response) {
//     String? allSetCookie = response.headers['set-cookie'].toString();
//     //log("set-cookie ->> ${response.headers['set-cookie']}");
//     // var accessToken = response.headers['set-cookie'].toString().split(';').first;
//     //log("accessToken ->>${accessToken.toString().replaceAll('accessToken=', '')}");
//     if (allSetCookie != null) {
//       var setCookies = allSetCookie.split(',');
//
//       for (var setCookie in setCookies) {
//         var cookies = setCookie.split(';');
//
//         for (var cookie in cookies) {
//           _setCookie(cookie);
//         }
//       }
//       log("cookies");
//       log(cookies.toString());
//       log(cookies['accessToken'].toString());
//       sp!.putString(SpUtil.accessToken, cookies['accessToken'].toString());
//       if (cookies['refreshToken'] != null) {
//         sp!.putString(SpUtil.refreshToken, cookies['refreshToken'].toString());
//       }
//       log(sp!.getString(SpUtil.refreshToken) ?? 'null');
//       // sp!.putString(SpUtil.accessTokenExists, cookies['accessTokenExists'].toString());
//       // sp!.putString(SpUtil.maxAge, cookies['Max-Age'].toString());
//       // sp!.putString(SpUtil.expires, cookies['Expires'].toString());
//       //headers['cookie'] = _generateCookieHeader();
//     }
//   }
//
//   void _setCookie(String? rawCookie) {
//     if (rawCookie != null) {
//       var keyValue = rawCookie.split('=');
//       if (keyValue.length == 2) {
//         var key = keyValue[0].trim();
//         var value = keyValue[1];
//
//         // ignore keys that aren't cookies
//         if (key == 'path' || key == 'expires') return;
//
//         cookies[key] = value;
//       }
//     }
//   }
//
//   String _generateCookieHeader() {
//     String cookie = "";
//     for (var key in cookies.keys) {
//       if (cookie.isNotEmpty) cookie += ";";
//       cookie += "$key=${cookies[key]!}";
//     }
//     return cookie;
//   }
//
//   /// used to check JWT expire date.
//   bool checkJWTExpire({required String jwt}) {
//     if (jwt.isNotEmpty) {
//       bool hasExpired = JwtDecoder.isExpired(jwt);
//       switch (hasExpired) {
//         case true:
//           return true;
//         default:
//           return false;
//       }
//     } else {
//       return false;
//     }
//   }
//
//   /// used to check api response status code.
//   bool checkStatus({required jsonData, required String status}) {
//     switch (status) {
//       case "200":
//         return true;
//       case "403":
//         CommonLogics.logOut();
//         return false;
//       default:
//         showAlertDialog(msg: jsonData["message"] ?? jsonData["error"]);
//         return false;
//     }
//   }
//
//   Future<bool> isInternetAvailable() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.mobile) {
//       return true;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
