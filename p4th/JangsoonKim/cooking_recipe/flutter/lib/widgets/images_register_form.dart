import 'package:demo/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:multiple_images_picker/multiple_images_picker.dart';

class ImagesRegisterForm extends StatefulWidget {
  const ImagesRegisterForm({Key? key}) : super(key: key);

  @override
  State<ImagesRegisterForm> createState() => _ImagesRegisterFormState();
}

class _ImagesRegisterFormState extends State<ImagesRegisterForm> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

/*  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 280,
          height: 300,
        );
      }),
    );
  }*/

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultipleImagesPicker.pickImages(
        maxImages: 8,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
            border: Border.all(width: 0.8)
          ),
          child: SizedBox.fromSize(
            size: const Size(70,70),
            child: ClipOval(
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: loadAssets,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.camera_alt_outlined),
                      Text("${images.length}/8")
                    ],
                  ),
                ),
              )
            ),
          ),
        ),
      ),
      const Divider(
        color: AppTheme.indiaInk,
      ),
      Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: AssetThumb(asset: images[index], width: 150, height: 150),
              );
            },
          )),
      Divider(
        color: AppTheme.indiaInk,
      )
    ]);
  }
}
