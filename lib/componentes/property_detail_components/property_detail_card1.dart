import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PropertyDetailCard1Controller extends GetxController with GetTickerProviderStateMixin {
  var isExpanded = false.obs;
  var buttonText = 'Veja Mais'.obs;

  void toggleExpand() {
    isExpanded.value = !isExpanded.value;
    buttonText.value = isExpanded.value ? 'Veja Menos' : 'Veja Mais';
  }

  String formatNumber(dynamic number) {
    if (number == null) return 'N/A';
    final formatter = NumberFormat("#,##0", "pt_BR");
    return formatter.format(number);
  } 

  u(){
    update();
  }
}

class PropertyDetailCard1 extends StatelessWidget {
  final VoidCallback onPressed;
  var propertyData;

  final PropertyDetailCard1Controller controller = Get.put(PropertyDetailCard1Controller());

  PropertyDetailCard1({
    super.key,
    required this.onPressed,
    required this.propertyData,
  });

  @override
  Widget build(BuildContext context) {

    var comodities = [
      {
        'value' : 'Piscina',
        'isChecked' : propertyData['property']['pool'],
        'icon': propertyData['property']['pool'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Academia',
        'isChecked' : propertyData['property']['gym'],
        'icon': propertyData['property']['gym'] ? Icons.check_box : Icons.close,
      },      {
        'value' : 'Churrasqueira',
        'isChecked' : propertyData['property']['grill'],
        'icon': propertyData['property']['grill'] ? Icons.check_box : Icons.close,
      },
            {
        'value' : 'Ar condicionado',
        'isChecked' : propertyData['property']['air_conditioning'],
        'icon': propertyData['property']['air_conditioning'] ? Icons.check_box : Icons.close,
      },
            {
        'value' : 'Playground',
        'isChecked' : propertyData['property']['playground'],
        'icon': propertyData['property']['playground'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Área de eventos',
        'isChecked' : propertyData['property']['event_area'],
        'icon': propertyData['property']['event_area'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Área gourmet',	
        'isChecked' : propertyData['property']['gourmet_area'],
        'icon': propertyData['property']['gourmet_area'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'varanda',	
        'isChecked' : propertyData['property']['porch'],
        'icon': propertyData['property']['porch'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Jardin',	
        'isChecked' : propertyData['property']['garden'],
        'icon': propertyData['property']['garden'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Laje',	
        'isChecked' : propertyData['property']['slab'],
        'icon': propertyData['property']['slab'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Sacada',	
        'isChecked' : propertyData['property']['balcony'],
        'icon': propertyData['property']['balcony'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Condomínio fechado',	
        'isChecked' : propertyData['property']['solar_energy'],
        'icon': propertyData['property']['slab'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Portaria',	
        'isChecked' : propertyData['property']['concierge'],
        'icon': propertyData['property']['concierge'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Energia solar',	
        'isChecked' : propertyData['property']['solar_energy'],
        'icon': propertyData['property']['slab'] ? Icons.check_box : Icons.close,
      },
      {
        'value' : 'Quintal',	
        'isChecked' : propertyData['property']['yard'],
        'icon': propertyData['property']['yard'] ? Icons.check_box : Icons.close,
      },    

    ];

    return SizedBox(
      child: GestureDetector(
        onTap: () {
          controller.u();
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: const Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 221, 221, 221).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    propertyData['property']['property_type'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Preço negociável",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Icon(
                        propertyData['property']['negotiable'] ? Icons.check_circle : Icons.check_circle,
                        size: 18,
                        color: propertyData['property']['negotiable'] ? Colors.green : Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 2),
              Text(
                '${propertyData['property']['address']}- ${propertyData['property']['house_number']},${propertyData['property']['city']}-${propertyData['property']['state']}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 85, 85, 85),
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
              SizedBox(height: 5),
              if (propertyData['property_type'] != 'Terreno')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.bed_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                          SizedBox(width: 2),
                          Text(
                            propertyData['property']['bedrooms'].toString(),
                            style: TextStyle(fontSize: 14),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Row(
                        children: [
                          Icon(Icons.shower_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                          SizedBox(width: 2),
                          Text(
                            propertyData['property']['bathrooms'].toString(),
                            style: TextStyle(fontSize: 14),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Row(
                        children: [
                          Icon(Icons.garage_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                          SizedBox(width: 2),
                          Text(
                            propertyData['property']['parking_spaces'].toString(),
                            style: TextStyle(fontSize: 14),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Row(
                        children: [
                          Icon(Icons.area_chart_outlined, size: 20, color: const Color.fromARGB(255, 0, 0, 0)),
                          SizedBox(width: 2),
                          Text(
                            '${controller.formatNumber(propertyData['property']['size'])}m²',
                            style: TextStyle(fontSize: 14),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 8),
              Text(
                'Taxas extras',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
              Text(
                'IPTU: ${propertyData['property']['iptu'] == null ? 'R\$ 0,00' : 'R\$ ${controller.formatNumber(propertyData['property']['iptu'])}'}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 85, 85, 85),
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
              Text(
                'Taxas extras: ${propertyData['property']['aditional_fees'] == null ? 'R\$ 0,00' : 'R\$ ${controller.formatNumber(propertyData['property']['aditional_fees'])}'}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 85, 85, 85),
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
              SizedBox(height: 8),              
              Text(
                'Descrição',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                ),
              ),
              Obx(() => AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      propertyData['property']['description'],
                      maxLines: controller.isExpanded.value ? null : 3,
                      overflow: controller.isExpanded.value ? TextOverflow.visible : TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                      ),
                    ),
                    if (controller.isExpanded.value) ...[
                      SizedBox(height: 8),
                      Text(
                        'Comodidades',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                        ),
                      ),

                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                        shrinkWrap: true, // Allow GridView to shrink and expand
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          childAspectRatio: 6, // Adjust the aspect ratio to fit the Row's height
                        ),
                        itemCount: comodities.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0), // Adjust padding if necessary
                            child: Row(
                              children: [
                                Icon(
                                  comodities[index]['icon'],
                                  size: 18,
                                  color: comodities[index]['isChecked'] ? Colors.green : Colors.grey,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  comodities[index]['value'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: comodities[index]['isChecked'] ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ],
                ),
              )),
              Obx(() => GestureDetector(
                onTap: controller.toggleExpand,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          controller.buttonText.value,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, size: 20, color: Color.fromARGB(255, 0, 0, 0)),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
