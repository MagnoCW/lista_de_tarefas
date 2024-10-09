import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/controller.dart';
import 'package:lista_de_tarefas/screens/tarefas_concluidas.dart';
import 'package:lista_de_tarefas/screens/tarefas_nao_concluidas.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _editingController = TextEditingController();

  final TaskController _taskController = TaskController();

  void _adicionarTarefa(String novaTarefa, List<String> lista) {
    setState(() {
      _taskController.adicionarTarefa(novaTarefa, lista);
    });
    _taskController.salvarArquivo();
    _reset();
  }

  void _reordenarTarefa(int oldIndex, int newIndex) {
    setState(() {
      _taskController.reordenarTarefa(
          oldIndex, newIndex, _taskController.tarefasNaoConcluidas);
    });
    _taskController.salvarArquivo();
  }

  void _deletarTarefa(int index, List<String> lista) {
    setState(() {
      _taskController.deletarTarefa(index, lista);
    });
    _taskController.salvarArquivo();
  }

  void _trocarTarefaDeLista(
      int index, List<String> origem, List<String> destino) {
    setState(() {
      _taskController.trocarTarefaDeLista(index, origem, destino);
    });
    _taskController.salvarArquivo();
  }

  void _editarTarefa(int index, List<String> lista, String novaTarefa) {
    setState(() {
      _taskController.editarTarefa(index, lista, novaTarefa);
    });
  }

  void _reset() {
    _editingController.clear();
    _taskController.labelText = 'Digite a nova tarefa';
    _taskController.alertDialogTitle = 'Adicionar Tarefa';
    _taskController.editingIndex = null;
  }

  void _mostrarDialogo(BuildContext context, List<String> lista1) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            _reset();
            return true;
          },
          child: AlertDialog(
            title: Text(_taskController.alertDialogTitle),
            content: TextField(
                controller: _editingController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: _taskController.labelText,
                )),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _adicionarTarefa(_editingController.text, lista1);
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
              TextButton(
                onPressed: () {
                  _reset();
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarDialogoAtivo(BuildContext context) {
    if (_tabController.index == 0) {
      _mostrarDialogo(context, _taskController.tarefasNaoConcluidas);
    } else if (_tabController.index == 1) {
      _mostrarDialogo(context, _taskController.tarefasConcluidas);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const AppBarTheme().backgroundColor,
        title: const Text(
          'Lista de Tarefas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(
                  Icons.radio_button_unchecked,
                  color: Color(0xFFD32F2F),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.check_circle,
                  color: Color(0xFF388E3C),
                ),
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TarefasNaoConcluidas(
            taskController: _taskController,
            onReorder: _reordenarTarefa,
            onDelete: _deletarTarefa,
            onAdd: _adicionarTarefa,
            onListExchange: _trocarTarefaDeLista,
            onEditTask: _editarTarefa,
            onShowDialog: _mostrarDialogo,
          ),
          TarefasConcluidas(
            taskController: _taskController,
            onReorder: _reordenarTarefa,
            onDelete: _deletarTarefa,
            onAdd: _adicionarTarefa,
            onListExchange: _trocarTarefaDeLista,
            onEditTask: _editarTarefa,
            onShowDialog: _mostrarDialogo,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogoAtivo(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
