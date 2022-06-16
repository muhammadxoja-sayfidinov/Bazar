
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngn/models/bazar_data.dart';
import 'package:provider/provider.dart';

import '../provider/bazars.dart';
class ModalBottom extends StatefulWidget {


  @override
  State<ModalBottom> createState() => _ModalBottomState();
}
class _ModalBottomState extends State<ModalBottom> {
  final TextEditingController bozorController = TextEditingController();
  File? image;
  Future pickImage()async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagetemporary = File(image.path);
      setState(() => this.image = imagetemporary);
    } on Platform catch (e){
        print('error');
    }
  }




  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: SizedBox(
        child: Padding(
          padding:  EdgeInsets.only(
              top: 0,
              left: 16,
              right: 16,
              bottom:MediaQuery.of(context).viewInsets.bottom > 0?
              MediaQuery.of(context).viewInsets.bottom +16 :
              MediaQuery.of(context).size.height * 0.25),
          child:Column(
            children: [
              TextFormField(
                controller: bozorController,


              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: image ==null ?ElevatedButton(
                    onPressed: ()  {
                    pickImage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),

                      Text("Mahsulot rasmi tanglang")
                      ],
                    ),
                  ): Image.file(image!,fit: BoxFit.cover,),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () =>Navigator.of(context).pop(),child: Text('Bekor qilish')),
                  ElevatedButton(onPressed: (){
                    Provider.of<Bazars>(context,listen: false).addProduct(
                        Bazar(bazarId: UniqueKey().toString(),
                            bazarName: bozorController.text,
                            bazarImage: image == null ?'':image!.uri.toString() ,
                            isActive: true,
                            createdAt: DateTime.now(),
                        ));
                  }, child: Text('Saqlash'))
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}