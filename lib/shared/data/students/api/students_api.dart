import 'package:dio/dio.dart';
import 'package:test_sample/config/const/constants.dart';

import '../../network_client/dio_client.dart';

class StudentApi {
  DioClient dioClient = DioClient();
  StudentApi();

  Future<Response> getStudentsList() async {
    try {
      String apiKey = Constants.API_KEY;
      final Response response = await dioClient.get(
        "/students/?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getindividualStudentDetail({required String id}) async {
    try {
      String apiKey = Constants.API_KEY;
      final Response response = await dioClient.get(
        "/students/$id?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
