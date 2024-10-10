import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/controller.dart';
import 'package:lista_de_tarefas/tarefas_widget.dart';

class TarefasConcluidas extends StatelessWidget {
  final TaskController taskController;
  final Function(
    int,
    int,
  ) onReorder;
  final Function(int, List<String>) onDelete;
  final Function(String, List<String>) onAdd;
  final Function(int, List<String>, List<String>) onListExchange;
  final Function(int, List<String>, String) onEditTask;
  final Function(BuildContext, List<String>) onShowDialog;

  const TarefasConcluidas({
    super.key,
    required this.taskController,
    required this.onReorder,
    required this.onDelete,
    required this.onAdd,
    required this.onListExchange,
    required this.onEditTask,
    required this.onShowDialog,
  });

  @override
  Widget build(BuildContext context) {
    return TarefasWidget(
      corTitulo: const Color(0xFF388E3C), // Cor verde
      corIconeLixeira: Colors.red,
      tarefasOrigem: taskController.tarefasConcluidas,
      onReorder: onReorder,
      iconCheckBox: const Icon(Icons.check_box),
      onDelete: onDelete,
      onAdd: onAdd,
      onListExchange: onListExchange,
      tarefasDestino: taskController.tarefasNaoConcluidas,
      onEditTask: onEditTask,
      onShowDialog: onShowDialog,
    );
  }
}
