import 'package:flutter/material.dart';
import 'package:primeiro/Tarefa.dart';


class TaskInherite extends InheritedWidget {
  TaskInherite({
    Key? key,
    required Widget child,
  }) : super(key: key,child: child);

  final List<Task> taskList = [
    Task("Estudar Flutter",'assets/estudo.jpg', 5,),
    Task("Treinar",'assets/treina.jpg', 4,),
    Task('Beber água', "assets/como-beber-mais-agua.webp", 2,),
    Task('Organizar estante', "assets/orga.webp", 1,),];

    void newTask(String nome, String foto, int dificuldade){
    taskList.add(Task(nome, foto, dificuldade,));
  }

  static TaskInherite of(BuildContext context) {
    final TaskInherite? result = context.dependOnInheritedWidgetOfExactType<TaskInherite>();
    assert(result != null, 'No TaskInherite found in context');
    return result!;
  }

  ///o bool avisa quando a task é alterada
  ///verifica se a taskList muda de comprimento da lista e se mudar ele avisa
  @override
  bool updateShouldNotify(TaskInherite oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}