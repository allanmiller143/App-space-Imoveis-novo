import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/DashBoardComponents/Myproperties/ManagaDropDown.dart';
import 'package:space_imoveis/pages/DashBoardPages/MyPropertiesPage/MyPropertiesPageController.dart';

class ManageFilter extends StatelessWidget {
  ManageFilter({Key? key}) : super(key: key);
  final MyPropertiesPageController controller = Get.find();
  // Example list of options for the dropdowns
  final List<String> cities = ['Recife', 'São Paulo', 'Rio de Janeiro', 'Belo Horizonte'];

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
              duration: Duration(milliseconds: 300),
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
                            children: [
                              ManageDropDown(
                                controller: controller.status,
                                itens: controller.StatusList,
                                label: 'Status',
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
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Obx(() => CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.all(0),
                                      checkColor: Color.fromARGB(255, 255, 255, 255),
                                      activeColor: Color.fromARGB(255, 57, 112, 15),
                                      visualDensity: VisualDensity(horizontal: -4.0, vertical: 0),
                                      title: Text(
                                        'Compartilhados',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                        ),
                                      ),
                                      side: BorderSide(color: Colors.black),
                                      value: (controller.shared == '' || controller.shared == 'Meus') ? false : true,
                                      onChanged: (bool? value) {
                                        controller.shared.value = (controller.shared == '' || controller.shared == 'Meus') ? 'Compartilhados' : 'Meus';
                                      },
                                    )),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Obx(() => CheckboxListTile(
                                      controlAffinity: ListTileControlAffinity.leading,
                                      contentPadding: EdgeInsets.all(0),
                                      checkColor: Color.fromARGB(255, 255, 255, 255),
                                      activeColor: Color.fromARGB(255, 57, 112, 15),
                                      visualDensity: VisualDensity(horizontal: -4.0, vertical: 0),
                                      title: Text(
                                        'Meus',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color.fromARGB(255, 255, 255, 255),

                                        ),
                                      ),
                                      side: BorderSide(color: Colors.black),
                                      value: (controller.shared == '' || controller.shared == 'Compartilhados') ? false : true,
                                      onChanged: (bool? value) {
                                        controller.shared.value = (controller.shared == '' || controller.shared == 'Compartilhados') ? 'Meus' : 'Compartilhados';
                                      },
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.cleanFilters();
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
                                  controller.getUserProperties(context);
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
