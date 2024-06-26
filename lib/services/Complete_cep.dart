
// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'dart:convert';

Future<Map<String, dynamic>> searchCep(String cep) async {
  
  final url = Uri.parse('https://viacep.com.br/ws/$cep/json/'); // passo 1 - difinir a url de dados
  http.Response response; 
  try{
      response = await http.get(url); //passo 3 efetar a requisição
  Map<String, dynamic> dados = {};

  if (response.statusCode == 200) {
    // manipular os dados que estao em formato de json.
    dados = json.decode(response.body);
    print(dados);
    if(dados['erro'] == true){
      dados = {
      "cep": "",
      "logradouro": "",
      "bairro": "",
      "localidade": "",
      "uf": "",
      "ddd": ""
    };
        
    }
  }return dados;

  } catch(error){
    return   {
      "cep": "",
      "logradouro": "",
      "bairro": "",
      "localidade": "",
      "uf": "",
      "ddd": ""
    };
  }

}
  
