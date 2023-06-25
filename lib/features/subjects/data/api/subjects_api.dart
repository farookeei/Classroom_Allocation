import 'package:dio/dio.dart';

import '../../../../config/const/constants.dart';
import '../../../../shared/data/network_client/dio_client.dart';

class SubjectsApi {
  DioClient dioClient = DioClient();
  SubjectsApi();
  String apiKey = Constants.API_KEY;

  Future<Response> getSubjectsList() async {
    try {
      final Response response = await dioClient.get(
        "/subjects/?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getindividualubjectsDetail({required String id}) async {
    try {
      final Response response = await dioClient.get(
        "/subjects/$id?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
