import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/Myproperties/ManagaDropDown.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/Grid/HighligthedGridController.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/MinMax.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/test.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/textfield.dart';
import 'package:space_imoveis/componentes/global_components/check_box_group.dart';
import 'package:space_imoveis/pages/AppPages/allHighligthedProperties/allHighligthedPropertiesController.dart';

class AllFilter extends StatelessWidget {
  AllFilter({Key? key}) : super(key: key);
  final Allhighligthedpropertiescontroller controller = Get.find();
  HighligthedGridController hgc = Get.find();
  // Exemplo de lista de opções para os dropdowns
  RxBool commodities = false.obs;


  @override
  Widget build(BuildContext context) {
    return Column(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ManageDropDown(
                  controller: controller.state,
                  itens: controller.StateList,
                  label: 'Estado',
                  width: 100,
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
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ManageDropDown(
                    controller: controller.bedrooms,
                    itens: controller.numberList,
                    label: 'Quartos',
                    width: MediaQuery.of(context).size.width * 0.45,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ManageDropDown(
                    controller: controller.bathrooms,
                    itens: controller.numberList,
                    label: 'Banheiros',
                    width:  MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ManageDropDown(
                    controller: controller.parkingSpaces,
                    itens: controller.numberList,
                    label: 'Vagas',
                    width: MediaQuery.of(context).size.width * 0.45,
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),


            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tipo de imóvel', style: TextStyle(color: Colors.white, fontSize: 10)),
                    SizedBox(height: 5),
                    CustomRadioChoice(
                      choices: {'Aluguel': 'Aluguel', 'Compra': 'Compra', 'Todas': 'Todas'},
                      onChange: (value) {
                        print('Selected: $value');
                      },
                      item: controller.advertsType,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tipo de Anuncio', style: TextStyle(color: Colors.white, fontSize: 10)),
                    SizedBox(height: 5),
                    CustomRadioChoice(
                      choices: {'Casa': 'Casa', 'Apartamento': 'Apartamento', 'Fazenda': 'Fazenda', 'Terreno': 'Terreno'},
                      onChange: (value) {
                        print('Selected: $value');
                      },
                      item: controller.propertyType,

                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            PriceSlider(
              label: 'Selecione uma faixa de preço',
              min: controller.minValue,
              max: controller.maxValue,
            ),
            SizedBox(height: 10),
            PriceSlider(
              label: 'Selecione a área ideal ',
              min: controller.minSize,
              max: controller.maxSize,
            ),

            GestureDetector(
              onTap: () {
                controller.isExpanded.value = !controller.isExpanded.value;
              },
              child: Container(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Comodidades',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  subtitle: Text(
                    'Filtre todas as comodidades que deseja no seu Imóvel',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: Obx(() => Icon(
                    controller.isExpanded.value
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.white,
                  )),
                ),
              ),
            ),

            Obx(()=>
                AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: controller.isExpanded.value ?
                  Container(
                    width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CheckBoxGroup(options: controller.options),
                ): Container()
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.propertyType.value = '';
                    controller.advertsType.value = '';
                    controller.state.value = '';
                    controller.city.text = '';
                    controller.bathrooms.value = '';
                    controller.bedrooms.value = '';
                    controller.parkingSpaces.value = '';
                    controller.minValue.text = '';
                    controller.maxValue.text = '';
                    controller.minSize.text = '';
                    controller.maxSize.text = '';
                    controller.isExpanded.value = false;
                    for (var option in controller.options) {
                      if(option['checked'] == true){
                        option['checked'] = false;
                      }
                    }
                    hgc.fetchProperties();
                    Navigator.pop(context); // Close the modal
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      'Limpar Filtrar',
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
                    hgc.currentPage.value = 0;
                    hgc.fetchProperties();
                    Navigator.pop(context); // Close the modal

                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
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
    );
  }
}
