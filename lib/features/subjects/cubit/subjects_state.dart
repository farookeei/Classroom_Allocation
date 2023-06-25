part of 'subjects_cubit.dart';

class SubjectsState extends Equatable {
  final bool isLoading;
  final bool isSucess;
  final bool isError;
  final String errorMessage;
  final List<Subjects> subjectsList;
  final List<SelectFieldType> dropDownItems;
  final Subjects? subjectDetail;
  const SubjectsState(
      {this.isLoading = false,
      this.errorMessage = '',
      this.isSucess = false,
      this.subjectDetail,
      this.dropDownItems = const [],
      this.subjectsList = const [],
      this.isError = false});

  @override
  List<Object?> get props => [
        isLoading,
        isError,
        isSucess,
        dropDownItems,
        errorMessage,
        subjectsList,
        subjectDetail
      ];

  SubjectsState copyWith({
    bool? isLoading,
    bool? isSucess,
    bool? isError,
    String? errorMessage,
    Subjects? subjectDetail,
    List<Subjects>? subjectsList,
    List<SelectFieldType>? dropDownItems,
  }) {
    return SubjectsState(
        isError: isError ?? this.isError,
        isLoading: isLoading ?? this.isLoading,
        dropDownItems: dropDownItems ?? this.dropDownItems,
        errorMessage: errorMessage ?? this.errorMessage,
        subjectsList: subjectsList ?? this.subjectsList,
        subjectDetail: subjectDetail ?? this.subjectDetail,
        isSucess: isSucess ?? this.isSucess);
  }
}
