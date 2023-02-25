import 'package:dio/dio.dart';
import 'package:draemai/components/upload_loading.dart';
import 'package:draemai/screens/upload/components/upload_card.dart';
import 'package:flutter/material.dart';
import 'package:draemai/components/default_button.dart';
import 'package:draemai/size_config.dart';
import 'package:file_picker/file_picker.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // ignore: non_constant_identifier_names
  List<Widget> UploadCardWidgets = [];
  // ignore: non_constant_identifier_names
  List<Widget> DisplayCardWidgets = [];
  // ignore: non_constant_identifier_names
  List<PlatformFile> UploadToServer = [];

  int remaining = 0;
  bool uploading = false;
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
          child: Card(
        elevation: 0,
        color:
            Colors.black.withOpacity(0.85), //Colors.redAccent.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Start by uploading clear images of your self to train the AI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'krona',
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(18),
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(),
                    DisplayCardWidgets.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: GestureDetector(
                                child: const DefaultButton(
                                  text: "Select",
                                ),
                                onTap: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: true,
                                    type: FileType.custom,
                                    allowedExtensions: ['jpg', 'jpeg'],
                                  );
                                  List<PlatformFile> file = [];
                                  if (result == null) {
                                  } else {
                                    setState(() {});
                                    result?.files.forEach((element) {
                                      file.add(element);
                                    }
                                        // ignore: avoid_function_literals_in_foreach_calls
                                        );
                                    file.forEach((element) {
                                      UploadCardWidgets.add(
                                          UploadCard(element.name));
                                      UploadToServer.add(element);
                                    });
                                    var counter = 0;
                                    for (var element in UploadCardWidgets) {
                                      if (counter <= 3) {
                                        DisplayCardWidgets.add(element);
                                      }
                                      counter += 1;
                                    }
                                    if (counter >= 4) {
                                      remaining = counter - 4;
                                    }
                                  }

                                  //List<File> files =
                                  //    results.paths.map((path) => File(path)).toList();
                                }
                                //
                                // () => Navigator.pushNamed(
                                // context, UploadScreen.routeName)
                                ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: uploading
                                ? GestureDetector(
                                    child: const UploadButton(text: ""),
                                    onTap: () async {}
                                    //
                                    // () => Navigator.pushNamed(
                                    // context, UploadScreen.routeName)
                                    )
                                : GestureDetector(
                                    child: const DefaultButton(
                                      text: "Upload",
                                    ),
                                    onTap: () async {
                                      setState(() {
                                        uploading = true;
                                      });
                                      UploadToServer.forEach((element) async {
                                        String fileName =
                                            element.path!.split('/').last;
                                        FormData formData = FormData.fromMap({
                                          "file": await MultipartFile.fromFile(
                                              element.path.toString(),
                                              filename: fileName)
                                        });
                                        try {
                                          var header = {
                                            'Content-type':
                                                'application/json; charset=utf-8'
                                          };
                                          var response = dio.post(
                                              'http://192.168.43.205:8000/api/v1/upload_training/',
                                              data: formData,
                                              options:
                                                  Options(headers: header));
                                          print("Yung Rich nigga $response");
                                        } catch (e) {
                                          //implement functionality to cath the errors
                                        }
                                      });
                                    },
                                  ),
                          )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: DisplayCardWidgets,
              ),
            ),
            DisplayCardWidgets.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(7),
                      ),
                      Text(
                        "${remaining.toString()} more",
                        style: TextStyle(
                            fontFamily: 'muli',
                            color: Colors.white,
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  )
                : const Text("")
          ],
        ),
      )),
    );
  }
}
