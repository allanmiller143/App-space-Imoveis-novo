import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class FiltersCards extends StatelessWidget {
  FiltersCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: const Color.fromARGB(255, 36, 36, 36),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Todos');
                  Get.toNamed('all_highligthed_property', arguments: ['']);
                },  
                child: Text(
                  'Veja todos',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 36, 36, 36),
                    letterSpacing: 0.05,
                  ),
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
                  print('casas');
                  Get.toNamed('all_highligthed_property', arguments: ['Casa']);
                },
                child: FiltersCard(
                  filter: 'Casas',
                  icon: Icons.house,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Apartamentos');
                  Get.toNamed('all_highligthed_property', arguments: ['Apartamento']);
                },                
                child: FiltersCard(
                  filter: 'Apartamentos',
                  icon: Icons.apartment,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Terrenos');
                  Get.toNamed('all_highligthed_property', arguments: ['Terreno']);
                },                  
                child: FiltersCard(
                  filter: 'Terrenos',
                  icon: Icons.terrain_outlined,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Fazendas');
                  Get.toNamed('all_highligthed_property', arguments: ['Fazenda']);
                },                  
                child: FiltersCard(
                  filter: 'Fazendas',
                  icon: Icons.agriculture,
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

  FiltersCard({
    Key? key,
    required this.filter,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyGlobalController controller = Get.find();
    return Column(
      children: [
        Container(
          width: 75,
          height: 30,
          decoration: BoxDecoration(
            color: controller.color,
            borderRadius: BorderRadius.circular(120),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 90, 136, 149),
                spreadRadius: 0,
                blurRadius: 0.5,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 20,
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
