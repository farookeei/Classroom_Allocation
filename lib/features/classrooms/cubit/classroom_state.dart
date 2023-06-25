part of 'classroom_cubit.dart';

class ClassroomState extends Equatable {
  final bool isLoading;
  final bool isSucess;
  final bool isError;
  final bool isRegistering;
  final bool isRegisteringSucess;
  final bool isRegisteringError;
  final bool isRemovingRegist;
  final bool isRemovingRegistSucess;
  final bool isRemovingRegistError;
  final String errorMessage;
  final List<Classrooms> classRoomsList;
  final List<Registrations> registrations;
  final Classrooms? classRoomDetail;
  const ClassroomState(
      {this.isLoading = false,
      this.errorMessage = '',
      this.isSucess = false,
      this.classRoomDetail,
      this.isRegistering = false,
      this.isRegisteringSucess = false,
      this.isRegisteringError = false,
      this.isRemovingRegist = false,
      this.isRemovingRegistError = false,
      this.isRemovingRegistSucess = false,
      this.classRoomsList = const [],
      this.registrations = const [],
      this.isError = false});

  @override
  List<Object?> get props => [
        isLoading,
        isError,
        isSucess,
        errorMessage,
        classRoomsList,
        classRoomDetail,
        isRegistering,
        isRegisteringSucess,
        registrations,
        isRegisteringError,
        isRemovingRegist,
        isRemovingRegistSucess,
        isRemovingRegistError
      ];

  ClassroomState copyWith({
    bool? isLoading,
    bool? isSucess,
    bool? isError,
    String? errorMessage,
    Classrooms? classRoomDetail,
    List<Classrooms>? classRoomsList,
    bool? isRegistering,
    bool? isRegisteringSucess,
    bool? isRegisteringError,
    bool? isRemovingRegist,
    bool? isRemovingRegistSucess,
    bool? isRemovingRegistError,
    List<Registrations>? registrations,
  }) {
    return ClassroomState(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        classRoomsList: classRoomsList ?? this.classRoomsList,
        classRoomDetail: classRoomDetail ?? this.classRoomDetail,
        isRegisteringError: isRegisteringError ?? this.isRegisteringError,
        isRegistering: isRegistering ?? this.isRegistering,
        isRegisteringSucess: isRegisteringSucess ?? this.isRegisteringSucess,
        isSucess: isSucess ?? this.isSucess,
        isRemovingRegist: isRemovingRegist ?? this.isRemovingRegist,
        isRemovingRegistError: isRegisteringError ?? this.isRegisteringError,
        isRemovingRegistSucess:
            isRegisteringSucess ?? this.isRemovingRegistSucess,
        registrations: registrations ?? this.registrations);
  }
}

// class StudentsInitial extends StudentsState {}




// 