import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../Models/launch_model.dart';
import '../Utils/ApiStatus/api_status.dart';
import '../Utils/Constants/api_constants.dart';

class SpaceXDataProvider {
  final Client httpClient;

  SpaceXDataProvider({required this.httpClient});

  Future<Object> getLastLaunch() async {
    try {
      var url = Uri.parse(spaceXgetLastLaunch);
      var response = await httpClient.get(url);

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        return Success(response: LaunchModel.fromJson(responseJson));
      }
      return Failure(
        errorMessage: response.body,
      );
    } on HttpException {
      return Failure(errorMessage: "No Internet Connection");
    } on FormatException {
      return Failure(errorMessage: "Invalid Format");
    } on SocketException {
      return Failure(errorMessage: "No Internet Connection");
    } catch (e) {
      return Failure(errorMessage: "Invalid Error");
    }
  }

  Future<Object> getAllLaunchs() async {
    try {
      var url = Uri.parse(spaceXgetAllLaunchs);
      var response = await httpClient.get(url);

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        responseJson as List;
        return Success(
            response:
                responseJson.map((e) => LaunchModel.fromJson(e)).toList());
      }
      return Failure(
        errorMessage: response.body,
      );
    } on HttpException {
      return Failure(errorMessage: "No Internet Connection");
    } on FormatException {
      return Failure(errorMessage: "Invalid Format");
    } on SocketException {
      return Failure(errorMessage: "No Internet Connection");
    } catch (e) {
      return Failure(errorMessage: "Invalid Error");
    }
  }
}
