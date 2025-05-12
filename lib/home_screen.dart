

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc/Bloc/todo_bloc.dart';
import 'package:todo_app_bloc/Bloc/todo_event.dart';
import 'package:todo_app_bloc/Bloc/todo_state.dart';
import 'package:todo_app_bloc/theme_notifier.dart';

class HomeScreen extends StatefulWidget{
   final ThemeNotifier themeNotifier;
  const HomeScreen({super.key, required this.themeNotifier});
  @override

  State<HomeScreen>createState()=>_HomeScreen();
}

class _HomeScreen extends State<HomeScreen>{


  
  @override
void initState() {
  super.initState();
  context.read<TodoBloc>().add(Isstoring()); // ✅ Safely dispatch event from UI
}

  TextEditingController data=TextEditingController();
  @override
  Widget build(BuildContext context) {
          final isDark = widget.themeNotifier.value == ThemeMode.dark;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
      
        actions: [
          // BlocBuilder<TodoBloc,TodoState>(builder: (context, State) {
          //   // return Switch(
          //   //   activeColor: Colors.white70,
          //   //   activeTrackColor: Colors.black,
              
          //   //   value: State.isloading, onChanged: (newvalue){
          //   //     context.read<TodoBloc>().add(EnableDisable());
            
          //   //   }
          //   // );
            
          // },

           IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              widget.themeNotifier.toggleTheme();
            },
            
          ),
        ],
        title: Text("TODO APP"),
      ),
      // ignore: avoid_types_as_parameter_names
      body: BlocBuilder<TodoBloc,TodoState>(builder: (context,State){
        return State.todolist.isEmpty ? Center(child: Text("NO TASK ADDED"),) :  ListView.builder(
          itemCount: State.todolist.length,
          itemBuilder: (BuildContext context,int index){
            final tododata=State.todolist[index];

            return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12), // space between tiles
      padding: const EdgeInsets.all(12), // inner padding inside the tile
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent[100], // background color of each tile
        borderRadius: BorderRadius.circular(12),),
              child: ListTile(
                contentPadding: EdgeInsets.all(5),
              minTileHeight: 10,
                minVerticalPadding: 5.0,
                tileColor: Colors.blueAccent,
                        
              
                leading: Checkbox(
                  checkColor: Colors.greenAccent,
                  activeColor: Colors.black,
                  
                  value:State.ischecked[index], onChanged: ( newvalue){
                  context.read<TodoBloc>().add(Checkbool(index));
              
              
               
                }),
              
                
              
              
                title: Text(tododata,style: TextStyle(
                  decoration:State.ischecked[index]? TextDecoration.lineThrough :null
                ),),
                trailing:State.ischecked[index]? InkWell(
                  onTap: (){
                       context.read<TodoBloc>().add(Todoremove(todo:index));
                  },
                   child: Icon(
                    color: Colors.red,
                    Icons.delete)):null,
              ),
            );


            // return CheckboxListTile(
              
            //   title: Text(tododata,style: TextStyle(decoration: ischeckeds ? TextDecoration.lineThrough :null),),
            //   value: ischeckeds, onChanged: (value){
            //     context.read<TodoBloc>().add(Checkbool(checkvalue: value !, index: index));
            // });










          });

      }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.red,
        elevation: 20,
        
        onPressed:(){
        showDialog(context: context, builder:(BuildContext context){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Center(
                child: AlertDialog(
                  backgroundColor: Colors.blueGrey,
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                             content: TextField(
                              
                              
                controller: data,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "ADD TASK"
                ),
              
                             ),
                
                             actions: [
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                  

                    ),
                    onPressed: (){
                      if(data.text.isEmpty){
                        return;
                      }
                    context.read<TodoBloc>().add(Todoadd(todo: data.text));
                    data.clear();
                    Navigator.pop(context);
                  }, child: Text("ADD",style: TextStyle(color: Colors.blueAccent),)),
                )
                             ],
                             
                             
                
                ),
              ),
          ],
          );

        });
        
        // showModalBottomSheet(context: context, builder:(context){
        //   return Column(
        //     children: [
        //       TextField(
        //         controller: data,
        //         decoration: InputDecoration(
        //        hintText: "ADD TASK",
        //        filled: true,
        //        fillColor: Colors.white70,
        //         ),
        //       ),
        //       ElevatedButton(onPressed: (){

        //         context.read<TodoBloc>().add(Todoadd(todo: data.text));
        //       }, child: Text("ADD"))
        //     ],
        //   );
          
        // });

      },child: Icon(
    
        color: Colors.white,
        Icons.add,
        
        ), ),
    );
  }
}