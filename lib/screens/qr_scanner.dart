// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
//
//
// class QrScanner extends StatefulWidget {
//   const QrScanner({super.key});
//
//   @override
//   State<QrScanner> createState() => _QrScannerState();
// }
//
// class _QrScannerState extends State<QrScanner> {
//   MobileScannerController cameraController = MobileScannerController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Mobile Scanner'),
//         actions: [
//           IconButton(
//             color: Colors.white,
//             icon: ValueListenableBuilder(
//               valueListenable: cameraController.torchState,
//               builder: (context, state, child) {
//                 switch (state as TorchState) {
//                   case TorchState.off:
//                     return const Icon(Icons.flash_off, color: Colors.grey);
//                   case TorchState.on:
//                     return const Icon(Icons.flash_on, color: Colors.yellow);
//                 }
//               },
//             ),
//             iconSize: 32.0,
//             onPressed: () => cameraController.toggleTorch(),
//           ),
//           IconButton(
//             color: Colors.white,
//             icon: ValueListenableBuilder(
//               valueListenable: cameraController.cameraFacingState,
//               builder: (context, state, child) {
//                 switch (state as CameraFacing) {
//                   case CameraFacing.front:
//                     return const Icon(Icons.camera_front);
//                   case CameraFacing.back:
//                     return const Icon(Icons.camera_rear);
//                 }
//               },
//             ),
//             iconSize: 32.0,
//             onPressed: () => cameraController.switchCamera(),
//           ),
//         ],
//       ),
//       body: MobileScanner(
//         // fit: BoxFit.contain,
//         controller: cameraController,
//         onDetect: (capture) {
//           final List<Barcode> barcodes = capture.barcodes;
//           final Uint8List? image = capture.image;
//           for (final barcode in barcodes) {
//             debugPrint('Barcode found! ${barcode.rawValue}');
//           }
//         },
//       ),
//     );
//   }
//   // Example with controller and returning images
//   //
//   // import 'package:mobile_scanner/mobile_scanner.dart';
//   //
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(title: const Text('Mobile Scanner')),
//   //     body: MobileScanner(
//   //       fit: BoxFit.contain,
//   //       controller: MobileScannerController(
//   //         // facing: CameraFacing.back,
//   //         // torchEnabled: false,
//   //         returnImage: true,
//   //       ),
//   //       onDetect: (capture) {
//   //         final List<Barcode> barcodes = capture.barcodes;
//   //         final Uint8List? image = capture.image;
//   //         for (final barcode in barcodes) {
//   //           debugPrint('Barcode found! ${barcode.rawValue}');
//   //         }
//   //         if (image != null) {
//   //           showDialog(
//   //             context: context,
//   //             builder: (context) =>
//   //                 Image(image: MemoryImage(image)),
//   //           );
//   //           Future.delayed(const Duration(seconds: 5), () {
//   //             Navigator.pop(context);
//   //           });
//   //         }
//   //       },
//   //     ),
//   //   );
//   // }
// }
