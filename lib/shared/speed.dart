import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:internet_speed_test/callbacks_enum.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/result.dart';
import '../shared/gauge.dart';
import '../shared/result_widget.dart';

class Speed extends StatefulWidget {
  final String connectionType;
  final String phoneModel;
  final String isp;
  const Speed({ Key? key, required this.connectionType, required this.phoneModel, required this.isp}) : super(key: key);

  @override
  State<Speed> createState() => _SpeedState();
}

class _SpeedState extends State<Speed> {
  final internetSpeedTest = InternetSpeedTest();
  double transferRateState = 0.0;
  String unitText = 'Mbps';
  double downloadSpeed = 0.0;
  double uploadSpeed = 0.0;
  bool isTesting = false;
  bool isLoading = false;
  double containerWidth = 0.0;
  double containerHeight = 0.0;
  DateTime now = DateTime.now();
  int? responseTime;

  void _onPressTestConnection() async {
    if(widget.connectionType == 'none') {
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('No connection'),
            content: Text('Speed test failed to execute. Please check your internet connection and try again.'),
            actions: [
              TextButton(onPressed: (){ Navigator.pop(context); }, child: Text('Ok'))
            ],
          );
        }
      );
    }else{
      final ping = Ping('google.com', count: 5);
      Duration sum = const Duration(hours: 0, minutes: 0, seconds: 0);
      ping.stream.listen((event) {
        if(event.response != null){
          sum = sum + event.response!.time!;
        }
        else if(event.summary != null){
          setState(() {
            responseTime = sum.inMilliseconds;
          });
        }
      });
      setState(() {
        isLoading = true;
      });
      await Future.delayed(const Duration(milliseconds: 3000));
      setState((){ 
        isTesting = true;
        containerHeight = 250;
        containerWidth = 250;
      });
      await Future.delayed(const Duration(milliseconds: 5000));
      internetSpeedTest.startDownloadTesting(
        onDone: (double transferRate, SpeedUnit unit) async {
            String strDSTransfer = transferRate.toStringAsFixed(2);
            double convertedDS = double.parse(strDSTransfer);
            setState(() {
              unitText = unit == SpeedUnit.Kbps ? 'Kbps' : 'Mbps';
              transferRateState = 0.0;
              downloadSpeed = convertedDS;
            });
            await Future.delayed(const Duration(milliseconds: 500));
            internetSpeedTest.startUploadTesting(
              onDone: (double transferRate, SpeedUnit unit) async {
                String strUSTransfer = transferRate.toStringAsFixed(2);
                double convertedUS = double.parse(strUSTransfer);
                setState(() {
                  unitText = unit == SpeedUnit.Kbps ? 'Kbps' : 'Mbps';
                  transferRateState = 0.0;
                  uploadSpeed = convertedUS;
                });

                await Future.delayed(const Duration(milliseconds: 4000));
                final prefs = await SharedPreferences.getInstance();
                final String? actions = prefs.getString('results');
                if(actions != null){
                  final decoded = jsonDecode(actions.toString());
                  final List<Result> list = List<Result>.from( decoded.map((i) => Result.fromJson(i)));
                  Result res = Result(
                    type: widget.connectionType,
                    date: DateFormat('yMd').format(now),
                    time: DateFormat('jm').format(now),
                    download: downloadSpeed, 
                    upload: uploadSpeed
                  );
                  list.add(res);
                  await prefs.setString('results', jsonEncode(list));
                }
                else{
                  Result res = Result(
                    type: widget.connectionType,
                    date: DateFormat('yMd').format(now),
                    time: DateFormat('jm').format(now),
                    download: downloadSpeed, 
                    upload: uploadSpeed
                  );
                  List<Result> result = [ res ];
                  await prefs.setString('results', jsonEncode(result));
                }

                Navigator.pushNamed(context, '/results', arguments: {
                  "responseTime": responseTime,
                  "download": downloadSpeed,
                  "upload": uploadSpeed,
                  "date": DateFormat('yMd').format(now),
                  "time": DateFormat('jm').format(now),
                  "connectionType": widget.connectionType,
                  "phoneModel": widget.phoneModel,
                  "isp": widget.isp
                });

                setState(() {
                  isTesting = false;
                  isLoading = false;
                  containerHeight = 0.0;
                  containerWidth = 0.0;
                  uploadSpeed = 0.0;
                  downloadSpeed = 0.0;
                });
              },
              onProgress: (double percent, double transferRate, SpeedUnit unit) {
                setState(() {
                  unitText = unit == SpeedUnit.Kbps ? 'Kbps' : 'Mbps';
                  transferRateState = transferRate;
                });
              },
              onError: (String errorMessage, String speedTestError) {
                print(errorMessage);
                print(speedTestError);
              },
            );

        },
        onProgress: (double percent, double transferRate, SpeedUnit unit) {
            setState(() {
              unitText = unit == SpeedUnit.Kbps ? 'Kbps' : 'Mbps';
              transferRateState = transferRate;
            });
        },
        onError: (String errorMessage, String speedTestError) {
          print(errorMessage);
          print(speedTestError);
        },
      );  
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0,),
              ResultWidget(unitText: unitText, isTesting: isTesting, downloadSpeed: downloadSpeed, uploadSpeed: uploadSpeed),
              const SizedBox(height: 100.0,),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: containerHeight,
                width: containerWidth,
                child: isTesting ? Gauge(transferRateState: transferRateState, unitText: unitText,) : null,
              ),
              
              Container(
                child: isTesting ? null : SizedBox(
                  height: 250,
                  width: 250,
                  child: isLoading ? 
                    const CircularProgressIndicator(
                      semanticsLabel: 'Connecting',
                    )
                   :
                    AvatarGlow(
                      glowColor: Colors.blue,
                      endRadius: 140.0,
                      duration: const Duration(milliseconds: 2000),
                      repeat: true,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      child: Material(
                        shape: const CircleBorder(),
                        child: ElevatedButton(
                          onPressed: (){ 
                            _onPressTestConnection();
                          },
                          child: const Text(
                            'GO',
                            style: TextStyle(
                              fontSize: 20.0,
                              letterSpacing: 3.0
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(70),
                            primary: const Color.fromARGB(255, 20, 21, 38),
                            side: const BorderSide( width: 3.0, color: Colors.blue)
                          ),
                        ),
                      ),
                    ),
                ),
              ),
              Container(
                child: isTesting ? 
                TextButton(onPressed: (){
                  setState(() {
                    isLoading = false;
                    isTesting = false;
                    containerHeight = 0.0;
                    containerWidth = 0.0;
                  });
                }, child: Text('Cancel')) : null,
              )
            ],
          ),
        ),
    );
  }
}