part of 'students_cubit.dart';

class StudentsState extends Equatable {
  final bool isLoading;
  final bool isSucess;
  final bool isError;
  final String errorMessage;
  final List<Students> studentList;
  final List<SelectFieldType> dropDownItems;

  final Students? studentDetail;
  const StudentsState(
      {this.isLoading = false,
      this.errorMessage = '',
      this.studentDetail,
      this.dropDownItems = const [],
      this.isSucess = false,
      this.studentList = const [],
      this.isError = false});

  @override
  List<Object?> get props => [
        isLoading,
        isError,
        dropDownItems,
        isSucess,
        errorMessage,
        studentList,
        studentDetail
      ];

  StudentsState copyWith(
      {bool? isLoading,
      bool? isSucess,
      bool? isError,
      String? errorMessage,
      List<Students>? studentList,
      List<SelectFieldType>? dropDownItems,
      Students? studentDetail}) {
    return StudentsState(
        dropDownItems: dropDownItems ?? this.dropDownItems,
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        studentList: studentList ?? this.studentList,
        studentDetail: studentDetail ?? this.studentDetail,
        isSucess: isSucess ?? this.isSucess);
  }
}

// class StudentsInitial extends StudentsState {}
