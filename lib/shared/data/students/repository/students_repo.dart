import 'package:dio/dio.dart';
import 'package:test_sample/shared/data/students/model/students_model.dart';

import '../../network_client/dio_exception.dart';
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
}
