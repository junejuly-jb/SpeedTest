import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    double ping = data['responseTime'] / 5;

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
          children: [
            const SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: ImageIcon(
                            AssetImage('assets/icons/ping.png'),
                            color: Color.fromARGB(255, 255, 243, 142),
                          )
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.0),
                        child: Text('PING', style: TextStyle(color: Colors.white54, letterSpacing: 1.0, fontSize: 12.0),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(ping.toString(),
                            style: TextStyle( color: Colors.white, fontSize: 18.0),
                          ),
                          Text('ms', style: TextStyle( color: Colors.white54, fontSize: 14.0),)
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.0),
                        child: Text('DOWNLOAD', style: TextStyle(color: Colors.white54, letterSpacing: 1.0, fontSize: 12.0),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data['download'].toString(),
                            style: const TextStyle( color: Colors.white, fontSize: 18.0),
                          ),
                          const Text('Mbps', style: TextStyle( color: Colors.white54, fontSize: 14.0),)
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.0),
                        child: Text('UPLOAD', style: TextStyle(color: Colors.white54, letterSpacing: 1.0, fontSize: 12.0),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(data['upload'].toString(),
                            style: const TextStyle( color: Colors.white, fontSize: 18.0),
                          ),
                          const Text('Mbps', style: TextStyle( color: Colors.white54, fontSize: 14.0),)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // margin: EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.white)
                  ),
                  child: ImageIcon(
                    AssetImage('assets/icons/${data['connectionType']}.png'),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 25.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['isp'], style: const TextStyle( color: Colors.white, fontSize: 18.0),),
                    const SizedBox(height: 5.0,),
                    Text(data['phoneModel'], style: const TextStyle( color: Colors.white38, fontWeight: FontWeight.w300),)
                  ],
                ),
                const SizedBox(width: 25.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data['date'], style: const TextStyle( color: Colors.white),),
                    const SizedBox(height: 5.0,),
                    Text(data['time'], style: const TextStyle( color: Colors.white),)
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