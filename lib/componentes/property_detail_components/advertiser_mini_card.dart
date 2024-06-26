import 'package:flutter/material.dart';

class AdvertiserMiniCard extends StatelessWidget {
  final VoidCallback onPressed;
  var advertiserData;

  AdvertiserMiniCard({
    super.key,
    required this.onPressed,
    required this.advertiserData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 221, 221, 221).withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 50,
                  height: 50,
                  child: advertiserData['seller']['profile'] != null && advertiserData['seller']['profile']['url'] != ''
                      ? Image.network(
                          advertiserData['seller']['profile']['url'],
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/imgs/corretor.jpg',
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      advertiserData['seller']['name'],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Veja o perfil do anunciante',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 85, 85, 85),
                        fontFamily: 'SourceSerif4-VariableFont_opsz,wght',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
