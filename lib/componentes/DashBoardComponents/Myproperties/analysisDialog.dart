import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:space_imoveis/componentes/global_components/Dialogs/AlertDialog/alert_header.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class DialogController extends GetxController {
  var activeStep = 0.obs;

  void initializeSteps(String verifiedStatus) {
    if (verifiedStatus == 'pending') {
      activeStep.value = 0;
    } else if (verifiedStatus == 'verified' || verifiedStatus == 'rejected') {
      activeStep.value = 1;
    }
  }
}


class DashBoardWaitingAvaliationProperties extends StatelessWidget {
  final bool open;
  final VoidCallback handleClose;
  final Map<String, dynamic> property;
  final VoidCallback func;

  DashBoardWaitingAvaliationProperties({
    Key? key,
    required this.open,
    required this.handleClose,
    required this.property,
    required this.func,
  }) : super(key: key);

  final DialogController controller = Get.put(DialogController());

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> steps = [
      {
        'label': 'Anúncio sob análise',
        'description': 'Seu anúncio está sob análise. Em breve entraremos em contato para confirmar seu anúncio.',
      },
    ];

    if (property['verified'] == 'rejected') {
      steps.add({
        'label': 'Anúncio recusado',
        'description': 'Infelizmente, seu anúncio foi recusado. Verifique os requisitos e tente novamente.\n\nMotivo: ${property['reason']['reason']}',
      });
    }

    if (property['verified'] != 'rejected') {
      steps.add({
        'label': 'Anúncio publicado',
        'description': 'Seu anúncio foi revisado e publicado.',
      });
    }

    controller.initializeSteps(property['verified']);

    MyGlobalController mgc = Get.find();

    return Obx(() {
      if (!open) return SizedBox.shrink();

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AlertDialogHeader(
              title: 'Situação do auúncio',
              close: () {
                handleClose();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.light(
                    primary: mgc.color,
                  ),
                ),
                child: Stepper(
                  elevation: 2,
                  currentStep: controller.activeStep.value,
                  controlsBuilder: (context, details) {
                    return Container();
                  },
                  steps: steps
                      .map(
                        (step) => Step(
                          title: Text(step['label']!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400)),
                          content: Text(step['description']!, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w300)),
                          isActive: controller.activeStep.value >= steps.indexOf(step),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
