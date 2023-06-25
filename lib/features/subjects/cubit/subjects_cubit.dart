import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_sample/features/subjects/data/repository/subject_repo.dart';

import '../../../widgets/custom_dropdown.dart';
import '../data/model/subjects_model.dart';

part 'subjects_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  SubjectsCubit() : super(const SubjectsState());

  final SubjectRepository _subRepo = SubjectRepository();

  Future<void> getSubjectslist() async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
    ));
    try {
      SubjectsModel subjectList = await _subRepo.getSubjectsListRepo();
      List<SelectFieldType> dropDownItems =
          convertToDropdownItems(subjectList.subjects);
      emit(state.copyWith(
          isSucess: true,
          dropDownItems: dropDownItems,
          subjectsList: subjectList.subjects,
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }

  List<SelectFieldType> convertToDropdownItems(List<Subjects>? subjects) {
    List<SelectFieldType> items = [];
    for (int i = 0; i < subjects!.length; i++) {
      items.add(SelectFieldType(
          label: subjects[i].name!, value: subjects[i].id!.toString()));
    }

    return items;
  }

  Future<void> getSubjectDetail({required String id}) async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
    ));
    try {
      Subjects detail = await _subRepo.getSubjectDetailRepo(id: id);
      emit(state.copyWith(
          isSucess: true, subjectDetail: detail, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }
}
