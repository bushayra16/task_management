import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_management/app.dart';
import 'package:task_management/data/model/network_response.dart';
import 'package:task_management/ui/Screens/sign_in_screen.dart';
import 'package:task_management/ui/controllers/auth_controllers.dart';

class NetworkCaller {
  static Future <NetworkResponse> getRequest ({required String url}) async {
    try {Uri uri = Uri.parse(url);
    Map<String, String> headers = {
      'token' : AuthControllers.accessToken.toString()
    };
    printRequest(url, null, headers);
    final Response response = await get(uri,headers: headers);
     printResponse(response, url);
    if  (response.statusCode == 200){
      final decodeData = jsonDecode(response.body);
      return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          statusData: decodeData,
      );
    }
    else{
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
      );
    }
  }catch(e){
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
    }
  static Future <NetworkResponse> postRequest ({required String url, Map<String, dynamic>? body}) async {
    try {Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type' : 'application/json', 'token' : AuthControllers.accessToken.toString()
      };
    printRequest(url, body, headers);
    debugPrint(url);
    final Response response = await post(uri,
        body: jsonEncode(body),
      headers: headers);
    printResponse(response, url);

    if  (response.statusCode == 200){
      final decodeData = jsonDecode(response.body);
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        errorMessage: decodeData.toString(),
      );
    }
    else if (response.statusCode == 400){
      final decodeData = jsonDecode(response.body);
      // String errorMessage = decodeData["data"]?.toString() ?? "An error occurred";
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: decodeData["data"]?.toString()
      );
    }
    else if(response.statusCode == 401){
      _moveToLogin();
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: 'UnAuthenticated'
      );
    }
    else if (response.statusCode == 404){
      final decodeData = jsonDecode(response.body);
      // String errorMessage = decodeData["data"]?.toString() ?? "An error occurred";
      return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodeData["data"]?.toString()
      );
    }
    else{
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
      );
    }
    }catch(e){
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }
    static void printRequest(String url, Map<String, dynamic>? body, Map<String, dynamic> headers) {
      debugPrint('REQUEST: \nURL: $url\nBODY: $body\nHEADERS: $headers');
    }
    static void printResponse(Response response, String url) {
     debugPrint('URL: $url\nResponseCode: ${response.statusCode}\nBody: ${response.body}');
   }

   static void _moveToLogin() async{
    await AuthControllers.clearUserData();
    Navigator.pushAndRemoveUntil(TaskManagementApp.navigatorKey.currentState!.context, MaterialPageRoute(builder: (context)=> const SignInScreen()), (p)=>false);
   }

}