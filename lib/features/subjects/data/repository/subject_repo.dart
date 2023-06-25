import 'package:dio/dio.dart';
import 'package:test_sample/features/subjects/data/api/subjects_api.dart';
import 'package:test_sample/features/subjects/data/model/subjects_model.dart';

import '../../../../shared/data/network_client/dio_exception.dart';

class SubjectRepository {
  SubjectRepository();

  final SubjectsApi _subjectApi = SubjectsApi();

  Future<SubjectsModel> getSubjectsListRepo() async {
    try {
      final Response response = await _subjectApi.getSubjectsList();

      SubjectsModel data = SubjectsModel.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }

  Future<Subjects> getSubjectDetailRepo({required String id}) async {
    try {
      final Response response =
          await _subjectApi.getindividualubjectsDetail(id: id);

      Subjects data = Subjects.fromJson(response.data);
      return data;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    }
  }
}
