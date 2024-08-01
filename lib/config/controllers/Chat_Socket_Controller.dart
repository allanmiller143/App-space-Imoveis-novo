import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat_Socket_Controller extends GetxController {
  late IO.Socket socket;
  var messages = [].obs;
  RxInt messagesSize = 0.obs;
  
  @override
  void onInit() {
    super.onInit();
    initSocket();
  }

  void initSocket() {
    socket = IO.io('https://spaceimoveis-api-8lin.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('connect');
      // Adicione qualquer lógica que você queira executar ao conectar
    });

    socket.onDisconnect((_) {
      print('disconnect');
      // Adicione qualquer lógica que você queira executar ao desconectar
    });

    socket.on('message', (data) {
      print('message: $data');
      messages.removeWhere((message) => message['id'] == 1);
      messages.insert(0, data);

    });
  }

  @override
  void onClose() {
    socket.dispose();
    super.onClose();
  }
}
