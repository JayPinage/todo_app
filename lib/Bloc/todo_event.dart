

import 'package:equatable/equatable.dart';

class TodoEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Todoadd extends TodoEvent{
  final String todo;
  Todoadd({required this.todo});

    @override
  // TODO: implement props
  List<Object?> get props => [todo];
}


class Todoremove extends TodoEvent{
  final int todo;
  Todoremove({required this.todo});

      @override
  // TODO: implement props
  List<Object?> get props => [todo];
}

class EnableDisable extends TodoEvent{
}

class Isstoring extends TodoEvent{
  // final String todo;
  // Isstoring(this.todo);
}



class Checkbool extends TodoEvent{
  final int index;

  Checkbool(this.index) ;
}
class FetchStored extends TodoEvent {}