import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:space_imoveis/componentes/realtors24hours/filters.dart';
import 'package:space_imoveis/componentes/realtors24hours/grid.dart';
import 'package:space_imoveis/componentes/realtors24hours/realState/RealStateFilter.dart';
import 'package:space_imoveis/componentes/realtors24hours/realState/RealStateGrid.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class MenuController extends GetxController {
  var selectedIndex = 0.obs;

  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}

class CustomMenuExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MenuController menuController = Get.put(MenuController());
    MyGlobalController mgc = Get.find();
    return Column(
      children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: mgc.color
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
                        child: Obx(
                          () => 
                           menuController.selectedIndex.value == 0 ?
                          RealtorsFilter(): RealStateFilter() 
                        ),
                      );
                    },
                  );
                },  
                child: Row(
                  children: [
                    Text(
                      'FIltrar',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: mgc.color,
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
        SizedBox(height: 10),
        Obx(() => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => menuController.setSelectedIndex(0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      decoration: BoxDecoration(
                        color: menuController.selectedIndex.value == 0
                            ? mgc.color
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Corretores',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => menuController.setSelectedIndex(1),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      decoration: BoxDecoration(
                        color: menuController.selectedIndex.value == 1
                            ? mgc.color
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Imobiliárias',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(height: 20),
        Obx(() => menuController.selectedIndex.value == 0
            ? RealtorRealStateGrid(title: '',)
            : RealStateGrid(title: '',)
        ),
      ],
    );
  }

}