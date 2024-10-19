import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController {
  List<String> tarefasNaoConcluidas = [];
  List<String> tarefasConcluidas = [];
  final TextEditingController editingController = TextEditingController();
  int? editingIndex;
  String labelText = 'Digite a nova tarefa';
  String alertDialogTitle = 'Adicionar Tarefa';

  Future<void> salvarArquivo() async {
    try {
      Map<String, List<String>> dados = {
        "tarefas_nao_concluidas": tarefasNaoConcluidas,
        "tarefas_concluidas": tarefasConcluidas,
      };

      String jsonDados = jsonEncode(dados);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('dados_tarefas', jsonDados);
    } catch (e) {
      print("Erro ao salvar as tarefas: $e");
    }
  }

  Future<void> lerArquivo(Function(List<String>) callback) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? jsonDados = prefs.getString('dados_tarefas');

      if (jsonDados != null) {
        final jsonMap = jsonDecode(jsonDados);
        tarefasNaoConcluidas =
            List<String>.from(jsonMap['tarefas_nao_concluidas']);
        tarefasConcluidas = List<String>.from(jsonMap['tarefas_concluidas']);
        callback(tarefasNaoConcluidas);
      } else {
        print("Nenhuma tarefa encontrada.");
      }
    } catch (e) {
      print("Erro ao ler as tarefas: $e");
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
    editingController.text = lista[index];
    editingIndex = index;
  }
}
