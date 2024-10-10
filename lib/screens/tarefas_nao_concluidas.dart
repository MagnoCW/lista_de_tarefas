import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/controller.dart';
import 'package:lista_de_tarefas/tarefas_widget.dart';

class TarefasNaoConcluidas extends StatelessWidget {
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

  const TarefasNaoConcluidas({
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
      corTitulo: const Color(0xFFD32F2F), // Cor vermelha
      corIconeLixeira: Colors.red,
      tarefasOrigem: taskController.tarefasNaoConcluidas,
      onReorder: onReorder,
      iconCheckBox: const Icon(Icons.check_box_outline_blank),
      onDelete: onDelete,
      onAdd: onAdd,
      onListExchange: onListExchange,
      tarefasDestino: taskController.tarefasConcluidas,
      onEditTask: onEditTask,
      onShowDialog: onShowDialog,
    );
  }
}
