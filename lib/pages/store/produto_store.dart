import 'package:flutter/material.dart';
import 'package:rest_api_flutter/data/http/exceptions.dart';
import 'package:rest_api_flutter/data/model/produto_model.dart';
import 'package:rest_api_flutter/repositories/produto_repository.dart';

class ProdutoStore {
  final IProdutoRepository repository;

  //variavel reativa para loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  //variavel reativa para o state
  final ValueNotifier<List<ProdutoModel>> state =
      ValueNotifier<List<ProdutoModel>>([]);
  //variavel reativa de erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProdutoStore({required this.repository});

  getProdutos() async {
    isLoading.value = true;

    try {
      final result = await repository.getProduto();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isLoading.value = false;
  }
}
