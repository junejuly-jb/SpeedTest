// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:carrier_info/carrier_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speedtest/shared/my_results.dart';
import 'package:speedtest/shared/speed.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String pageState = 'speed';
  String providerState = 'none';
  String? phoneModel;
  String? isp;

  @override
  void initState() {
    super.initState();
    _checkPermission().then((result){
      checkConnection();
      checkDeviceInfo();
    });
    
  }

  void checkConnection() async {
    await Future.delayed(Duration(seconds: 5));
    final connectivity = Connectivity();
    final res = await connectivity.checkConnectivity();
    if(res == ConnectivityResult.mobile){
      String? carrierInfo = await CarrierInfo.carrierName;
        print(carrierInfo);
      setState((){
      providerState = 'mobile';
      isp = carrierInfo;
      });
    }
    else if(res == ConnectivityResult.wifi){
      var wifiName = await WifiInfo().getWifiName();
      setState((){
        providerState = 'wifi';
        isp = wifiName;
      });
    }
    else{
      setState(() => providerState = 'none');
    }
    connectivity.onConnectivityChanged.listen((event) async {
      if(event == ConnectivityResult.mobile){
        String? carrierInfo = await CarrierInfo.carrierName;
        print(carrierInfo);
        setState(() {
        providerState = 'mobile';
        isp = carrierInfo;
        });
      }
      else if(event == ConnectivityResult.wifi){
        var wifiName = await WifiInfo().getWifiName();
        setState(() {
          providerState = 'wifi';
          isp = wifiName;
        });
      }
      else{
        setState(() => providerState = 'none');
      }
    });
  }

void checkDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  setState(() => phoneModel = androidInfo.model);
}

Future<void> _checkPermission() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    final isGpsOn = serviceStatus == ServiceStatus.enabled;
    if (!isGpsOn) {
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.locationWhenInUse.request();
    print(status);
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied. Show a dialog and again ask for the permission');
      exit(0);
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
      exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 21, 38),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 20, 21, 38),
        elevation: 0,
        centerTitle: true, 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ImageIcon(
              AssetImage('assets/icons/meter.png'),
              color: Color.fromARGB(255, 145, 146, 164),
            ),
            SizedBox(width: 8.0,),
            Text(
              'SPEEDTEST',
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 2.0,
                color: Color.fromARGB(255, 145, 146, 164)
              ),
            ) 
          ],
        )
      ),
      body: pageState == 'speed' ? 
        Speed(connectionType: providerState, phoneModel: phoneModel ?? "", isp: isp ?? "") : 
        const MyResults(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25)
        ),
        child: BottomAppBar(
          elevation: 0,
          color: const Color.fromARGB(255, 20, 21, 38),
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [ 
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                width: double.infinity,
                color: const Color.fromARGB(255, 25, 26, 47),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage('assets/icons/$providerState.png'),
                      color: Colors.white38,
                    ),
                    const SizedBox(width: 20.0,),
                    Container(
                      child: providerState == 'none' ? 
                      Text('Waiting for connection...', style: TextStyle( color: Colors.white, fontSize: 18.0),) :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(isp.toString(), style: TextStyle( color: Colors.white, fontSize: 20.0),),
                          SizedBox(height: 5.0,),
                          Text(phoneModel.toString(), style: TextStyle( color: Colors.white38, fontWeight: FontWeight.w300),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: (){
                        setState(() {
                          pageState = 'speed';
                        });
                      }, 
                      child: Column(
                        children: [
                          ImageIcon(
                            const AssetImage('assets/icons/meter.png'),
                            color: pageState == 'speed' ? Colors.white : Colors.grey[800],
                          ),
                          Text(
                            'Speed',
                            style: TextStyle(
                              color: pageState == 'speed' ? Colors.white : Colors.grey[800]
                            ),
                          )
                        ],
                      )
                    ),
                    TextButton(
                      onPressed: (){
                        setState(() {
                          pageState = 'result';
                        });
                      }, 
                      child: Column(
                        children: [
                          ImageIcon(
                            const AssetImage('assets/icons/check.png'),
                            color: pageState == 'result' ? Colors.white : Colors.grey[800],
                          ),
                          Text(
                            'Results',
                            style: TextStyle(
                              color: pageState == 'result' ? Colors.white : Colors.grey[800]
                            ),
                          )
                        ],
                      )
                    ),
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}