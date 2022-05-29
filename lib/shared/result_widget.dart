import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final String unitText;
  final bool isTesting;
  final double downloadSpeed;
  final double uploadSpeed;
  
  const ResultWidget({ Key? key, 
    required this.unitText, 
    required this.isTesting, 
    required this.downloadSpeed, 
    required this.uploadSpeed 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isTesting ? 1 : 0, 
      duration: const Duration(milliseconds: 500),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                children: [
                  const ImageIcon(
                    AssetImage('assets/icons/download.png'),
                    color: Color.fromARGB(255, 106, 255, 243),
                  ),
                  const SizedBox(width: 5.0,),
                  const Text(
                    'DOWNLOAD',
                    style: TextStyle( color: Colors.white),
                  ),
                  const SizedBox(width: 5.0,),

                  Text(
                    unitText,
                    style: TextStyle(
                      color: Colors.grey[700]
                    ),
                  )
                ],
              ),       
              Text(
                downloadSpeed.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              )
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  const ImageIcon(
                    AssetImage('assets/icons/upload.png'),
                    color: Color.fromARGB(255, 149, 90, 201),
                  ),
                  const SizedBox(width: 5.0,),
                  const Text(
                    'UPLOAD',
                    style: TextStyle( color: Colors.white),
                  ),
                  const SizedBox(width: 5.0,),

                  Text(
                    unitText,
                    style: TextStyle(
                      color: Colors.grey[700]
                    ),
                  )
                ],
              ),
              Text(
                uploadSpeed.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}