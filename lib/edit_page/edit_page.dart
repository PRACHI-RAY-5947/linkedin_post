// import 'dart:developer';
// import 'dart:io';
// import 'dart:ui' as ui;
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_extend/share_extend.dart';
//
// class EditingPage extends StatefulWidget {
//   const EditingPage({super.key});
//
//   @override
//   State<EditingPage> createState() => _EditingPageState();
// }
//
// class _EditingPageState extends State<EditingPage> {
//   GlobalKey allKeys = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     Map<String, dynamic> editing =
//     (ModalRoute.of(context)!.settings.arguments ?? allFestivals[0])
//     as Map<String, dynamic>;
//     Size size = MediaQuery.sizeOf(context);
//     double h = size.height;
//     double w = size.width;
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Container(
//             height: size.height,
//             width: size.width,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                   "https://i.pinimg.com/236x/4e/4a/f7/4e4af7e0dcff47c1f8d8725bb9b89fa2.jpg",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 Text(
//                   "Templates ",
//                   style: GoogleFonts.aclonica(
//                     color: Colors.black,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Expanded(
//                   child: GridView.builder(
//                     gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       childAspectRatio: 4 / 5,
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 4,
//                     ),
//                     itemCount: editing['editing'].length,
//                     itemBuilder: (context, index) => GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(
//                           context,
//                           MyRoutes.backgroundpage,
//                           arguments: editing['editing'][index],
//                         );
//                       },
//                       child: Container(
//                         height: size.height * 0.25,
//                         width: size.width * 0.5,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                               editing['editing'][index],
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }