import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_sample/shared/data/classrooms/repository/classrooms_repo.dart';

import '../../../shared/data/classrooms/model/classrooms_model.dart';

part 'classroom_state.dart';

class ClassroomCubit extends Cubit<ClassroomState> {
  ClassroomCubit() : super(const ClassroomState());
  final ClassroomsRepository _classRoomsRepository = ClassroomsRepository();

  Future<void> getClassRoomslist() async {
    emit(state.copyWith(
      isLoading: true,
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
}
