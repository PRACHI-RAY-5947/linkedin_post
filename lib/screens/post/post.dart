import 'dart:io';
import 'dart:ui' as ui;
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

import '../../modals/modals.dart';
import '../../routes/colour_list.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  // Color fontColor = Colors.white;
  GlobalKey allKeys = GlobalKey();
  String fonts = FontFamily[0].toString();

  TextStyle fontFamily = FontFamily[0];
  Future<File> getFile() async {

    RenderRepaintBoundary boundary =
    allKeys.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 15,
    );
    ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    Uint8List uInt8list = bytes!.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    File file = await File(
        "${directory.path}/QA-${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(uInt8list);

    return file;
  }

  Widget saveChild = const Icon(Icons.save_alt);

  int selectedIndex = 0;
  Color fontColor = Colors.white;
  String fontstyle = FontFamily[0] as String;


  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    Size size = MediaQuery.sizeOf(context);



    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
        Column(
          children: [
            Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top:40),
                child: Text("Create Post",
                style: GoogleFonts.aBeeZee(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    // color: Colors.purple.shade100,
                    color: fontColor,
                    borderRadius: BorderRadius.circular(18)
                  ),
                  child:
                  Row(
                    children: [
                      //image picker
                      Align(alignment: Alignment.topLeft,
                        child: Align(alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [BoxShadow(color: Colors.purple.shade50)]),

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FloatingActionButton.small(

                                  backgroundColor: Colors.white,
                                  onPressed: () async {
                                    ImagePicker picker = ImagePicker();
                                    XFile? xfile =
                                    await picker.pickImage(source: ImageSource.gallery);
                                    User.image = File(xfile!.path);
                                  },
                                  child: const Icon(CupertinoIcons.camera),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              //username
                              TextFormField(
                                onSaved: (val) {
                                  User.name = val;
                                },
                                validator: (val) => (val!.isEmpty) ? "not valid" : null,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.drive_file_rename_outline,
                                    color: Colors.purple.shade100,
                                  ),
                                  hintText: "Name",
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                    color: Colors.purple.shade100,
                                  ),
                                  helperStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.purple.shade100,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 10),

                              //email
                              TextFormField(
                                onSaved: (val) {},
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.mail,
                                    color: Colors.purple.shade100,
                                  ),
                                  hintText: "name321@gmail.com",
                                  labelText: "E-mail",
                                  labelStyle: TextStyle(
                                    color: Colors.purple.shade100,
                                  ),
                                  helperStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.purple.shade100,
                                    ),
                                  ),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.emailAddress,
                              ),

                              SizedBox(height: 10),

                              //details
                              TextField(
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: "  Quote of the day" ,
                                  counterText: User.author
                                ),
                                ),

                              SizedBox(height: 70),

                              TextField(

                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(

                                    prefixText: "By",
                                    hintText: " Author name" ,
                                    counterText: User.author
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                ),
              ),
            ),
      const Text(
        "Post Color",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              fontColors.length,
                  (index) => GestureDetector(
                onTap: () {
                  fontColor = fontColors[index];
                  log("$fontColor");
                  setState(() {});
                },
                child: Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: fontColors[index],
                  ),
                ),

              ),
            ),
          ),
        ),
      ),

               const Text(
               "Font Style",
               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
             ),
             SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 children: FontFamily.map(
                       (e) => GestureDetector(
                     onTap: () {
                       fonts = FontFamily[0] as String;
                       setState(() {});
                     },
                     child: TextButton(
                       onPressed: () {
                         fontFamily = e;
                         log("$FontFamily");
                         setState(() {});
                       },
                       child: Text(
                         "text",
                         style: e,
                       ),
                     ),
                   ),
                 ).toList(),
               ),
             ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                         children: [
               FloatingActionButton(
                 backgroundColor: Colors.purple.shade200,
                 heroTag: "btn1",
                 onPressed: () async {
                   var saveChild = const CircularProgressIndicator();
                   setState(() {});
                   File file = await getFile();
                   ImageGallerySaver.saveFile(file.path).then((value) {
                     saveChild = const Icon(Icons.done) as CircularProgressIndicator;
                     setState(() {});
                   });
                 },
                 child: saveChild,
               ),
               const SizedBox(
                 width: 20,
               ),
               FloatingActionButton(
                 backgroundColor: Colors.purple.shade200,
                 heroTag: "btn1",
                 onPressed: () async {
                   File file = await getFile();
                   ShareExtend.share(
                     file.path,
                     "file",
                     extraText: "Get app like from PlayStore.",
                   );
                 },
                 child: const Icon(
                   Icons.share,
                 ),
               ),
                         ],
              ),
            )

     ]),


    );
  }
}
