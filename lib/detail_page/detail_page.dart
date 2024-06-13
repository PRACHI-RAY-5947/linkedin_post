import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../modals/modals.dart';
import '../routes/routes.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<GlobalKey> allKeys = [];

  Future<File> getFile({required GlobalKey key}) async {
    RenderRepaintBoundary boundary =
    key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 1,
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

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> Linkedin =
    (ModalRoute.of(context)?.settings.arguments ?? [0])
    as Map<String, dynamic>;

    // allKeys = List.generate(
    //   Linkedin['post'].length,
    //       (index) => GlobalKey(),
    // );

    Size size = MediaQuery.sizeOf(context);
    double h = size.height;
    double w = size.width;

    return Scaffold(
      backgroundColor: Colors.black12,
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
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.purple.shade200,
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple.shade200
                    ),
                    child: Center(
                      child: Text(
                        "Text ",
                        style: GoogleFonts.aclonica(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),),
              const SizedBox(width:10),
              GestureDetector(
                onTap: (){

                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.purple.shade200
                  ),
                  child: Center(
                    child: Text("Colour",
                      style: GoogleFonts.aclonica(
                        color: Colors.black,
                        fontSize: 18,
                      ) ,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),

              //save button
                        ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          saveChild = const CircularProgressIndicator();
          setState(() {});
          File file = await getFile(key: allKeys[selectedIndex]);
          ImageGallerySaver.saveFile(file.path).then((value) {
            saveChild = const Icon(Icons.done);
            setState(() {});
          });
        },
        child: saveChild,
      ),
    );
  }
}