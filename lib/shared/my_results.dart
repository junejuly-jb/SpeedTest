import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speedtest/model/result.dart';

class MyResults extends StatefulWidget {
  const MyResults({ Key? key }) : super(key: key);

  @override
  State<MyResults> createState() => _MyResultsState();
}

class _MyResultsState extends State<MyResults> {

  List<Result> results = [];
  

  @override
  void initState() {
    super.initState();
    getResults();
  }

  void getResults() async {
    final prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('results');
    if(action != null){
      final decoded = jsonDecode(action.toString());
      List<Result> mylist = List<Result>.from(decoded.map( (i) => Result.fromJson(i)));
      setState(() {
        results = mylist;
      });
    }
  }

  void removeResults() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('results');
    print(success);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: Text('RESULTS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  letterSpacing: 2.0
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
              child: IconButton(onPressed: (){
                removeResults();
              }, icon: const Icon(CupertinoIcons.delete), color: Colors.white,),
            )
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Container( 
                      padding: const EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
                      height: 40.0, 
                      color: const Color.fromRGBO(55, 56, 80, 1), 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Type', style: TextStyle(color: Colors.white60)),
                        ],
                      )
                    ),
                     Container( 
                      height: 40.0, 
                      color: const Color.fromRGBO(55, 56, 80, 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Date', style: TextStyle(color: Colors.white60)),
                        ],
                      )
                    ),
                    Container(
                       height: 40.0, 
                      color: const Color.fromRGBO(55, 56, 80, 1),
                      child: Row(
                        children: const [
                          ImageIcon(
                            AssetImage('assets/icons/download.png'),
                            color: Colors.white60,
                          ),
                          SizedBox(width: 2.0,),
                          Text('Mbps', style: TextStyle(color: Colors.white60))
                        ],
                      ),
                    ),
                    Container(
                      height: 40.0, 
                      color: const Color.fromRGBO(55, 56, 80, 1), 
                      child: Row(
                        children: const [
                          ImageIcon(
                            AssetImage('assets/icons/upload.png'),
                            color: Colors.white60,
                          ),
                          SizedBox(width: 2.0,),
                          Text('Mbps', style: TextStyle(color: Colors.white60))
                        ],
                      ),
                    )
                  ]
                ),
                for(var result in results) TableRow(children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(25.0, 12.0, 0.0, 12.0),
                    alignment: Alignment.centerLeft,
                    child: ImageIcon(
                      AssetImage('assets/icons/${result.type}.png'),
                      color: Colors.white60,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0.0),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          result.date,
                          style: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(height: 2.0,),
                        Text(
                          result.time,
                          style: const TextStyle(
                            color: Colors.white
                          )
                        ),
                      ],
                    ),
                  ),
                  Text(
                    result.download.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500
                    )
                  ),
                  Text(
                    result.upload.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ])
              ],
            ),
          ),
        ),
      ],
    );
  }
}