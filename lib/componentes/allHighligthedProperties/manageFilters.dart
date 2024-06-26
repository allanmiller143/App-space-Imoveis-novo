import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/Myproperties/ManagaDropDown.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/test.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/textfield.dart';
import 'package:space_imoveis/componentes/global_components/check_box_group.dart';
import 'package:space_imoveis/pages/AppPages/allHighligthedProperties/allHighligthedPropertiesController.dart';

class AllFilter extends StatelessWidget {
  AllFilter({Key? key}) : super(key: key);
  final Allhighligthedpropertiescontroller controller = Get.find();
  // Exemplo de lista de opções para os dropdowns
  final List<String> cities = ['Recife', 'São Paulo', 'Rio de Janeiro', 'Belo Horizonte'];
  RxBool commodities = false.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.isExpanded.value = !controller.isExpanded.value;
          },
          child: Container(
            color: Colors.transparent,
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                'Filtros',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              subtitle: Text(
                'Filtre entre seus próprios anúncios.',
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
        Obx(() => AnimatedSize(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Container(
                width: double.infinity,
                child: controller.isExpanded.value
                    ? Column(
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
                                child: ManageDropDown(
                                  controller: controller.advertsType,
                                  itens: controller.AdvertsTypeList,
                                  label: 'Tipo de anúncio',
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ManageTextField(
                                controller: controller.status,
                                label: 'Cidade',
                                width: 150,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: ManageDropDown(
                                  controller: controller.city,
                                  itens: controller.CityList,
                                  label: 'Cidade',
                                  width: double.infinity,
                                ),
                              ),
                            ],
                          ),
                          ExpansionTile(
                            initiallyExpanded: false,
                            title: Text(
                              'Comodidades',
                              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                            subtitle: Text(
                              'Selecione as comodidades que você deseja no seu imóvel',
                              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 10),
                            ),
                            childrenPadding: EdgeInsets.all(0),
                            tilePadding: EdgeInsets.all(0),
                            shape: Border.fromBorderSide(BorderSide.none),
                            expandedAlignment: Alignment.centerLeft,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: CheckBoxGroup(options: controller.options),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          CustomRadioChoice(
                            choices: {'Aluguel': 'Aluguel', 'Compra': 'Compra', 'Todas': 'Todas'},
                            onChange: (value) {
                              print('Selected: $value');
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // ação de limpar filtros
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
                                  // ação de filtrar
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
                    : Container(),
              ),
            )),
      ],
    );
  }
}
