import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/home_screen.dart';
import 'package:instagram_clone/utils/colour.dart';



class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  int direction = 0;

  @override
  void initState() {
    startCamera(0);
    super.initState();

  }


  void startCamera(int directon) async {
    cameras = await availableCameras();

    cameraController = CameraController(
        cameras[direction],
        ResolutionPreset.high,
        enableAudio: false,
    );
    await cameraController.initialize().then((value){
      if(!mounted){
        return;
      }
      setState(() {}); //To refresh Widget
    }).catchError((e){
      print(e);
    });
  }
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {


    if(cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: (){
                setState(() {
                  direction = direction == 0 ? 1:0;
                  startCamera(direction);
                });
              },
                child: button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft)
            ),
            GestureDetector(
                onTap: (){cameraController.takePicture().then((XFile? file){
                      if(mounted){
                        if(file !=null){
                          print("Print saved to ${file.path}");
                        }
                      }

                });
                },
                child: button(Icons.camera_alt_outlined, Alignment.bottomCenter)
            ),



          ],
        ),

        // appBar: AppBar(
        //   title: Text("Post to "),
        //   actions: <Widget>[
        //     TextButton(
        // style:
        // ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red),
        // ),
        //
        //     onPressed:() =>  Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const HomeScreen(),
        //   ),
        // ),
        //       child: Text("Post"),
        //     ),
        //   ],
        // ),

          );
    }else{
      return const SizedBox();
    }
      }
  Widget button(IconData icon,Alignment alignment){
    return  Align(
      alignment: alignment,
      child: Container(
        margin:  const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(2, 2),
                blurRadius: 10,
              )
            ]
        ),
        child: Center(
          child: Icon(
            icon,
            color:Colors.black ,


          ),
        ),
      ),
    );




  }

  }
