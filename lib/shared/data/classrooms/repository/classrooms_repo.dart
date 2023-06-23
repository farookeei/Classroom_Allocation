import 'package:dio/dio.dart';
import 'package:test_sample/shared/data/classrooms/model/classrooms_model.dart';

import '../../network_client/dio_exception.dart';
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
}
