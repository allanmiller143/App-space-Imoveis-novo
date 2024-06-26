import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingComment extends StatelessWidget {
  const LoadingComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 242, 242, 242),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 209, 209, 209).withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 223, 223, 223),
                    highlightColor: Color.fromARGB(255, 192, 192, 192),
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Color.fromARGB(255, 223, 223, 223),
                        highlightColor: Color.fromARGB(255, 192, 192, 192),
                        child: Container(
                          width: 100,
                          height: 10,
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(height: 4),
                      Shimmer.fromColors(
                        baseColor: Color.fromARGB(255, 223, 223, 223),
                        highlightColor: Color.fromARGB(255, 192, 192, 192),
                        child: Container(
                          width: 150,
                          height: 10,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
            Shimmer.fromColors(
              baseColor: Color.fromARGB(255, 223, 223, 223),
              highlightColor: Color.fromARGB(255, 192, 192, 192),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 4),
                width: double.infinity,
                height: 10,
                color: Colors.grey[300],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
