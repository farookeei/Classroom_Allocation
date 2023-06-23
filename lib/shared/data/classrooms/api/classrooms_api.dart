import 'package:dio/dio.dart';

import '../../../../config/const/constants.dart';
import '../../network_client/dio_client.dart';

class ClassroomsApi {
  DioClient dioClient = DioClient();
  ClassroomsApi();

  Future<Response> getClassroomsListApi() async {
    try {
      String apiKey = Constants.API_KEY;
      final Response response = await dioClient.get(
        "/classrooms/?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getindividualClassroomsDetailApi(
      {required String id}) async {
    try {
      String apiKey = Constants.API_KEY;
      final Response response = await dioClient.get(
        "/classrooms/$id?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
