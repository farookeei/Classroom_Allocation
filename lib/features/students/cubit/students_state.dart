part of 'students_cubit.dart';

class StudentsState extends Equatable {
  final bool isLoading;
  final bool isSucess;
  final bool isError;
  final String errorMessage;
  final List<Students> studentList;
  const StudentsState(
      {this.isLoading = false,
      this.errorMessage = '',
      this.isSucess = false,
      this.studentList = const [],
      this.isError = false});

  @override
  List<Object> get props =>
      [isLoading, isError, isSucess, errorMessage, studentList];

  StudentsState copyWith({
    bool? isLoading,
    bool? isSucess,
    bool? isError,
    String? errorMessage,
    List<Students>? studentList,
  }) {
    return StudentsState(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        studentList: studentList ?? this.studentList,
        isSucess: isSucess ?? this.isSucess);
  }
}

// class StudentsInitial extends StudentsState {}
