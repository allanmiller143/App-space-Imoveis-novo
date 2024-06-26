import 'package:flutter/material.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';

class Charts extends StatelessWidget {
  final List data;
  final String title;

  Charts({Key? key, required this.data, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyGlobalController mgc = MyGlobalController();

    if (data.isEmpty) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Text(
          'Não há dados disponíveis',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: mgc.color),
        ),
      );
    }

    // Encontrar o valor máximo para calcular a proporção das barras
    int maxValue = data.map<int>((e) => e['value'] as int).reduce((max, value) => max > value ? max : value);

    // Definir os valores para a barra fixa
    double fixedBarHeight = 100.0; // Altura da barra fixa
    double intermediate1 = 0.25 * maxValue; // Primeiro valor intermediário
    double intermediate2 = 0.75 * maxValue; // Segundo valor intermediário

    return Container(
      height:175,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: mgc.color2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: mgc.color),
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end, // Alinha as barras com a base
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(maxValue.toString(), style: TextStyle(color: mgc.color, fontSize: 8)),
                  Container(
                    width: 1,
                    height: fixedBarHeight,
                  ),
                  Text('', style: TextStyle(color: mgc.color, fontSize: 10)),
                ],
              ),
              SizedBox(width: 2),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('', style: TextStyle(color: mgc.color, fontSize: 8)),
                  Container(
                    width: 1,
                    height: fixedBarHeight,
                    color: mgc.color,
                  ),
                  SizedBox(height: 5),
                  Text('', style: TextStyle(color: mgc.color, fontSize: 10)),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end, // Alinha as barras com a base
                    children: [
                      for (int i = 0; i < data.length; i++)
                        _buildBar(context, data[i]['month'] as String, data[i]['value'] as int, maxValue, fixedBarHeight, intermediate1, intermediate2),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, String month, int value, int maxValue, double fixedBarHeight, double intermediate1, double intermediate2) {
    double maxBarHeight = 100; // Altura máxima da barra
    double barHeight = (value / maxValue) * maxBarHeight; // Altura proporcional à barra mais alta
    MyGlobalController myGlobalController = MyGlobalController();

    return GestureDetector(
      onTap: () {
        // Aqui você pode adicionar a lógica desejada ao clicar na barra
        print('Barra clicada: $month - $value');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: maxBarHeight - barHeight), // Adiciona espaço superior para posicionar a barra
          Text(value.toString(), style: TextStyle(color: myGlobalController.color, fontSize: 10)),
          Stack(
            children: [
              Container(
                width: 45,
                height: barHeight,
                margin: EdgeInsets.symmetric(horizontal: 4), // Espaçamento horizontal entre as barras
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ), // Arredondamento das bordas
                  color: myGlobalController.color,
                ),
              ),
            ],
          ),
          Container(
            width: 45,
            height: 1,
            color: myGlobalController.color,
          ),
          SizedBox(height: 5),
          Text(
            month.substring(0, 3), // Mostrar apenas as primeiras 3 letras do mês
            style: TextStyle(color: myGlobalController.color, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
