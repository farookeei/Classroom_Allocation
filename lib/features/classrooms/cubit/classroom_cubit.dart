import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_sample/features/classrooms/data/repository/classrooms_repo.dart';

import '../data/model/classrooms_model.dart';

part 'classroom_state.dart';

class ClassroomCubit extends Cubit<ClassroomState> {
  ClassroomCubit() : super(const ClassroomState());
  final ClassroomsRepository _classRoomsRepository = ClassroomsRepository();

  Future<void> getClassRoomslist() async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
    ));
    try {
      ClassroomsModel classRoomsList =
          await _classRoomsRepository.getClassRoomsListRepo();
      emit(state.copyWith(
          isSucess: true,
          classRoomsList: classRoomsList.classrooms,
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> getClassRoomDetail({required String id}) async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
    ));
    try {
      Classrooms detail =
          await _classRoomsRepository.getClassRoomDetailRepo(id: id);
      emit(state.copyWith(
          isSucess: true, classRoomDetail: detail, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> addSubjectToClass(
      {required String classId, required String subjectId}) async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
    ));
    try {
      await _classRoomsRepository.addSubjectToClassRepo(
          classId: classId, subjectId: subjectId);
      await getClassRoomDetail(id: classId);
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }

  // addSubjectToClassRepo
}