import 'package:flutter/material.dart';
import 'package:space_imoveis/componentes/global_components/snack_bar.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class MyAppBar extends StatelessWidget {
  final MyGlobalController myGlobalController;
  const MyAppBar(
    {
      super.key,
      required this.myGlobalController,
    }
  );

  @override
  Widget build(BuildContext context) {
    return 
      (myGlobalController.userInfo != null && myGlobalController.userInfo['type'] != 'client'  ) ? Row(
        children: [
          Expanded(
            child: Text(
              'Space, sempre novas oportunidades!',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white

              )
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: (){
              mySnackBar('Funcionalidade indisponível', true);
            },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: myGlobalController.userInfo['profile'] != null
                      ? NetworkImage(myGlobalController.userInfo['profile']['url']) as ImageProvider
                      : AssetImage('assets/imgs/logo.png') as ImageProvider,
                ),
                Text(
                  'Meu espaço',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  )
                ),
              ],
            ),
          )
        ],
      ):
      Text(
        'Seus sonhos e negocios começam aqui!',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white
        )    
    );
  }
}