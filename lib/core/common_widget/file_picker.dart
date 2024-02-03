// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rtd_project/util/toast.dart';
//
// import '../color/colors.dart';
// import 'commen_botten.dart';
//
// class FilePickerWidget extends StatefulWidget {
//   const FilePickerWidget({
//     super.key,
//     required this.onFileSelected,
//     required this.press,
//   });
//
//   final ValueChanged<File?> onFileSelected;
//   final Function() press;
//
//   @override
//   _FilePickerWidgetState createState() => _FilePickerWidgetState();
// }
//
// class _FilePickerWidgetState extends State<FilePickerWidget> {
//   File? file;
//
//   Future pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
//     );
//
//     // if (result != null) {
//     //   // Use the result.files[0] for further processing
//     //   file = File(result.files.single.path!);
//     //   widget.onFileSelected(file);
//     //   setState(() {});
//     // } else {
//     //   // User canceled the file picking
//     // }
//     if (result != null) {
//       file = null;
//       if (result.files.isNotEmpty) {
//         String extension = result.files.first.extension ?? '';
//         // Check if the selected file is a video
//         if (['pdf', 'png', 'jpg', 'jpeg'].contains(extension.toLowerCase())) {
//           // Use the result.files[0] for further processing
//           file = File(result.files.single.path!);
//           widget.onFileSelected(file);
//         } else {
//           // Show an error message or handle the case where a video is selected
//           showToast('$extension files not allowed.');
//         }
//       }
//       setState(() {});
//     } else {
//       // User canceled the file picking
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 290.h,
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         color: whiteColor,
//         borderRadius: BorderRadiusDirectional.only(
//           topEnd: Radius.circular(50),
//           topStart: Radius.circular(50),
//         ),
//       ),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 30.h,
//           ),
//           const Text(
//             "Upload your ID Proof",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           SizedBox(
//             height: 30.h,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   pickFile(); // Call pickFile instead of pickImage
//                 },
//                 child: file == null
//                     ? Container(
//                         width: 126.w,
//                         height: 121.h,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(36),
//                             color: const Color(0xfff3f3f3)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Icon(Icons.attach_file,
//                                 size: 50, color: Colors.blue),
//                             SizedBox(
//                               height: 5.h,
//                             ),
//                             const Text("Choose File",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w500,
//                                 ))
//                           ],
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             const Icon(Icons.description,
//                                 size: 80, color: Colors.green),
//                             SizedBox(
//                               height: 5.h,
//                             ),
//                             const Text(
//                               'File Selected',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.green,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           SizedBox(
//             height: 20.h,
//           ),
//           ButtonWidget(
//             press: () {
//               if (file != null) {
//                 widget.press();
//               } else {
//                 showToast("Select file to continue");
//               }
//             },
//             buttonBackgroundColor: buttenBlue,
//             buttonForegroundColor: whiteColor,
//             buttonText: 'Upload',
//             borderAvalable: true,
//           )
//         ],
//       ),
//     );
//   }
// }
