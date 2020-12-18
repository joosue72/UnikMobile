  

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unik_inv/GastosRapidos/category_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';


 class AddPage extends StatefulWidget {
  AddPage({Key key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}
  String category;
  int value = 0;

  //variables imagen
  dynamic image;
  String filename;
  String urlImagen;
  String url; 
  //registrar año
var downUrl;

  TextEditingController _cantidadProducto = TextEditingController();

class _AddPageState extends State<AddPage> {
 
  Future _getImage() async{
  // ignore: deprecated_member_use
  var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);



    setState(() {
        image = selectedImage;
        filename = basename(image.path);
        uploadImage();
        });
      
    
    
}

Future<String>uploadImage() async{
  Reference ref = FirebaseStorage.instance.ref().child(filename);
  UploadTask uploadTask = ref.putFile(image);
   downUrl = await(await uploadTask).ref.getDownloadURL();
 url = downUrl.toString();
  

  print("Download URL : $url");
  return url;
}
  


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: _getCustomAppBar(),
      body: 
      
      _body()
      ,
    );
  }
    Widget _body() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0,),
        _categorySelector(),
        _currentValue(),
        Container(
               decoration: BoxDecoration(

                 color: Color(0XFFEFF3F6),
                 borderRadius: BorderRadius.circular(20.0),
                 boxShadow: [
                   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1),
                   offset: Offset(6,2),
                   blurRadius: 6.0,
                   spreadRadius: 3.0
                   ),
                    BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.9),
                   offset: Offset(-6,-2),
                   blurRadius: 6.0,
                   spreadRadius: 3.0
                   )
                 ]
               ),
               
               child: TextField(
                 
                 minLines: 1,
                  maxLines: 5,
                  textInputAction: TextInputAction.done,
  onSubmitted: (value) {
    
  },
                 controller: _cantidadProducto,
                 decoration: InputDecoration(

                   border: InputBorder.none,
                   hintText: "    Descripcion: "
                 ),
               ),
               
               ),
               SizedBox(height: 20,),
              
               SizedBox(height: 20.0,),
        _numpad(),
        _submit(),
      ],
    );
  }
   Widget _categorySelector() {
    return Container(
      height: 80.0,
      child: CategorySelectionWidget(
        categories: {
       
          "Pagos": FontAwesomeIcons.moneyBill,
          "Nominas": FontAwesomeIcons.personBooth,
          "Comidas": FontAwesomeIcons.hamburger,
          "Sistema": FontAwesomeIcons.tv,
          "Gasolina": FontAwesomeIcons.gasPump,
          "Proveedores": FontAwesomeIcons.peopleCarry,
          "Servicios": FontAwesomeIcons.servicestack,
          "Otros": FontAwesomeIcons.boxOpen,
        },
        onValueChanged: (newCategory) => category = newCategory,
      ),
    );
  }

  Widget _currentValue() {
    var realValue = value / 100.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        "\$${realValue.toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 50.0,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _num(String text, double height) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          if (text == ",") {
            value = value * 100;
          } else {
            value = value * 10 + int.parse(text);
          }
        });
      },
      child: Container(
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _numpad() {
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var height = constraints.biggest.height / 4;

        return Table(
          border: TableBorder.all(
            color: Colors.black,
            width: 1.0,
          ),
          children: [
            TableRow(children: [
              _num("1", height),
              _num("2", height),
              _num("3", height),
            ]),
            TableRow(children: [
              _num("4", height),
              _num("5", height),
              _num("6", height),
            ]),
            TableRow(children: [
              _num("7", height),
              _num("8", height),
              _num("9", height),
            ]),
            TableRow(children: [
              _num(",", height),
              _num("0", height),
              GestureDetector(
                onTap: () {
                  setState(() {
                    value = value ~/ 10;
                  });
                },
                child: Container(
                  height: height,
                  child: Center(
                    child: Icon(
                      Icons.backspace,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        );
      }),
    );
  }

  Widget _submit() {
    return Builder(builder: (BuildContext context) {
      return Hero(
        tag: "add_button",
        child: Container(
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: MaterialButton(
            child: Text(
              "Agregar Gasto",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              if (value > 0 && category != "") {
                FirebaseFirestore.instance
                    .collection('Gastos')
                    .doc()
                .set({
                  "Nombre": category,
                  "Cantidad": value / 100.0,
                  "Mes": DateTime.now().month,
                  "Dia": DateTime.now().day,
                  "Año": DateTime.now().year,
                  "Descripcion": _cantidadProducto.text,
                  'Imagen':'$url'
                });

                 Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Gasto Agregado",
  message: "Se Agrego correctamente en la base de datos",
  duration: Duration(seconds: 2),
  isDismissible: false,
)..show(context);
_cantidadProducto.text="";
value=0;
url ="";
setState(() {
  
});
     
  
              } else {
                Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Error!",
  message: "Seleccione una Categoria o digite un Numero",
  duration: Duration(seconds: 2),
  isDismissible: false,
)..show(context);
              }
            },
          ),
        ),
      );
    });
  }

  _getCustomAppBar(){
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.black), onPressed: (){
          Navigator.pop(this.context);

        }),
        Text('Agrega un Gasto', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w900),),
        IconButton(icon: Icon(Icons.camera_alt, color: Colors.black), onPressed: (){

             _getImage();   


        }),
      ],),
    ),
  );
}



}