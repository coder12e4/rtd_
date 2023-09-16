/*writen by hariprasad*/
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ApiService extends GetxService {
  final String appBaseUrl;
  static const String connectionIssue = 'Connection failed!';
  final int timeoutInSeconds = 30;
  ApiService({required this.appBaseUrl});

  Future<Response> getPublic(String uri) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(uri),
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> getOther(String uri) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(uri),
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> getExternal(String uri) async {
    try {
      http.Response response = await http
          .get(
            Uri.parse(uri),
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> getPrivate(String uri, String token) async {
    try {
      http.Response response = await http.get(Uri.parse(uri), headers: {
        'Content-Type': 'application/json;',
        'Authorization': 'Bearer $token'
      }).timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> uploadFiles(
    String uri,
    List<MultipartBody> multipartBody,
    name,
    email,
    password,
    conPassword,
    inum,
    ksanum,
    bloodgroup,
    iaddress1,
    iaddress2,
    iState,
    iPin,
    kAddress1,
    kAddress2,
    kState,
    kPin,
  ) async {
    try {
      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse(uri),
      );

      request.headers.addAll({"Accept": "application/json"});
      for (MultipartBody multipart in multipartBody) {
        File file = File(multipart.file.path);
        request.files.add(http.MultipartFile(
          multipart.key,
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ));
      }

      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['c_pasword'] = conPassword;
      request.fields['india_mobile_number'] = inum;
      request.fields['ksa_mobile_number'] = ksanum;
      request.fields['blood_group'] = bloodgroup;
      request.fields['indian_address_1'] = iaddress1;
      request.fields['indian_address_2'] = iaddress2;
      request.fields['india_state'] = iState;
      request.fields['india_pin'] = iPin;
      request.fields['ksa_address_1'] = kAddress1;
      request.fields['ksa_address_2'] = kAddress2;
      request.fields['ksa_state'] = kState;
      request.fields['ksa_pin'] = kPin;

      http.Response response =
          await http.Response.fromStream(await request.send());
      log(uri);
      log(response.statusCode.toString());
      log('upload image');
      return parseResponse(response, uri);
    } catch (e) {
      log(e.toString());
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> postPublic(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json", // Set content type to JSON
    };
    final String requestBodyJson = jsonEncode(body);
    try {
      log(uri);
      log(body.toString());

      http.Response response = await http
          .post(
            Uri.parse(uri),
            headers: headers,
            body: requestBodyJson,
          )
          .timeout(Duration(seconds: timeoutInSeconds));

      log(response.body);
      log('from ApiService ${response.statusCode.toString()}');
      log(uri);
      return parseResponse(response, uri);
    } catch (e) {
      log(' from api service ${e.toString()}');
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }
//   Future<Response> postPublic(String url, dynamic body) async {
//     try {
//       http.Response response = await http.post(
//             Uri.parse(url),
//             headers: {'Accept': "application/json"},
//             body: jsonEncode(body),
//           )
//           .timeout(Duration(seconds: timeoutInSeconds));

//       print(response.body);
//       //print(appBaseUrl + uri);
//       return parseResponse(response,url);
// >>>>>>> b9f06c447ec4f4a4bb4b7ff334e752e96abf1121
//     } catch (e) {
//       log(' from api service ${e.toString()}');
//       return const Response(statusCode: 1, statusText: connectionIssue);
//     }
//   }

  Future<Response> postPrivate(
    String uri,
    dynamic body,
    String token,
  ) async {
    log(body.toString());
    try {
      final requestBodyJson = jsonEncode(body);
      http.Response response =
          await http.post(Uri.parse(uri), body: requestBodyJson, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      }).timeout(Duration(seconds: timeoutInSeconds));

      log(response.body);
      log(token);
      log(Uri.parse(uri).toString());
      return parseResponse(response, uri);
    } catch (e) {
      log(e.toString());
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Future<Response> logout(
    String uri,
    String token,
  ) async {
    try {
      http.Response response = await http.post(Uri.parse(appBaseUrl + uri),
          headers: {
            "Accept": "application/json",
            'Authorization': 'Bearer $token'
          }).timeout(Duration(seconds: timeoutInSeconds));
      return parseResponse(response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }

  Response parseResponse(http.Response res, String uri) {
    dynamic body;
    try {
      body = jsonDecode(res.body);
    } catch (e) {
      e;
    }
    Response response = Response(
      body: body != '' ? body : res.body,
      bodyString: res.body.toString(),
      headers: res.headers,
      statusCode: res.statusCode,
      statusText: res.reasonPhrase,
    );
    log('response body');
    if (response.statusCode != 200 &&
        response.body != null &&
        response.body is! String) {
      if (response.body.toString().startsWith('{errors: [{code:')) {
        response = Response(
            statusCode: response.statusCode,
            body: response.body,
            statusText: 'error');
      } else if (response.body.toString().startsWith('{message')) {
        response = Response(
            statusCode: response.statusCode,
            body: response.body,
            statusText: response.body['message']);
      }
    } else if (response.statusCode != 200 && response.body == null) {
      response = const Response(statusCode: 0, statusText: connectionIssue);
    }
    return response;
  }

  Future<Response> postPubliceg(String uri, body,
      {Map<String, String>? headers}) async {
    final Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json", // Set content type to JSON
    };
    final String requestBodyJson = jsonEncode(body);
    try {
      var url = Uri.https('rtd.canisostudio.com', '/api/user/login');
      log(url.toString());

      // log(encodedBody.toString());
      var response = await http.post(
        url,
        body: requestBodyJson,
        headers: headers,
      );

      log("decoded data from api service${jsonDecode(response.body)}");
      log('from ApiService1 ${response.statusCode.toString()}');
      log(uri);
      return parseResponse(response, uri);
    } catch (e) {
      log(' from api service ${e.toString()}');
      return const Response(statusCode: 1, statusText: connectionIssue);
    }
  }
}

class MultipartBody {
  String key;
  XFile file;
  MultipartBody(this.key, this.file);
}
