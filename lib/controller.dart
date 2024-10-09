import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class TaskController {
  List<String> tarefasNaoConcluidas = [];
  List<String> tarefasConcluidas = [];
  int? editingIndex;
  String labelText = 'Digite a nova tarefa';
  String alertDialogTitle = 'Adicionar Tarefa';

  Future<File> _getFile() async {
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  Future<void> salvarArquivo() async {
    try {
      Map<String, List<String>> dados = {
        "tarefas_nao_concluidas": tarefasNaoConcluidas,
        "tarefas_concluidas": tarefasConcluidas
      };

      String jsonDados = jsonEncode(dados);
      var arquivo = await _getFile();
      await arquivo.writeAsString(jsonDados);
    } catch (e) {
      print("Erro ao salvar o arquivo: $e");
    }
  }

  Future<void> lerArquivo() async {
    try {
      final arquivo = await _getFile();
      if (await arquivo.exists()) {
        final dados = await arquivo.readAsString();
        final jsonMap = jsonDecode(dados);

        tarefasNaoConcluidas =
            List<String>.from(jsonMap['tarefas_nao_concluidas']);
        tarefasConcluidas = List<String>.from(jsonMap['tarefas_concluidas']);
      } else {
        print("Arquivo não encontrado");
      }
    } catch (e) {
      print("Erro ao ler o arquivo: $e");
    }
  }

  void adicionarTarefa(String novaTarefa, List<String> lista) {
    if (novaTarefa.isNotEmpty) {
      if (editingIndex != null) {
        lista[editingIndex!] = novaTarefa;
      } else {
        lista.add(novaTarefa);
      }
    }
  }

  void trocarTarefaDeLista(
      int index, List<String> origem, List<String> destino) {
    destino.add(origem[index]);
    origem.removeAt(index);
  }

  void deletarTarefa(int index, List<String> lista) {
    lista.removeAt(index);
  }

  void reordenarTarefa(int oldIndex, int newIndex, List<String> lista) {
    if (newIndex > oldIndex) newIndex--;
    final item = lista.removeAt(oldIndex);
    lista.insert(newIndex, item);
  }

  void editarTarefa(int index, List<String> lista, String novaTarefa) {
    labelText = 'Editando a tarefa';
    alertDialogTitle = 'Editar Tarefa';
    novaTarefa = lista[index];
    editingIndex = index;
  }
}
