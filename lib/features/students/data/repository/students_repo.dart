import 'package:dio/dio.dart';
import 'package:test_sample/features/students/data/model/students_model.dart';

import '../../../../shared/data/network_client/dio_exception.dart';
import '../api/students_api.dart';

class StudentsRepository {
  StudentsRepository();

  final StudentApi _studentsApi = StudentApi();
  Future<StudentsModel> getStudentsListRepo() async {
    try {
      final Response response = await _studentsApi.getStudentsListApi();

      StudentsModel data = StudentsModel.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<Students> getStudentsDetailRepo({required String id}) async {
    try {
      final Response response =
          await _studentsApi.getindividualStudentDetailApi(id: id);

      Students data = Students.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}
