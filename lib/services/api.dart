// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
String URL = 'https://spaceimoveis-api-8lin.onrender.com/';



get(String route, {String? token}) async {
  final url = Uri.parse('$URL$route');

  try {
    // Define os headers, adicionando o token se for fornecido
    final headers = {
      'ngrok-skip-browser-warning': '1',
      if (token != null && token.isNotEmpty) 'x-access-token': token,
    };

    final response = await http.get(url, headers: headers);
    final status = response.statusCode;
    final data = json.decode(response.body);

    return {'status': status, 'data': data};
  } catch (error) {
    if (error is http.Response) {
      final message = json.decode(error.body)['message'];
      final status = error.statusCode;
      return {'message': message, 'status': status};
    } else {
      print('Erro na requisição: $error');
      return {'message': 'Erro na requisição', 'status': 500};
    }
  }
}

post(String route, var data, {String token = ''}) async {
  final url = Uri.parse('$URL$route');
  try {
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-access-token': token,
      },
      body: jsonEncode(data),
    );

    // Decodificar o corpo da resposta
    Map<String, dynamic> responseBody = json.decode(response.body) as Map<String, dynamic>;
    
    return {
      'status': response.statusCode,
      'body': responseBody,
    };
  } catch (error) {
    // Em caso de erro, retornar o status e uma mensagem de erro
    print(error.toString());
    return {
      'status': 500,
      'body': {'error': error.toString()},
    };
    
  }
}

Future<Map<String, dynamic>> postFormData(String route, Map<String, dynamic> postDataExample, String token) async {
  final url = Uri.parse('$URL$route');
  var request = http.MultipartRequest('POST', url);

  // Append form data
  request.fields['data'] = json.encode(postDataExample);

  // Add headers
  request.headers['Content-Type'] = 'multipart/form-data';
  request.headers['x-access-token'] = token;

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);
      return {
        'message': responseData['message'],
        'status': response.statusCode,
        'data': responseData['data'],
      };
    } else {
      var errorData = json.decode(response.body);
      return {
        'message': errorData['message'],
        'status': response.statusCode,
      };
    }
  } catch (error) {
    print('Error: $error');
    return {
      'message': 'An error occurred',
      'status': 500,
    };
  }
}

Future<Map<String, dynamic>> putFormData(String route, File file, String token, {Map<String, String> fields = const {}}) async {
  final url = Uri.parse('$URL$route');

  print('URL: $url');

  var request = http.MultipartRequest('PUT', url);

  // Adicionar cabeçalhos
  request.headers['Content-Type'] = 'multipart/form-data';
  request.headers['x-access-token'] = token;

  // Adicionar campos do formulário, se houver
  fields.forEach((key, value) {
    request.fields[key] = value;
  });

  // Adicionar arquivo
  if (file.existsSync()) {
    request.files.add(await http.MultipartFile.fromPath('photo', file.path));
  } else {
    print('File is null or does not exist.');
  }

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);
      return {
        'message': responseData['message'],
        'status': response.statusCode,
      };
    } else {
      var errorData = json.decode(response.body);
      return {
        'message': errorData['message'] ?? 'An error occurred',
        'status': response.statusCode,
      };
    }
  } catch (error) {
    print('Error: $error');
    return {
      'message': 'An error occurred',
      'status': 500,
    };
  }
}

put(String route, Map<String, dynamic> data, {String? token}) async {
  final url = Uri.parse('$URL$route');  
  try {
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'x-access-token': token,
    };

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return {
        'data': json.decode(response.body),
        'message': 'Deu bom',
        'status': response.statusCode
        };
        
    } else {
      print('Falha na atualização: ${response.statusCode}');
      return {
        'status': response.statusCode,
        'message': response.body,
      };
    }
  } catch (error) {
    print('Erro na requisição: $error');
    return {
      'status': 'error',
      'message': error.toString(),
    };
  }
}


Future<Map<String, dynamic>> putFormDataA(String route, Map<String, dynamic> formData, String token) async {
  final url = Uri.parse('$URL$route');
  var request = http.MultipartRequest('PUT', url);

  // Append form data
  request.fields['data'] = json.encode(formData);

  // Add headers
  request.headers['Content-Type'] = 'multipart/form-data';
  request.headers['x-access-token'] = token;

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);
      return {
        'message': responseData['message'],
        'status': response.statusCode,
        'data': responseData['data'],
      };
    } else {
      var errorData = json.decode(response.body);
      return {
        'message': errorData['message'],
        'status': response.statusCode,
      };
    }
  } catch (error) {
    print('Error: $error');
    return {
      'message': 'An error occurred',
      'status': 500,
    };
  }
}

delete(String route, String token) async {
  final url = Uri.parse('$URL$route');
  try {
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'x-access-token': token,
      },
    );

    // Tentativa de decodificar o corpo da resposta
    try {
      final decodedBody = jsonDecode(response.body);
      
      // Verificar se a resposta decodificada é um mapa e contém a chave 'message'
      if (decodedBody is Map<String, dynamic> && decodedBody.containsKey('message')) {
        final message = decodedBody['message'];
        final status = response.statusCode;
        return {'message': message, 'status': status};
      } else {
        // Se não for um mapa válido ou não contém a chave 'message', tratar como erro
        const message = 'Resposta inesperada do servidor.';
        const status = 400;
        return {'message': message, 'status': status};
      }
    } catch (e) {
      // Se a decodificação falhar, tratar como um erro
      const message = 'Resposta inválida do servidor.';
      final status = response.statusCode;
      return {'message': message, 'status': status};
    }
  } catch (error) {
    // Tratamento de erros para requisições HTTP
    const message = 'Ocorreu um erro inesperado. Tente novamente mais tarde.';
    const status = 400;
    return {'message': message, 'status': status};
  }
}




Future<Map<String, dynamic>> postFormDataWithFiles(
  String route,
  Map<String, dynamic> postData,
  List<XFile> photoFiles, // Use List<XFile> instead of RxList<XFile>
  XFile coverFile, // Use XFile instead of File
  String token,
) async {
  final url = Uri.parse('$URL$route');

  var request = http.MultipartRequest('POST', url);

  // Append form data
  request.fields['data'] = json.encode(postData);

  // Append photo files
  for (var xfile in photoFiles) {
    var file = File(xfile.path); // Convert XFile to File
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartFile = http.MultipartFile(
      'photo', // Name of the form field
      stream,
      length,
      filename: file.path.split('/').last, // Extract the file name
    );
    request.files.add(multipartFile);
  }

  // Append cover file
  var coverFileConverted = File(coverFile.path); // Convert XFile to File
  var coverStream = http.ByteStream(coverFileConverted.openRead());
  var coverLength = await coverFileConverted.length();
  var coverMultipartFile = http.MultipartFile(
    'cover', // Name of the form field
    coverStream,
    coverLength,
    filename: coverFileConverted.path.split('/').last, // Extract the file name
  );
  request.files.add(coverMultipartFile);

  // Add headers
  request.headers['Content-Type'] = 'multipart/form-data';
  request.headers['x-access-token'] = token;

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);
      return {
        'message': responseData['message'],
        'status': response.statusCode,
        'data': responseData['data'],
      };
    } else {
      var errorData = json.decode(response.body);
      return {
        'message': errorData['message'],
        'status': response.statusCode,
      };
    }
  } catch (error) {
    print('Error: $error');
    return {
      'message': 'An error occurred',
      'status': 500,
    };
  }
}


Future<Map<String, dynamic>> putFormDataWithFiles(
  String route,
  Map<String, dynamic> postData, 
  String token,
  {
  List<XFile>? photoFiles,
  XFile? coverFile,
  }) async {
  final url = Uri.parse('$URL$route');
  var request = http.MultipartRequest('PUT', url);

  // Append form data
  request.fields['data'] = json.encode(postData);

  // Append photo files if provided
  if (photoFiles != null) {
    for (var xfile in photoFiles) {
      var file = File(xfile.path); // Convert XFile to File
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        'photo', // Name of the form field
        stream,
        length,
        filename: file.path.split('/').last, // Extract the file name
      );
      request.files.add(multipartFile);
    }
  }

  // Append cover file if provided
  if (coverFile != null) {
    var coverFileConverted = File(coverFile.path); // Convert XFile to File
    var coverStream = http.ByteStream(coverFileConverted.openRead());
    var coverLength = await coverFileConverted.length();
    var coverMultipartFile = http.MultipartFile(
      'cover', // Name of the form field
      coverStream,
      coverLength,
      filename: coverFileConverted.path.split('/').last, // Extract the file name
    );
    request.files.add(coverMultipartFile);
  }

  // Add headers
  request.headers['Content-Type'] = 'multipart/form-data';
  request.headers['x-access-token'] = token;

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      var responseData = json.decode(response.body);
      return {
        'message': responseData['message'],
        'status': response.statusCode,
        'data': responseData['data'],
      };
    } else {
      var errorData = json.decode(response.body);
      return {
        'message': errorData['message'],
        'status': response.statusCode,
      };
    }
  } catch (error) {
    print('Error: $error');
    return {
      'message': 'An error occurred',
      'status': 500,
    };
  }
}

