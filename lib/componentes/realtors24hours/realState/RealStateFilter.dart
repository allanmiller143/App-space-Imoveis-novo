import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/textfield.dart';
import 'package:space_imoveis/componentes/realtors24hours/realState/realStateController.dart';

class RealStateFilter extends StatelessWidget {
  RealStateFilter({Key? key}) : super(key: key);
  final RealtorRealStateGridRealStateController controller = Get.find();
  RxBool commodities = false.obs;


  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.25,
        padding: EdgeInsets.all(10),

      child: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(3,5,3,5),
              child: Text(
                'Filtros',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
          
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ManageTextField(
                        controller: controller.name,
                        label: 'Nome',
                        width: 250,
        
                      ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ManageTextField(
                        controller: controller.city,
                        label: 'Cidade',
                        width: double.maxFinite,
        
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.name.text = '';
                        controller.city.text = '';
      
                        controller.fetchProperties();
                        Navigator.pop(context); // Close the modal
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Limpar filtros',
                          style: TextStyle(
                            color: Color.fromARGB(255, 10, 59, 84),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        controller.currentPage.value = 0;
                        controller.fetchProperties();
                        Navigator.pop(context); // Close the modal
        
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 12, 74, 105),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Filtrar',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            )
             
          ],
        ),
      ),
    );
  }
}
