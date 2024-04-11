import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:task_manager/src/core/common/network/api_respone_model.dart';
import 'package:task_manager/src/core/constants/strings.dart';

class DataLoader {
  static String baseUrl = 'https://reqres.in/api';

  static String loginInURL = '$baseUrl/login';
  static String getTasksURL = '$baseUrl/tasks';
  static String getTaskURL = '$baseUrl/task';
  static String updateTaskURL = '$baseUrl/task';
  static String createTaskURL = '$baseUrl/task';
  static String deleteTaskURL = '$baseUrl/task';

  static Future<ApiResponse> getRequest(
      {String? url, int? timeout = 30, Map<String, String> headers = const {'Content-Type': 'application/json'}}) async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    final http = IOClient(ioc);
    Uri parsedUrl = Uri.parse(url!);
    try {
      print('************ body request ***********');
      print(url);
      print(headers);
      final response = await http.get(parsedUrl, headers: headers).timeout(Duration(seconds: timeout!));

      log(name: 'POST_REQUEST_RESPONSE', response.body.toString());
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300 || response.statusCode == 404) {
        return ApiResponse.fromJson(
            {"code": "1", "message": decodedResponse['message'], "data": decodedResponse as Map<String, dynamic>});
      } else {
        print(response);
        return ApiResponse.fromJson({
          "code": GENERAL_ERROR_CODE,
          "message": decodedResponse['message'],
          "data": null,
        });
      }
    } on TimeoutException catch (e) {
      log(name: 'TimeoutException', e.toString());

      return ApiResponse.fromJson({
        "code": TIME_OUT_ERROR_CODE,
        "message": TIME_OUT_ERROR_MESSAGE,
        "data": null,
      });
    } on SocketException catch (e) {
      log(name: 'SOCKET_EXCEPTION_ERROR', e.toString());

      return ApiResponse.fromJson({
        "code": NO_INTERNET_CONNECTION_ERROR_CODE,
        "message": NO_INTERNET_CONNECTION_ERROR_MESSAGE,
        "data": null,
      });
    } catch (e) {
      print('error : + ${e.toString()}');

      log(name: 'POST_REQUEST_ERROR', e.toString());
      return ApiResponse.fromJson({
        "code": GENERAL_ERROR_CODE,
        "message": GENERAL_ERROR_MESSAGE,
        "data": null,
      });
    }
  }

  static Future<ApiResponse> postRequest({
    String? url,
    Map<String, dynamic>? body,
    int? timeout = 30,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
  }) async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    final http = IOClient(ioc);
    Uri parsedUrl = Uri.parse(url!);
    try {
      print('************ body request ***********');
      print('URL  $url');
      print('HEADERS : $headers');
      print('BODY: ${jsonEncode(body)}');

      final response = await http.post(parsedUrl, headers: headers, body: json.encode(body)).timeout(Duration(seconds: timeout!));
      log(name: 'POST_REQUEST_RESPONSE', response.body.toString());
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.fromJson({
          "code": "1",
          "message": decodedResponse['message'] ?? SUCCESS_MESSAGE,
          "data": decodedResponse as Map<String, dynamic>
        });
      } else {
        return ApiResponse.fromJson({
          "code": GENERAL_ERROR_CODE,
          "message": decodedResponse['message'] ?? GENERAL_ERROR_MESSAGE,
          "data": decodedResponse,
        });
      }
    } on TimeoutException catch (e) {
      log(name: 'TimeoutException', e.toString());

      return ApiResponse.fromJson({
        "code": TIME_OUT_ERROR_CODE,
        "message": TIME_OUT_ERROR_MESSAGE,
        "data": null,
      });
    } on SocketException catch (e) {
      log(name: 'SOCKET_EXCEPTION_ERROR', e.toString());

      return ApiResponse.fromJson({
        "code": NO_INTERNET_CONNECTION_ERROR_CODE,
        "message": NO_INTERNET_CONNECTION_ERROR_MESSAGE,
        "data": null,
      });
    } catch (e) {
      print('error : + ${e.toString()}');

      log(name: 'POST_REQUEST_ERROR', e.toString());
      return ApiResponse.fromJson({
        "code": GENERAL_ERROR_CODE,
        "message": GENERAL_ERROR_MESSAGE,
        "data": null,
      });
    }
  }

  static Future<void> sendPushNotification({required String token, required String title, required String body}) async {
    log('trying to send notification to $token');
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAj_Ddrxk:APA91bH6Oab4SXyy0k4UowHvbmaoMBiucrZ4LVUqCAsOq-rpXmH6iJpbkGU_ach3mwrLaFCvphasZuPGedXYo3Tnkf0iQU0mAtTipW8xDxUlcI0ybIoQrsPCsIIfaJ2gD8t7pAX_4Fbh',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'to': token,
          },
        ),
      );
      log('Push notification sent successfully');
    } catch (e) {
      log('Error sending push notification: $e');
    }
  }

  static Future<ApiResponse> putRequest({
    String? url,
    Map<String, dynamic>? body,
    int? timeout = 30,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
  }) async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    final http = IOClient(ioc);
    Uri parsedUrl = Uri.parse(url!);
    try {
      print('************ body request ***********');
      print('URL  $url');
      print('HEADERS : $headers');
      print('BODY: ${jsonEncode(body)}');

      final response = await http.put(parsedUrl, headers: headers, body: json.encode(body)).timeout(Duration(seconds: timeout!));
      log(name: 'POST_REQUEST_RESPONSE', response.toString());
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.fromJson({
          "code": "1",
          "message": decodedResponse['message'] ?? SUCCESS_MESSAGE,
          "data": decodedResponse as Map<String, dynamic>
        });
      } else {
        return ApiResponse.fromJson({
          "code": GENERAL_ERROR_CODE,
          "message": decodedResponse['message'] ?? GENERAL_ERROR_MESSAGE,
          "data": decodedResponse,
        });
      }
    } on TimeoutException catch (e) {
      log(name: 'TimeoutException', e.toString());

      return ApiResponse.fromJson({
        "code": TIME_OUT_ERROR_CODE,
        "message": TIME_OUT_ERROR_MESSAGE,
        "data": null,
      });
    } on SocketException catch (e) {
      log(name: 'SOCKET_EXCEPTION_ERROR', e.toString());

      return ApiResponse.fromJson({
        "code": NO_INTERNET_CONNECTION_ERROR_CODE,
        "message": NO_INTERNET_CONNECTION_ERROR_MESSAGE,
        "data": null,
      });
    } catch (e) {
      print('error : + ${e.toString()}');

      log(name: 'POST_REQUEST_ERROR', e.toString());
      return ApiResponse.fromJson({
        "code": GENERAL_ERROR_CODE,
        "message": GENERAL_ERROR_MESSAGE,
        "data": null,
      });
    }
  }

  static Future<ApiResponse> deleteRequest({
    String? url,
    Map<String, dynamic>? body,
    int? timeout = 30,
    Map<String, String> headers = const {'Content-Type': 'application/json'},
  }) async {
    final ioc = HttpClient();
    ioc.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    final http = IOClient(ioc);
    Uri parsedUrl = Uri.parse(url!);
    try {
      print('************ body request ***********');
      print('URL  $url');
      print('HEADERS : $headers');
      print('BODY: ${jsonEncode(body)}');

      final response =
          await http.delete(parsedUrl, headers: headers, body: json.encode(body)).timeout(Duration(seconds: timeout!));
      log(name: 'POST_REQUEST_RESPONSE', response.body.toString());
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse.fromJson({
          "code": "1",
          "message": decodedResponse['message'] ?? SUCCESS_MESSAGE,
          "data": decodedResponse as Map<String, dynamic>
        });
      } else {
        return ApiResponse.fromJson({
          "code": GENERAL_ERROR_CODE,
          "message": decodedResponse['message'] ?? GENERAL_ERROR_MESSAGE,
          "data": decodedResponse,
        });
      }
    } on TimeoutException catch (e) {
      log(name: 'TimeoutException', e.toString());

      return ApiResponse.fromJson({
        "code": TIME_OUT_ERROR_CODE,
        "message": TIME_OUT_ERROR_MESSAGE,
        "data": null,
      });
    } on SocketException catch (e) {
      log(name: 'SOCKET_EXCEPTION_ERROR', e.toString());

      return ApiResponse.fromJson({
        "code": NO_INTERNET_CONNECTION_ERROR_CODE,
        "message": NO_INTERNET_CONNECTION_ERROR_MESSAGE,
        "data": null,
      });
    } catch (e) {
      print('error : + ${e.toString()}');

      log(name: 'POST_REQUEST_ERROR', e.toString());
      return ApiResponse.fromJson({
        "code": GENERAL_ERROR_CODE,
        "message": GENERAL_ERROR_MESSAGE,
        "data": null,
      });
    }
  }
}
