
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_bloc/Bloc/todo_event.dart';
import 'package:todo_app_bloc/Bloc/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {


  TodoBloc() : super(TodoState(todolist: [], isloading: false, ischecked: [])) {
    on<Todoadd>(_add);
    on<Todoremove>(_remove);
    on<EnableDisable>(_switch);
    on<Isstoring>(_storedata);

    // Optional: to load from storage

    on<Checkbool>(_valuecheck);
    


  }
  Future<void>_add(Todoadd event,Emitter<TodoState>emit)async{
    final updatetodo=List<String>.from(state.todolist)..add(event.todo);

    final unchecked=List<bool>.from(state.ischecked)..add(false);

    await(_getdata(updatetodo));

    emit(state.copyWith(todolist: updatetodo,ischecked: unchecked));

    
  }

  Future<void> _remove(Todoremove event, Emitter<TodoState> emit) async {
 final updatetodo=List<String>.from(state.todolist)..removeAt(event.todo);
 final unchecked=List<bool>.from(state.ischecked)..removeAt(event.todo);
 await(_getdata(updatetodo));
 emit(state.copyWith(todolist: updatetodo,ischecked: unchecked));
}


Future<void>_storedata(Isstoring event,Emitter<TodoState>emit)async{
 final SharedPreferences prefs = await SharedPreferences.getInstance();

 final todosLoad = prefs.getStringList('todo') ?? [];
 final checkedInit = List<bool>.filled(todosLoad.length, false);
emit(state.copyWith(todolist: todosLoad,ischecked: checkedInit));
}



Future<void>_getdata(List<String>todo)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

     await prefs.setStringList('todo',todo);


}

Future<void> _switch(EnableDisable event, Emitter<TodoState> emit) async {
  final updatedChecked = List<bool>.filled(state.todolist.length, false);
  emit(state.copyWith(
    ischecked: updatedChecked,
    isloading: !state.isloading,

    
  ));
}

Future<void>_valuecheck(Checkbool event,Emitter<TodoState>emit)async{

  final checked=List<bool>.from(state.ischecked);
  checked[event.index]=!checked[event.index];

  emit(state.copyWith(ischecked: checked));
   await(_getdata);

}




}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:todo_app_bloc/Bloc/todo_event.dart';
// import 'package:todo_app_bloc/Bloc/todo_state.dart';

// class TodoBloc extends Bloc<TodoEvent, TodoState> {


//   TodoBloc() : super(TodoState(todolist: [], isloading: false, ischecked: [])) {
//     on<Todoadd>(_add);
//     on<Todoremove>(_remove);
//     on<EnableDisable>(_switch);
//     on<Isstoring>(_storedata);

//     // Optional: to load from storage

//     on<Checkbool>(_valuecheck);
    


//   }
//   Future<void>_add(Todoadd event,Emitter<TodoState>emit)async{
//     final updatetodo=List<String>.from(state.todolist)..add(event.todo);

//     final unchecked=List<bool>.from(state.ischecked)..add(false);

//     await(_getdata(updatetodo,unchecked));

//     emit(state.copyWith(todolist: updatetodo,ischecked: unchecked));

    
//   }

//   Future<void> _remove(Todoremove event, Emitter<TodoState> emit) async {
//  final updatetodo=List<String>.from(state.todolist)..removeAt(event.todo);
//  final unchecked=List<bool>.from(state.ischecked)..removeAt(event.todo);
//  await(_getdata(updatetodo,unchecked));
//  emit(state.copyWith(todolist: updatetodo,ischecked: unchecked));
// }


// Future<void> _storedata(Isstoring event, Emitter<TodoState> emit) async {

//    final prefs = await SharedPreferences.getInstance();
//   final todos = prefs.getStringList('todo') ?? [];
//   final checksAsString = prefs.getStringList('checklist') ?? [];
//   final checks = checksAsString.map((e) => e == 'true').toList();

//   // Fix mismatch if lengths differ
//   final safeChecks = checks.length == todos.length
//       ? checks
//       : List<bool>.filled(todos.length, false);

//   emit(state.copyWith(todolist: todos, ischecked: safeChecks));
//   // final SharedPreferences prefs = await SharedPreferences.getInstance();
//   // final todosLoad = prefs.getStringList('todo') ?? [];
//   // final checkStrings = prefs.getStringList('checklist') ?? [];
//   // final checks = checkStrings.map((e) => e == 'true').toList();

//   // // Safe fallback if lengths mismatch
//   // final fixedChecks = checks.length == todosLoad.length
//   //     ? checks
//   //     : List<bool>.filled(todosLoad.length, false);

//   // emit(state.copyWith(todolist: todosLoad, ischecked: fixedChecks));
// }

// // Future<void>_storedata(Isstoring event,Emitter<TodoState>emit)async{
// //  final SharedPreferences prefs = await SharedPreferences.getInstance();

// //  final todosLoad = prefs.getStringList('todo') ?? [];
// //  final checkedInit = List<bool>.filled(todosLoad.length, false);
// // emit(state.copyWith(todolist: todosLoad,ischecked: checkedInit));
// // }



// Future<void>_getdata(List<String>todo,List<bool>ischecked)async{
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setStringList('todo', todo);
//   final checksAsString = ischecked.map((e) => e.toString()).toList(); // Convert bool to "true"/"false"
//   await prefs.setStringList('checklist', checksAsString);
// }

// Future<void> _switch(EnableDisable event, Emitter<TodoState> emit) async {
//   final updatedChecked = List<bool>.filled(state.todolist.length, false);
//   emit(state.copyWith(
//     ischecked: updatedChecked,
//     isloading: !state.isloading,

    
//   ));
// }

// Future<void>_valuecheck(Checkbool event,Emitter<TodoState>emit)async{

//   final checked=List<bool>.from(state.ischecked);
//   checked[event.index]=!checked[event.index];

//   emit(state.copyWith(ischecked: checked));
//    await(_getdata);

// }




// }
