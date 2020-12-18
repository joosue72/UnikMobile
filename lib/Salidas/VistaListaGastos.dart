
import 'package:calendar_timeline/calendar_timeline.dart';
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



 class VistaListaGastos extends StatefulWidget {
  final imgPath, title;

  VistaListaGastos({this.imgPath, this.title});

  @override
  _VistaListaGastosState createState() => _VistaListaGastosState();
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

//variables fecha


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
int dia, mes, year;
String idimagen;

//Selector
String category="Piedras", nuevaCategoria;



class _VistaListaGastosState extends State<VistaListaGastos> {





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
            .collection('Gastos')
            .doc(idimagen)
            .update({'Imagen': url });
}


  @override

  Widget build(BuildContext context) {


supportedLocales: [
        const Locale('es'),
        const Locale('en'),
      ];

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
                    height: 600.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      scrollDirection: Axis.vertical,
                      
                      children: <Widget>[
                        CalendarTimeline(
              showYears: true,
              initialDate: DateTime.now(),
              
              firstDate: DateTime(2020, 1, 1),
              lastDate: DateTime.now().add(Duration(days: 900)),
              onDateSelected: (date) {
                setState(() {
                  year = int.parse(date.year.toString());
                  dia = int.parse(date.day.toString());
                  mes = int.parse(date.month.toString());
                  print(dia.toString()+" "+mes.toString());
                });
              },
              leftMargin: 20,
              monthColor: Colors.white70,
              dayColor: Colors.teal[200],
              dayNameColor: Color(0xFF333A47),
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.redAccent[100],
              dotsColor: Color(0xFF333A47),
              
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'es',
            ),
                             
                        StreamBuilder<QuerySnapshot>(
                          
            stream: db.collection('Gastos').where("Mes", isEqualTo: mes).where("Dia", isEqualTo: dia).where("Año", isEqualTo: year).snapshots(),
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
          Container(height: 200.0,
            width: 300.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
             
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                      offset: Offset(
                        2.0, // Move to right 10  horizontally
                        2.0, // Move to bottom 5 Vertically
        ),
                  )  ],
              
            ),
            
          ),
          Positioned(
            top: 13.0,
            right: 5.0,
            child: Container(
              height: 30.0,
              width: 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              
              ),
              child: Center(
                
                child: IconButton(
                  alignment: Alignment.center,
  icon: new Icon(Icons.info, color: Colors.black, size: 23.0,),
  onPressed: () {
    
     _editarInventario(this.context, doc);
     
     
     
      },
  
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
  icon: new Icon(Icons.camera_alt_rounded, color: Colors.black, size: 20.0,),
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
            right: 5,
            child: Container(
                child:   CircleAvatar(
              radius: 50,
              
              backgroundImage: NetworkImage("${doc.data()['Imagen']}"),backgroundColor: Colors.black,)
                ),),
          Positioned(
            top: 30.0,
            left: 15.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Nombre: \n -${doc.data()['Nombre']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                  textStyle: TextStyle(
                    color: Colors.black
                  )
                )
                ),
                Text("Descripcion: \n -${doc.data()['Descripcion']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                  textStyle: TextStyle(
                    color: Colors.black
                  )
                )
                ),
                Text("Cantidad: \n -${doc.data()['Cantidad']}",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                  textStyle: TextStyle(
                    color: Colors.black
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
                              '${doc.data()['Nombre']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w600),
                            ),
                            description: Text(
                              'Descripcion: ${doc.data()['Descripcion']}\n Cantidad: ${doc.data()['Cantidad']} \n Año: ${doc.data()['Año']}\n Mes: ${doc.data()['Mes']} \n Dia: ${doc.data()['Dia']}',
                              textAlign: TextAlign.center,
                            ),

                            onOkButtonPressed: () {Navigator.of(context, rootNavigator: true).pop();},
                          ));

  }


  

 
 void deleteData(DocumentSnapshot doc) async {
    await db.collection('Calidad').doc(doc.id).delete();
    
  }


  void updateCantidad(DocumentSnapshot doc) async {
    cantidadInventario = doc.data()['Cantidad'];

  
    cantidadInventario += obtCantidad;
    await db.collection('Calidad').doc(doc.id).update({'Cantidad': cantidadInventario});
  
    
  }

}