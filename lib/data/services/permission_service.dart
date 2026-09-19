

// import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';



class PermissionService {




  static Future<void> requestLocationPermission() async {
    final status = await Permission.location.status;

    if(status.isGranted){
      return;
    }

    if (status.isDenied) {

      await Permission.location.request();
    }




  }














}