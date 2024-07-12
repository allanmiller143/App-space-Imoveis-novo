import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:space_imoveis/componentes/global_components/Dialogs/AlertDialog/alert_dialog.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/api.dart';
import 'package:space_imoveis/services/firebase_login.dart';

class MyDrawer extends StatelessWidget {
  final MyGlobalController myGlobalController;

  const MyDrawer(
    {
      super.key,
      required this.myGlobalController,
    }
  );

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/'); // Navega para a tela de login e remove todas as outras da pilha

  }

  Future<void> deleteAccount() async {
    String route = '';
    if(myGlobalController.userInfo['type'] == 'realtor'){
      route = 'realtors';
    }else if(myGlobalController.userInfo['type'] == 'client'){
      route = 'clients';
    }else if(myGlobalController.userInfo['type'] == 'owner'){
      route = 'owners';
    }else{
      route = 'realState';
    }

    try{
      var response = await delete('${route}/${myGlobalController.userInfo['email']}',myGlobalController.token);
      if(response['status'] == 200 || response['status'] == 201){
        print('Conta apagada com sucesso');
        logout();
        mySnackBar('Conta deletada com sucesso', true);

      }else{
        print('status: ${response['status']}, message: ${response['message']}');
      } 
    }catch(e){
      print(e);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    MyGlobalController myGlobalController = Get.find();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
            UserAccountsDrawerHeader(
            decoration:  BoxDecoration(
              color: myGlobalController.color,
        
            ),
            accountName:  Text(
              myGlobalController.userInfo['type'] == 'realstate' ? myGlobalController.userInfo['company_name'] : myGlobalController.userInfo['name'],
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 20,
                fontWeight: FontWeight.w400
              ),
            ),
            accountEmail:  Text(
              myGlobalController.userInfo['email'],
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 13,
                fontWeight: FontWeight.w300
              ),
            ),
            currentAccountPicture : 
            CircleAvatar(
              backgroundImage: myGlobalController.userInfo['profile'] != null &&
                      myGlobalController.userInfo['profile']['url'] != ''
                  ? NetworkImage(
                      myGlobalController.userInfo['profile']['url'],
                    ) as ImageProvider<Object>
                  : AssetImage(
                      'assets/imgs/logo.png',
                    ),
            ),
            currentAccountPictureSize: const Size(70, 70),

          ),
          ListTile(
            leading: Icon(
              Icons.auto_graph_outlined,
              color: myGlobalController.color,
            ),
            title: const Text(
              'Meu espaço',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w300
              ),
            ),
            onTap: () {
              Get.toNamed('/main_dash');
            },
          ),          
          // ListTile(
          //   leading: Icon(Icons.favorite,color: myGlobalController.color,),
          //   title: const Text(
          //     'Favoritos',
          //     style: const TextStyle(
          //       color: Colors.black,
          //       fontSize: 13,
          //       fontWeight: FontWeight.w300
          //     ),
          //   ),
          //   onTap: () {
              
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.photo,color: myGlobalController.color,),
          //   title: const Text(
          //     'Inserir Foto de Perfil',
          //     style: const TextStyle(
          //       color: Colors.black,
          //       fontSize: 13,
          //       fontWeight: FontWeight.w300
          //     ),
          //   ),
          //   onTap: () {

          //   },
          // ),
          ListTile(
            leading: Icon(Icons.person,color: myGlobalController.color,),
            title: const Text(
              'Editar Perfil',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w300
              ),
            ),
            onTap: () {
              Get.toNamed('/edit_profile_data');
            },
          ),
          ListTile(
            leading:const  Icon(Icons.delete,color: Colors.red,),
            title:const  Text(
              'Excluir Conta',
              style: TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.w300
              ),
            ),
            onTap: () {
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MyAlertDialog(
                    title: 'Tem certeza que deseja excluir sua conta?',
                    subtitle: 'Ao excluir sua conta, todos os seus dados serão excluídos.\nIncluindo, dados pessoais, imoveis cadastrados e imagens.\n\nTem certeza de que deseja continuar?',
                    onSend: () {
                      deleteAccount();},
                  );
                },
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.logout,color: myGlobalController.color,),
            title: const  Text(
              'Sair',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w300
              ),
            ),
            onTap: () async {
              await signOut();
              await logout();
            }
          ),
        ],
      ),
    );
  }
}