import 'dart:convert';

import 'package:rest_api_flutter/data/http/exceptions.dart';
import 'package:rest_api_flutter/data/http/http_client.dart';
import 'package:rest_api_flutter/data/model/produto_model.dart';

abstract class IProdutoRepository {
  Future<List<ProdutoModel>> getProduto();
}

class ProdutoRepository implements IProdutoRepository {
  final IHttpClient client;
  ProdutoRepository({required this.client});

  @override
  Future<List<ProdutoModel>> getProduto() async {
    final response = await client.get(url: "https://dummyjson.com/product");

    if (response.statusCode == 200) {
      final List<ProdutoModel> produtos = [];
      final body = jsonDecode(response.body);

      body['products'].map((item) {
        final ProdutoModel produto = ProdutoModel.fromMap(item);
        produtos.add(produto);
      }).toList();
      return produtos;
    } else if (response.statusCode == 404) {
      throw NotFoundException('URL informada não é válida');
    } else {
      throw Exception('Não foi possível carregar lista de produtos');
    }
  }
}
