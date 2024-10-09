import 'package:flutter/material.dart';

class TarefasWidget extends StatelessWidget {
  final String titulo;
  final Color corTitulo;
  final Color corIconeLixeira;
  final List<String> tarefasOrigem;
  final List<String> tarefasDestino;
  final Function(int, int) onReorder;
  final Icon iconCheckBox;
  final Function(int, List<String>) onDelete;
  final Function(String, List<String>) onAdd;
  final Function(int, List<String>, List<String>) onListExchange;
  final Function(int, List<String>, String) onEditTask;
  final Function(BuildContext, List<String>) onShowDialog;

  const TarefasWidget({
    super.key,
    required this.titulo,
    required this.corTitulo,
    required this.corIconeLixeira,
    required this.tarefasOrigem,
    required this.tarefasDestino,
    required this.onReorder,
    required this.iconCheckBox,
    required this.onDelete,
    required this.onAdd,
    required this.onListExchange,
    required this.onEditTask,
    required this.onShowDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: corTitulo,
          ),
        ),
        Expanded(
          child: ReorderableListView(
            onReorder: onReorder,
            children: [
              for (int index = 0; index < tarefasOrigem.length; index++)
                Card(
                  key: ValueKey(index),
                  surfaceTintColor: corTitulo,
                  child: ListTile(
                    title: Text(tarefasOrigem[index]),
                    leading: IconButton(
                      icon: iconCheckBox,
                      onPressed: () {
                        onListExchange(index, tarefasOrigem, tarefasDestino);
                      },
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            onEditTask(
                                index, tarefasOrigem, tarefasOrigem[index]);
                            onShowDialog(context, tarefasOrigem);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            String ultimaTarefaDeletada = tarefasOrigem[index];
                            onDelete(index, tarefasOrigem);
                            final snackBar = SnackBar(
                              action: SnackBarAction(
                                label: 'Desfazer',
                                onPressed: () {
                                  onAdd(ultimaTarefaDeletada, tarefasOrigem);
                                },
                              ),
                              content: const Text('Tarefa Removida'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          icon: const Icon(Icons.delete),
                          color: corIconeLixeira,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
