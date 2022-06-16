
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngn/models/bazar_data.dart';
import 'package:ngn/models/shop_data.dart';
import 'package:provider/provider.dart';

import '../models/size_config.dart';
import '../provider/bazars.dart';
import '../provider/shopdates.dart';
class MarketModalBottom extends StatefulWidget {


  @override
  State<MarketModalBottom> createState() => _ModalBottomState();
}
class _ModalBottomState extends State<MarketModalBottom> {
  final TextEditingController marketNameController = TextEditingController();
  final TextEditingController marketPhoneController = TextEditingController();
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
 var bazarId;




  @override
  Widget build(BuildContext context) {
    var bazarsDate = Provider.of<Bazars>(context).list;


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
              DropdownButton(
                hint: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.home),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Bozorni tanglang '),
                    ],
                  ),
                ),
                items: bazarsDate
                    .map((bazar) => DropdownMenuItem(
                  child: Text(bazar.bazarName),
                  value: bazar.bazarId,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    bazarId = value as String;
                  });
                },
                isExpanded: true,
              ),

              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: marketNameController,
                // keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                    labelText: 'Dokon nomini kiriritng', border: OutlineInputBorder()),


              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Dokon telefon nomeri', border: OutlineInputBorder()),
                controller: marketPhoneController,


              ),
              const SizedBox(
                height: 20,
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
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () =>Navigator.of(context).pop(),child: Text('Bekor qilish')),
                  ElevatedButton(onPressed: (){
                    int index = bazarsDate.indexWhere((element) =>element.bazarId ==bazarId);
                    Provider.of<ShopDates>(context,listen: false).addShop(
                        ShopDate(
                            shopId: UniqueKey().toString(),
                            shopName: marketNameController.text,
                            shopPhone: marketPhoneController.text,
                            shopImage:  image == null ?'':image!.uri.toString() ,
                            bazarId: bazarId,
                            isActive: true,
                            createdAt: DateTime.now(),
                            bazarName: bazarsDate[index].bazarName));
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