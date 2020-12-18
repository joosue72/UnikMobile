
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

// ignore: avoid_web_libraries_in_flutter
import 'package:path/path.dart' as s;
import 'package:uuid/uuid.dart';





 class CrearProducto extends StatefulWidget {
  CrearProducto({Key key}) : super(key: key);

  @override
  _CrearProductoState createState() => _CrearProductoState();
}


//Controllers de text
TextEditingController _nombreProducto = TextEditingController();
TextEditingController _cantidadProducto = TextEditingController();
TextEditingController _descripcion = TextEditingController();

TextEditingController nombre = TextEditingController();



//Variables Firebase
var selectedCurrency;
final db = FirebaseFirestore.instance;
dynamic nombreProd, canProd, cantidadProd2,descripcion;
dynamic cantidadProd;
dynamic codigo, telefono, correo, idPro;
dynamic codigoGen;
dynamic categoria, unidad, ubicacion;
dynamic _checkboxValue;
dynamic switchValue, selected;
DocumentSnapshot doc;
dynamic image;
dynamic url2;
String filename;



class _CrearProductoState extends State<CrearProducto> {


 @override
 void initState() { 
   super.initState();
    db
                .collection('Codigos')
                .snapshots()
                .listen((result) {
                result.docs.forEach((result) { 
                  codigo = result.data()['Codigo'].toString();
    
                });
          

                    print("Codigo rd"+ codigo);
                });
 }

 Future _getImage() async{
  // ignore: deprecated_member_use
  var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);

  

    setState(() {
        image = selectedImage;
        filename = s.basename(image.path);
        uploadImage();
        });
      
    
    
}

 Widget uploadArea(){

  return Column(
    children:<Widget>[
      Image.file(image,width:double.infinity),

    ],
  );

}

Future<String>uploadImage() async{
  Reference ref = FirebaseStorage.instance.ref().child(filename);
  UploadTask uploadTask = ref.putFile(image);

  var downUrl = await(await uploadTask).ref.getDownloadURL();
  var url = downUrl.toString();
  print("Download URL : $url");
  url2 = url;
  return url;
}


  @override
  Widget build(BuildContext context) {

    


    return Scaffold(
      appBar: _getCustomAppBar(),
      
       body: Padding(
         
         padding: const EdgeInsets.all(18.0),
         child: ListView(
          
           children: <Widget>[
             
              
           
             SizedBox(height:10),
                image==null?Text("Selecciona una imagen"): uploadArea(),
             
          
             
             SizedBox(height:40),
             CustomDropdown(
               enabledIconColor: Colors.black,
        valueIndex: _checkboxValue,
        hint: "Categoria",
        items: [
          CustomDropdownItem(text: "Cantera"),
          CustomDropdownItem(text: "Cuarzo"),
          CustomDropdownItem(text: "Deck"),
          CustomDropdownItem(text: "Granito"),
          CustomDropdownItem(text: "Marmol"),
          CustomDropdownItem(text: "Piel de elefante"),
          CustomDropdownItem(text: "Pisos"),
          CustomDropdownItem(text: "Porfido"),
          
          
        ],
        onChanged: (newValue) {
          setState(() => _checkboxValue = newValue);
        },
      ),
      SizedBox(height:20),
             Text("Nombre De Producto"),
             SizedBox(height:10),
             Container(
               decoration: BoxDecoration(

                 color: Color(0XFFEFF3F6),
                 borderRadius: BorderRadius.circular(100.0),
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
                 controller: _nombreProducto,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: "    Marmol Santo Tomas"
                 ),
               ),
               
               ),
                SizedBox(height:20),
             Text("Cantidad De Producto"),
             SizedBox(height:10),
             Container(
               decoration: BoxDecoration(

                 color: Color(0XFFEFF3F6),
                 borderRadius: BorderRadius.circular(100.0),
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
                 controller: _cantidadProducto,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: "    85.2 "
                 ),
               ),
               
               ),

               SizedBox(height:20),
                Text("Descripción"),
               SizedBox(height:20),
                
                 Container(
               decoration: BoxDecoration(

                 color: Color(0XFFEFF3F6),
                 borderRadius: BorderRadius.circular(10.0),
                 boxShadow: [
                   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1),
                   offset: Offset(3,2),
                   blurRadius: 6.0,
                   spreadRadius: 3.0
                   ),
                    BoxShadow(color: Color.fromRGBO(255, 255, 255, 0.9),
                   offset: Offset(-6,-2),
                   blurRadius: 6.0,
                   spreadRadius: 1.0
                   )
                 ]
               ),
               
               child: TextField(
                 minLines: 5,
                  maxLines: 15,
                 controller: _descripcion,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: "El producto contiene muchas piezas rotas."
                 ),
               ),
               
               ),
                
               
                
                SizedBox(height: 20,),
                
                    

SizedBox(height: 10,),
StreamBuilder<QuerySnapshot>(
                       
                  stream: db.collection('NombresProveedores').snapshots(),
                  
                  builder: (context, snapshot) {
                    
                    if (!snapshot.hasData)
                    {
                      
                      const Text("Loading.....");
                    }
                    else {
                      
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            
                            child: Text(
                              
                              snap.reference.id,
                              style: TextStyle(color: Colors.white),
                              
                            ),
                            value: "${snap.id}",
                          ),
                        );
                      }return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          
                          DropdownButton(
                            
                            items: currencyItems,
                            onChanged: (currencyValue) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'Proveedor: $currencyValue',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                              // ignore: deprecated_member_use
                              Scaffold.of(context).showSnackBar(snackBar);
                              
                              setState(() {
                                selectedCurrency = currencyValue;
                                print
                                (selectedCurrency);
                                nombre.text = selectedCurrency;
                               db
                .collection('NombresProveedores').where('Id', isEqualTo: selectedCurrency)
                .snapshots()
                .listen((result) {
                result.docs.forEach((result) { 
                  telefono = result.data()['NumeroProveedor'];
                  correo = result.data()['CorreoProveedor'];
                  idPro = result.data()['Id'];
                });
          

                    print("telefono: "+ telefono);
                    print("Correo: "+ correo);
                });
                              });
                              
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Seleccione Un Proveedor",
                              style: TextStyle(color: Colors.black),
                            ),
                            dropdownColor: Colors.black,
                            icon: Icon(Icons.arrow_drop_down, color: Colors.black, size: 22.0,),
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  }),
             
                SizedBox(height: 20,),
                Text("Nombre del Proveedor: "+ nombre.text, style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(color: Colors.black),
                        )),
                SizedBox(height: 10,),

SizedBox(height: 20.0,),
  
               
                 SizedBox(height:20),
                 
                 RaisedButton(
                   color: Colors.black87,
                   elevation: 5.0,
                   child: Text("Agregar",style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )

                )),
                   shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.black),
),
padding: EdgeInsets.all(20.0),
                   onPressed: (){

                     if( _nombreProducto.text.isEmpty)
                     {
                       Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "No deje campos Vacios",
  message: "Llene todos los campos",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);
                     }
                    
                     print(telefono);
                          db
                .collection('Codigos')
                .snapshots()
                .listen((result) {
                result.docs.forEach((result) { 
                  codigo = result.data()['Codigo'].toString();

                });
          

                    print("Codigo rd"+ codigo);
                });
                       

               
  if(_checkboxValue==0)
  {
    categoria ="Cantera";
    codigoGen = "CA00"+codigo.toString();
    print("Codigo: "+codigoGen);
  }
  if(_checkboxValue==1)
  {
    categoria ="Cuarzo";
    codigoGen = "CU00"+codigo.toString();
    print("Codigo: "+codigoGen);
  }
  if(_checkboxValue==2)
  {
    categoria ="Deck";
    codigoGen = "DE00"+codigo.toString();
    print("Codigo: "+codigoGen);
  }
  if(_checkboxValue==3)
  {
    categoria ="Granito";
    codigoGen = "GR00"+codigo.toString();
    print("Codigo: "+codigoGen);
  }
  if(_checkboxValue==4)
  {
    categoria ="Marmol";
    codigoGen = "MA00"+codigo.toString();
    print("Codigo: "+codigoGen);
  }
  if(_checkboxValue==5)
  {
    categoria ="Piel de elefante";
    codigoGen = "PE00"+codigo.toString();
    print("Codigo: "+codigoGen);
  }
  if(_checkboxValue==6)
  {
    categoria ="Pisos";
    codigoGen = "PI00"+codigo.toString();
    print("Codigo: "+codigoGen);
  }
  if(_checkboxValue==7)
  {
    categoria ="Porfido";
    codigoGen = "PO00"+codigo.toString();
    print("Codigo: "+codigoGen);
  }
  
  

  
  switch(switchValue)
  {
    case 0:
    selected ="Fiscal";
    break;
    case 1:
    selected ="No Fiscal";
    break;

  }
 
  nombreProd = _nombreProducto.text;
  cantidadProd2 = _cantidadProducto.text;
  descripcion = _descripcion.text;
String uuid = Uuid().v4();
 
  
  FirebaseFirestore.instance.collection("Calidad").add({'Categoria': '$categoria','NombreProducto': '$nombreProd',  'Codigo': '$uuid', 'NombreProveedor': '$selectedCurrency', 'Telefono': '$telefono', 'Correo': '$correo', 'Id': '$idPro','Imagen': '$url2','Cantidad':'$cantidadProd2','Descripcion': '$descripcion'});
 
 _nombreProducto.text="";
 _cantidadProducto.text ="";
 _descripcion.text = "";

  Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Producto Agregado",
  message: "Se Agrego correctamente en la base de datos",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);

  
 
                     }


                            
                 
                 
                 ),
                 
             

           ],
         ),
         
       ),

        floatingActionButton: FloatingActionButton(
          onPressed: _getImage,
          tooltip: 'Agregar',
          child: Icon(Icons.camera_alt),
        ),
        
    );
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
        Text('Agrega un Producto Dañado', style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w900),),
        IconButton(icon: Icon(Icons.camera_alt_rounded , color: Colors.black), onPressed: (){

          _getImage();

        }),
      ],),
    ),
  );
}



void incorrecto()
{
showGeneralDialog(
      barrierLabel: "Label",
      
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: this.context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            child: SizedBox.expand(child: Image(image: AssetImage('assets/error.gif'))),
            
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Color(0xFF1B1B1B),
              borderRadius: BorderRadius.circular(40),
            ),
            
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
}





 

}