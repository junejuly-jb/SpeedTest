import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 21, 38),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 20, 21, 38),
        title: const Text('RESULTS', 
          style: TextStyle( color: Colors.white, fontSize: 20.0, letterSpacing: 2.0 )
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.close)),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ImageIcon(
                          AssetImage('assets/icons/down-big.png'),
                          color: Color.fromARGB(255, 106, 255, 243),
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('80 Mbps',
                        style: TextStyle( color: Colors.white54, fontSize: 17.0),
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ImageIcon(
                          AssetImage('assets/icons/up-big.png'),
                          color: Color.fromARGB(255, 149, 90, 201),
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('80 Mbps',
                        style: TextStyle( color: Colors.white54, fontSize: 17.0),
                      ),
                    )
                  ],
                ),
                Column(
                  children: const [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: ImageIcon(
                          AssetImage('assets/icons/up-big.png'),
                          color: Color.fromARGB(255, 149, 90, 201),
                        )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text('80 Mbps',
                        style: TextStyle( color: Colors.white54, fontSize: 18.0),
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 80.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ImageIcon(
                  AssetImage('assets/icons/wifi.png'),
                  color: Colors.white,
                ),
                const SizedBox(width: 25.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('GLOBE', style: TextStyle( color: Colors.white, fontSize: 18.0),),
                    SizedBox(height: 5.0,),
                    Text('YAL-L21', style: TextStyle( color: Colors.white38, fontWeight: FontWeight.w300),)
                  ],
                ),
                const SizedBox(width: 25.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('12/01/12', style: TextStyle( color: Colors.white),),
                    SizedBox(height: 5.0,),
                    Text('Friday 20, 2022', style: TextStyle( color: Colors.white),)
                  ],
                )
              ],
            ), 
          ],
        ),
      ),
    );
  }
}