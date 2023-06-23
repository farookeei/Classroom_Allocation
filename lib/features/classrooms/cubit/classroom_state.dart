part of 'classroom_cubit.dart';

class ClassroomState extends Equatable {
  final bool isLoading;
  final bool isSucess;
  final bool isError;
  final String errorMessage;
  final List<Classrooms> classRoomsList;
  final Classrooms? classRoomDetail;
  const ClassroomState(
      {this.isLoading = false,
      this.errorMessage = '',
      this.isSucess = false,
      this.classRoomDetail,
      this.classRoomsList = const [],
      this.isError = false});

  @override
  List<Object?> get props => [
        isLoading,
        isError,
        isSucess,
        errorMessage,
        classRoomsList,
        classRoomDetail
      ];

  ClassroomState copyWith({
    bool? isLoading,
    bool? isSucess,
    bool? isError,
    String? errorMessage,
    Classrooms? classRoomDetail,
    List<Classrooms>? classRoomsList,
  }) {
    return ClassroomState(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        classRoomsList: classRoomsList ?? this.classRoomsList,
        classRoomDetail: classRoomDetail ?? this.classRoomDetail,
        isSucess: isSucess ?? this.isSucess);
  }
}

// class StudentsInitial extends StudentsState {}




// 