import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final LocalAuthentication auth;
  bool _supportState = false;
  @override
  void initState() {

    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
            (bool isSupported) =>setState(() {
              _supportState =isSupported;
            }),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
          // (_supportState )
          //     ? const Text('this is supported')
          //  : const Text('this is not supported'),
          // Divider(height: 20,),
          // ElevatedButton(
          //   onPressed: _getAvailableBiomatric,
          //   child: Text('Available biometric'),
          // ),
          // SizedBox(
          //   height: 20,
          // ),
          SizedBox(
            width: 100,
            height: 100,
            child: ElevatedButton(
                onPressed: _authenticate,

                child: Icon(Icons.fingerprint,size: 50,),
            ),
          ),



        ],
      ),
    ),
    );
  }
  Future<void>_authenticate()async{
    try{
      bool authenticated = await auth.authenticate(
          localizedReason: 'to mark your attendence Muhammad Anus',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: false,
      ),
      );
      print('Authenticated : $authenticated');
      if (authenticated) {
       Get.snackbar('Attendence', 'Muhammad Anus your attendence marked successfully');

        print('successfully mark attendenc');
      }
    }on PlatformException catch(e){
      print(e);
    }
  }


  Future<void> _getAvailableBiomatric()async{
    List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    print('List of availableBiometrics : $availableBiometrics');
    if(!mounted){
      return;
    }

  }
}
