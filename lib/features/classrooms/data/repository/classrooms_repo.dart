import 'package:dio/dio.dart';
import 'package:test_sample/features/classrooms/data/model/classrooms_model.dart';

import '../../../../shared/data/network_client/dio_exception.dart';
import '../../../../shared/data/registration/model/registration_model.dart';
import '../api/classrooms_api.dart';

class ClassroomsRepository {
  ClassroomsRepository();

  final ClassroomsApi _classroomsApi = ClassroomsApi();
  Future<ClassroomsModel> getClassRoomsListRepo() async {
    try {
      final Response response = await _classroomsApi.getClassroomsListApi();

      ClassroomsModel data = ClassroomsModel.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<Classrooms> getClassRoomDetailRepo({required String id}) async {
    try {
      final Response response =
          await _classroomsApi.getindividualClassroomsDetailApi(id: id);

      Classrooms data = Classrooms.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> addSubjectToClassRepo(
      {required String classId, required String subjectId}) async {
    try {
      final Response response = await _classroomsApi.addSubjectToClassroomApi(
          classId: classId, subjectId: subjectId);

      // Classrooms data = Classrooms.fromJson(response.data);
      // return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<RegistrationsModel> getStudentRegistrationsRepo() async {
    try {
      final Response response =
          await _classroomsApi.getStudentRegistrationsApi();

      RegistrationsModel data = RegistrationsModel.fromJson(response.data);

      return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> postStudentRegistrationRepo(
      {required String studentId, required String subjectId}) async {
    try {
      final Response response = await _classroomsApi.postStudentRegistrationApi(
          studentId: studentId, subjectId: subjectId);

      // Classrooms data = Classrooms.fromJson(response.data);
      // return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<void> deleteStudentregistationRepo({required String regId}) async {
    try {
      final Response response =
          await _classroomsApi.deleteStudentRegistationApi(regId: regId);
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}
// 