import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../widgets/custom_dropdown.dart';
import '../data/model/students_model.dart';
import '../data/repository/students_repo.dart';

part 'students_state.dart';

class StudentsCubit extends Cubit<StudentsState> {
  StudentsCubit() : super(const StudentsState());

  final StudentsRepository _studentsRepository = StudentsRepository();

  Future<void> getStudentlist() async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
    ));
    try {
      StudentsModel studentList =
          await _studentsRepository.getStudentsListRepo();

      List<SelectFieldType> dropDownItems =
          convertToDropdownItems(studentList.students);
      emit(state.copyWith(
          isSucess: true,
          dropDownItems: dropDownItems,
          studentList: studentList.students,
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }

  List<Students> returnStudentList() {
    List<Students> studentsList = [...state.studentList];
    return studentsList;
  }

  List<SelectFieldType> convertToDropdownItems(List<Students>? students) {
    List<SelectFieldType> items = [];
    for (int i = 0; i < students!.length; i++) {
      items.add(SelectFieldType(
          label: students[i].name!, value: students[i].id!.toString()));
    }

    return items;
  }

  Future<void> getStudentDetail({required String id}) async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
    ));
    try {
      Students studentDetail =
          await _studentsRepository.getStudentsDetailRepo(id: id);
      emit(state.copyWith(
          isSucess: true, studentDetail: studentDetail, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }
}
