import 'package:dio/dio.dart';

import '../../../../config/const/constants.dart';
import '../../../../shared/data/network_client/dio_client.dart';

class ClassroomsApi {
  DioClient dioClient = DioClient();
  ClassroomsApi();
  String apiKey = Constants.API_KEY;
  Future<Response> getClassroomsListApi() async {
    try {
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
      final Response response = await dioClient.get(
        "/classrooms/$id?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addSubjectToClassroomApi(
      {required String classId, required String subjectId}) async {
    try {
      Map<String, dynamic> body = {"subject": subjectId};
      final Response response = await dioClient.patch(
        "/classrooms/$classId?api_key=$apiKey",
        data: body,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

//? registration
  Future<Response> postStudentRegistration(
      {required String studentId, required String subjectId}) async {
    try {
      Map<String, dynamic> body = {"student": studentId, "subject": subjectId};
      final Response response = await dioClient.post(
        "/registration/?api_key=$apiKey",
        data: body,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getStudentRegistrations() async {
    try {
      final Response response = await dioClient.get(
        "/registration/?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteStudentRegistationApi({required String regId}) async {
    try {
      final Response response = await dioClient.delete(
        "/registration/$regId?api_key=$apiKey",
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
