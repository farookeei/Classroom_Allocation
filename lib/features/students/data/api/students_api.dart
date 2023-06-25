import 'package:dio/dio.dart';
import 'package:test_sample/config/const/constants.dart';

import '../../../../shared/data/network_client/dio_client.dart';

class StudentApi {
  DioClient dioClient = DioClient();
  StudentApi();
  String apiKey = Constants.API_KEY;

  Future<Response> getStudentsListApi() async {
    try {
      final Response response = await dioClient.get(
        "/students/?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getindividualStudentDetailApi({required String id}) async {
    try {
      final Response response = await dioClient.get(
        "/students/$id?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
