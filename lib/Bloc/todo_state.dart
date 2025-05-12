import 'package:equatable/equatable.dart';

class TodoState extends Equatable {
  final List<String> todolist;
  final List<bool> ischecked;
  final bool isloading;

  const TodoState({
    required this.todolist,
    required this.ischecked,
    required this.isloading,
  });

  TodoState copyWith({
    List<String>? todolist,
    List<bool>? ischecked,
    bool? isloading,
  }) {
    return TodoState(
      todolist: todolist ?? this.todolist,
      ischecked: ischecked ?? this.ischecked,
      isloading: isloading ?? this.isloading,
    );
  }

  @override
  List<Object?> get props => [todolist, ischecked, isloading];
}
