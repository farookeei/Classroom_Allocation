import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_sample/app/routes/routes.dart';
import 'package:test_sample/features/classrooms/data/repository/classrooms_repo.dart';
import 'package:test_sample/features/students/cubit/students_cubit.dart';
import 'package:test_sample/features/students/data/model/students_model.dart';

import '../../../shared/data/registration/model/registration_model.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../students/data/repository/students_repo.dart';
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
      //? so filtering registrations work after changing subjects
      await getRegistrations();
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }

  void addCurrentClassSubject(String subId) {
    emit(state.copyWith(currentClassSub: subId));
  }

  Future<void> postStudentRegistration(
      {required String studentId,
      required String subjectId,
      required String classId}) async {
    emit(state.copyWith(
      isRegistering: true,
      isRegisteringError: false,
    ));
    try {
      await _classRoomsRepository.postStudentRegistrationRepo(
          studentId: studentId, subjectId: subjectId);
      emit(state.copyWith(isRegistering: false, isRegisteringSucess: true));
      // await getClassRoomDetail(id: classId);
      //? for updating the registrations list
      await getRegistrations();
    } catch (e) {
      emit(state.copyWith(
          isRegisteringError: true,
          isRegistering: false,
          errorMessage: e.toString().contains("already enrolled")
              ? "Student is already enrolled"
              : e.toString()));
    }
  }

  Future<void> deleteStudentRegistration({required String regId}) async {
    emit(state.copyWith(
      isRemovingRegist: true,
      isRemovingRegistError: false,
    ));
    try {
      await _classRoomsRepository.deleteStudentregistationRepo(regId: regId);
      emit(state.copyWith(
          isRemovingRegist: false,
          isRegisteringSucess: true,
          isRemovingRegistError: true));

      getRegistrations();
      // await getClassRoomDetail(id: classId);
    } catch (e) {
      emit(state.copyWith(
          isRegisteringError: true,
          isRemovingRegist: false,
          errorMessage: e.toString()));
    }
  }

  Future<void> getRegistrations() async {
    emit(state.copyWith(
      isLoading: true,
      isError: false,
    ));
    try {
      RegistrationsModel data =
          await _classRoomsRepository.getStudentRegistrationsRepo();

      StudentsModel studentsModel;
      studentsModel = await StudentsRepository().getStudentsListRepo();
      List<Students> studentList = studentsModel.students!;
      // StudentsRepository
      List<SelectFieldType> selections = [];

//* for updating student registations in dropdown
      for (int i = 0; i < data.registrations!.length; i++) {
        if (data.registrations![i].subject.toString() ==
            state.classRoomDetail!.subject.toString()) {
          for (int j = 0; j < studentList.length; j++) {
            if (data.registrations![i].student.toString() ==
                studentList[j].id.toString()) {
              selections.add(SelectFieldType(
                  label: studentList[j].name.toString(),
                  value: data.registrations![i].id.toString()));

              break;
            }
          }
        }
      }
      emit(state.copyWith(
          isSucess: true,
          registrationsSelections: selections,
          registrations: data.registrations,
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(
          isError: true, isLoading: false, errorMessage: e.toString()));
    }
  }
}
