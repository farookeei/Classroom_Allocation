import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../shared/data/students/model/students_model.dart';
import '../../../shared/data/students/repository/students_repo.dart';

part 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(const StudentsState());

  final StudentsRepository _studentsRepository = StudentsRepository();

  Future<void> getStudentlist() async {
    emit(state.copyWith(
      isLoading: true,
    ));
    try {
      StudentsModel studentList =
          await _studentsRepository.getStudentsListRepo();
      emit(state.copyWith(
          isSucess: true, studentList: studentList.students, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }
}
