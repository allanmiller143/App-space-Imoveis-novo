import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/Grid/HighligthedGridController.dart';
import 'package:space_imoveis/componentes/allHighligthedProperties/allHighligthedPropertiesFilter.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/pages/AppPages/allHighligthedProperties/allHighligthedPropertiesController.dart';

class HighligthedFiltersCards extends StatelessWidget {
  HighligthedFiltersCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Allhighligthedpropertiescontroller ahpc = Get.find();
    HighligthedGridController gridController = Get.find();
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Categorias',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ahpc.myGlobalController.color
                ),
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Color.fromARGB(115, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )
                    ),
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                        heightFactor: 0.75,
                        widthFactor: 1,
                        child: CustomDrawer(),
                      );
                    },
                  );
                },  
                child: Row(
                  children: [
                    Text(
                      'Abrir filtros',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ahpc.myGlobalController.color,
                        letterSpacing: 0.05,
                      ),
                    ), 
                    SizedBox(width: 5),                   
                    Icon(Icons.filter_list_outlined, color: const Color.fromARGB(255, 36, 36, 36), size: 15),

                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  ahpc.propertyType.value = 'Casa';
                  gridController.currentPage.value = 0;
                  gridController.fetchProperties();
                },
                child: FiltersCard(
                  filter: 'Casas',
                  icon: Icons.house,
                  selectedFilter: ahpc.propertyType,
                  value:'Casa',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ahpc.propertyType.value = 'Apartamento';
                  gridController.currentPage.value = 0;
                  gridController.fetchProperties();
                },                
                child: FiltersCard(
                  filter: 'Apartamentos',
                  icon: Icons.apartment,
                  selectedFilter: ahpc.propertyType,
                  value:'Apartamento',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ahpc.propertyType.value = 'Terreno';
                  gridController.currentPage.value = 0;
                  gridController.fetchProperties();
                },                  
                child: FiltersCard(
                  filter: 'Terrenos',
                  icon: Icons.terrain_outlined,
                  selectedFilter: ahpc.propertyType,
                  value:'Terreno',
                ),
              ),
              GestureDetector(
                onTap: () {
                  ahpc.propertyType.value = 'Fazenda';
                  gridController.currentPage.value = 0;
                  gridController.fetchProperties();
                },                  
                child: FiltersCard(
                  filter: 'Fazendas',
                  icon: Icons.agriculture,
                  selectedFilter: ahpc.propertyType,
                  value:'Fazenda',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FiltersCard extends StatelessWidget {
  final String filter;
  final IconData icon;
  RxString selectedFilter;
  String value;

  FiltersCard({
    Key? key,
    required this.filter,
    required this.value,
    required this.icon,
    required this.selectedFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyGlobalController controller = Get.find();
    return Column(
        children: [
          Obx(()=>
            Container(
              width: 75,
              height: 30,
              decoration: BoxDecoration(
                color: value == selectedFilter.value ? controller.color : controller.color2 ,
                borderRadius: BorderRadius.circular(120),
              ),
              child: Icon(
                icon,
                color: value == selectedFilter.value ? Colors.white: controller.color ,
                size: 20,
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            filter,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 51, 83, 91),
              letterSpacing: 0.05,
            ),
          ),
        ],
    );
  }
}
