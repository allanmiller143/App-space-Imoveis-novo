import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'dart:async';
import 'dart:convert'; // Para usar jsonEncode
import 'package:space_imoveis/services/api.dart';
import 'package:http/http.dart' as http;

class ChatService extends GetxService {
  final IO.Socket socket;

  ChatService(this.socket);

  Future<List<dynamic>> openNewChat(String email) async {
    MyGlobalController myGlobalController = Get.find();
    final token = myGlobalController.token;
    final response = await postChat('chat/$email', {}, token: token);

    if (response['status'] == 200 || response['status'] == 201) {
      final chatId = response['body']['id']?.toString();

      if (chatId != null) {
        await _storeChatId(chatId);

        final data = {
          'email': email,
          'chatId': chatId,
        };

        return await _emitOpenChat(data);
      }
    } else {
      print('Request failed with status: ${response['status']}');
    }

    return [];
  }

  Future<void> _storeChatId(String chatId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('chatId', chatId);
  }

  Future<List<dynamic>> _emitOpenChat(Map<String, dynamic> data) async {
    final completer = Completer<List<dynamic>>();

    // Emitir o evento sem converter para JSON string
    socket.emitWithAck('open_chat', data, ack: (response) {
      // Decodificar a resposta corretamente
      if (response is String) {
        final decodedResponse = jsonDecode(response);
        completer.complete(decodedResponse);
      } else if (response is List) {
        completer.complete(response);
      } else {
        completer.completeError('Invalid response type');
      }
    });

    return completer.future;
  }

  // Função para enviar mensagem
  void sendMessage(String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? chatId = prefs.getString('chatId');
    MyGlobalController myGlobalController = Get.find();
    String email = myGlobalController.userInfo['email'];
    
    if (chatId != null) {
      final data = {
        'email': email,
        'chatId': chatId,
        'message': message,
      };

      socket.emit('message', data);
    } else {
      print('Chat ID not found.');
    }
  }
}

Future<Map<String, dynamic>> postChat(String route, var data, {String token = ''}) async {
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


