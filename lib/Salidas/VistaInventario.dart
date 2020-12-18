

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as s;



 class VistaInventario extends StatefulWidget {
  final imgPath, title;

  VistaInventario({this.imgPath, this.title});

  @override
  _VistaInventarioState createState() => _VistaInventarioState();
}

//Variables
DateTime now = DateTime.now();
String id; 
String url; 
String hora = DateFormat('yyyy-MM-dd').format(now);
 dynamic image;
//Variables Firestore
final db = FirebaseFirestore.instance;
DocumentSnapshot doc;

var downUrl;
//Variables de edicion de inventario
String producto;
dynamic cantidad, obtCantidad;
String obtVariedad, photoUrl;
dynamic selected;
String filename;
//Agregar Inventario
dynamic cantidadInventario, agregado;
//TextEditingController _textFieldCantidad = TextEditingController();

String idimagen;

//Selector
String category="Piedras", nuevaCategoria;


class _VistaInventarioState extends State<VistaInventario> {
  Future _getImage() async{
    
  // ignore: deprecated_member_use
  var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);

  

    setState(() {
        image = selectedImage;
        filename = s.basename(image.path);
        uploadImage();
        });
      
    
    
}



Future<String>uploadImage() async{
  Reference ref = FirebaseStorage.instance.ref().child(filename);
  UploadTask uploadTask = ref.putFile(image);
   downUrl = await(await uploadTask).ref.getDownloadURL();
 url = downUrl.toString();
  subirimagen();

  print("Download URL : $url");
  return url;
}

subirimagen(){
 FirebaseFirestore.instance
            .collection('Inventario')
            .doc(idimagen)
            .update({'Imagen': url });
}


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imgPath), fit: BoxFit.cover)
              
            ),
          ),
          BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.0, 35.0, 15.0, 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 40.0,
                  width: 35.0,
                  
                  child: Center(
                    child: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: ()
                    {
                         Navigator.pop(context);

                    }),
                    
                  )
                  
                ),
                Text(widget.title.toString().toUpperCase(),
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  textStyle: TextStyle(color: Colors.white)
                )
                ),
                Container(
                  height: 40.0,
                  width: 40.0,
                  
                  child: Center(
                    child: Icon(Icons.bookmark_border, color: Colors.white),
                  ),
                ),
              ],
            )
          ),
          Positioned(
            top: 80.0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  
                  SizedBox(height: 10.0),
                  Text(hora,
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(color: Colors.white),
                        )
                        ),
                  
                 SizedBox(height: 10.0,),
                 
                    
    Container(
       height: 100,
       
          alignment: Alignment.center,
          width: 200,
          child: CupertinoPicker(
            
            itemExtent: 50,
            onSelectedItemChanged: (dynamic i) {
              setState(() {
                selected = i;
                
                if(selected==0)
                {
                  selected ="Cantera";
                  print(selected);
                }
                else if (selected==1)
                {
                  selected="Cuarzo";
                  print(selected);
                }
                else if (selected == 2)
                {
                  selected="Deck";
                  print(selected);
                }
                else if (selected == 3)
                {
                  selected="Granito";
                  print(selected);
                }
                else if (selected == 4)
                {
                  selected="ManoFactura";
                  print(selected);
                }
                else if (selected == 5)
                {
                  selected="Marmol";
                  print(selected);
                }
                else if (selected == 6)
                {
                  selected="Piel de elefante";
                  print(selected);
                }
                else if (selected == 7)
                {
                  selected="Pisos";
                  print(selected);
                }
                else if (selected == 8)
                {
                  selected="Porfido";
                  print(selected);
                }
                
              });
            },
            looping: true,
            children: <Widget>[
              Center(
                child: Text(
                  "Cantera",
                  style: TextStyle(
                      color: selected == 0 ? Colors.black : Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Cuarzo",
                  style: TextStyle(
                      color: selected == 1 ? Colors.black : Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Deck",
                  style: TextStyle(
                      color: selected == 2 ? Colors.black : Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Granito",
                  style: TextStyle(
                      color: selected == 3 ? Colors.black : Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "ManoFactura",
                  style: TextStyle(
                      color: selected == 4 ? Colors.black : Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Marmol",
                  style: TextStyle(
                      color: selected == 5 ? Colors.black : Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Piel de elefante",
                  style: TextStyle(
                      color: selected == 5 ? Colors.black : Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Pisos",
                  style: TextStyle(
                      color: selected == 5 ? Colors.black : Colors.white),
                ),
              ),
              Center(
                child: Text(
                  "Porfido",
                  style: TextStyle(
                      color: selected == 5 ? Colors.black : Colors.white),
                ),
              ),
            ],
          ),
    ),
    
    
                  
                 Container(
                    height: 500.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        
                        
                        
                        StreamBuilder<QuerySnapshot>(
                          
            stream: db.collection('Inventario').where("Categoria", isEqualTo: selected).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.docs.map<Widget>((doc) => _buildListItem(doc)).toList());
                
              } else {
                return SizedBox();
              }
            },
            
          ),
         
            

          
                      ],
                      
                    )
                    
                  )
                  
                ],
              )
              
            )
          )
        ],
      ),
      
    
    );
  }
  
 

//builder de cards para inventario 
  _buildListItem(DocumentSnapshot doc) {

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            height: 185.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              image: DecorationImage(
                image: AssetImage('assets/black.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken)
              )
            )
          ),
          Positioned(
            top: 20.0,
            left: 15.0,
            child: Container(
              height: 30.0,
              width: 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white
              ),
              child: Center(
                
                child: IconButton(
                  alignment: Alignment.center,
  icon: new Icon(Icons.info, color: Colors.black, size: 16.0,),
  onPressed: () { _editarInventario(this.context, doc); },
  
)


                
              )
              
            ),

          ),
          Positioned(
            top: 15.0,
            right: 35.0,
            child: Container(
              height: 30.0,
              width: 35.0,
              
              child: Center(
                
                child: IconButton(
                  alignment: Alignment.center,
  icon: new Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16.0,),
  onPressed: () { 


         _getImage();   

        setState(() {
          idimagen = doc.id;
        });
         



   },
  
)


                
              )
              
            )
            
          ),
          Positioned(
            bottom: 15,
            right: -5,
            child: Container(
                  child: Image.network("${doc.data()['Imagen']}", height: 120, width: 120,),
                ),),
          Positioned(
            top: 60.0,
            left: 35.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Categoria: \n -${doc.data()['Categoria']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ),
                Text("Nombre: \n -${doc.data()['NombreProducto']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ),
                Text("Cantidad: \n -${doc.data()['Cantidad']} ${doc.data()['Unidad']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )
                ),
               
                SizedBox(height: 12),
                
              ],
              
            )
            
          ),
          
      
        ]
        
      )
      
    );
    
  }
  _editarInventario(BuildContext context, DocumentSnapshot doc) async {

  producto = doc.data()['Producto'];
    cantidad = doc.data()['Cantidad'];

    

    return showDialog(
                      context: context,
                      builder: (_) => NetworkGiffyDialog(
                            
                            image: Image.network(
                              "${doc.data()['Imagen']}",
                              fit: BoxFit.cover,
                            ),
                            entryAnimation: EntryAnimation.TOP_LEFT,
                            title: Text(
                              '${doc.data()['NombreProducto']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w600),
                            ),
                            description: Text(
                              '${doc.data()['Categoria']}\n${doc.data()['Codigo']}\n${doc.data()['Fiscal']}\nUbicación: ${doc.data()['Ubicacion']}\n Cantidad: ${doc.data()['Cantidad']} ${doc.data()['UnidadMedida']}',
                              textAlign: TextAlign.center,
                            ),

                            onOkButtonPressed: () {Navigator.of(context, rootNavigator: true).pop();},
                          ));

  }


  

 
 void deleteData(DocumentSnapshot doc) async {
    await db.collection('Inventario').doc(doc.id).delete();
    
  }


  void updateCantidad(DocumentSnapshot doc) async {
    cantidadInventario = doc.data()['Cantidad'];

  
    cantidadInventario += obtCantidad;
    await db.collection('Inventario').doc(doc.id).update({'Cantidad': cantidadInventario});
  
    
  }

}








