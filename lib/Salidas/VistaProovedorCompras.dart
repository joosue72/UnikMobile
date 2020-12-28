

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:unik_inv/Entradas/CrearProducto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:giffy_dialog/giffy_dialog.dart';



class VistaProovedorCompras extends StatefulWidget {
  final imgPath, title;

  VistaProovedorCompras({this.imgPath, this.title});

  @override
  _VistaProovedorComprasState createState() => _VistaProovedorComprasState();
}



 void _launchCaller(int number) async{
    var url = "tel:${telefono.toString()}";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'No se pudo abrir';
    }
  }


//Variables
DateTime now = DateTime.now();
String id;
String telefono, correo;
DocumentSnapshot doc; 
String hora = DateFormat('yyyy-MM-dd').format(now);


class _VistaProovedorComprasState extends State<VistaProovedorCompras> {

  TextEditingController nombre = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final db = FirebaseFirestore.instance;
    var selectedCurrency;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imgPath), fit: BoxFit.cover)
              
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
                    height: 500.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        
                       

             SizedBox(width: 50.0,),
                     StreamBuilder<QuerySnapshot>(
                       
                  stream: db.collection('NombresProveedores').snapshots(),
                  
                  builder: (context, snapshot) {
                    
                    if (!snapshot.hasData)

                      const Text("Loading.....");
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
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Proveedor: $currencyValue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              // ignore: deprecated_member_use
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = currencyValue;
                                print
                                (selectedCurrency);

                                nombre.text = selectedCurrency;
                              });
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Seleccione Un Proveedor",
                              style: TextStyle(color: Colors.white),
                            ),
                            dropdownColor: Colors.black,
                            icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: 22.0,),
                          ),
                        ],
                      );
                    }
                    return LinearProgressIndicator();
                  }),

                  SizedBox(height:20),

                Text("Nombre del Proveedor: "+ nombre.text, style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(color: Colors.white),
                        )),
                SizedBox(height: 10,),
                 

                  Container(
                    height: 500.0,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      padding: EdgeInsets.all(8),
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        
                        
                        
                        StreamBuilder<QuerySnapshot>(
                          
            stream: db.collection('Productos').where("NombreProveedor", isEqualTo: nombre.text).snapshots(),
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
                  
                ],
              )
              
            )
          )
        ],
        
      ),
      floatingActionButton: SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      // this is ignored if animatedIcon is non null
      // child: Icon(Icons.add),
      visible: true,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Ir a',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        
        SpeedDialChild(
          child: Icon(Icons.add_shopping_cart_rounded, color: Colors.black),
          backgroundColor: Colors.white,
          label: 'Nuevo Producto',
          
          onTap: () {
            Route route = MaterialPageRoute(builder: (bc) => CrearProducto());
                                                Navigator.of(context).push(route);
          }
        ),
       
      ],
    ),
      
    );
  }


  _buildListItem(DocumentSnapshot doc) {
    telefono = doc.data()['Telefono'].toString();
    correo = doc.data()['Correo'].toString();
    print(correo);
    return  Slidable(

  actionPane: SlidableDrawerActionPane(),
  actionExtentRatio: 0.25,
  child: Container(
    decoration: BoxDecoration(
     boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 1.0,
                  ),
                ],
    
  ),
  
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        child: Text('Unik',  style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  textStyle: TextStyle(
                    color: Colors.white
                  )
                )),
        foregroundColor: Colors.white,
      ),
      title: Text('${doc.data()['NombreProducto']}'),
      subtitle: Text('${doc.data()['Categoria']}'),

    ),
  ),
  actions: <Widget>[
    
    IconSlideAction(
      caption: 'Llamar',
      color: Colors.indigo,
      icon: Icons.phone_callback,
      onTap: () =>  _launchCaller(int.parse(telefono)),
    ),
  ],
  secondaryActions: <Widget>[
    IconSlideAction(
      caption: 'Detalles',
      color: Colors.black45,
      icon: Icons.more_horiz,
      onTap: () {
        showDialog(
                      context: context,
                      builder: (_) => NetworkGiffyDialog(
                            
                            image: Image.network(
                              "https://asesoresdepymes.com/wp-content/uploads/2019/07/composicion-black-friday-cuatro-bolsas-carro_23-2147709334.jpg",
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
                              '${doc.data()['Categoria']}\n${doc.data()['Codigo']}\n${doc.data()['Fiscal']}\nUltimo Precio: ${doc.data()['UltimoPrecio']}\$',
                              textAlign: TextAlign.center,
                            ),

                            onOkButtonPressed: () {Navigator.of(context, rootNavigator: true).pop();},
                          ));
      }
    ),
    IconSlideAction(
      caption: 'Borrar',
      color: Colors.red,
      icon: Icons.delete,
      onTap: () {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: "¿Quiere Borrar este Producto?",
          confirmBtnText: "Borrar",
          
          onConfirmBtnTap:(){
             deleteData(doc);
             Navigator.of(context, rootNavigator: true).pop();
          },
          cancelBtnText: "Cancelar",
          onCancelBtnTap: (){
            Navigator.of(context, rootNavigator: true).pop();
          },
          confirmBtnColor: Colors.red
        );
      }
    ),
  ],
  
);
    
  }
  

  void deleteData(DocumentSnapshot doc) async {
    await FirebaseFirestore.instance.collection('Productos').doc(doc.id).delete();
    setState(() => id = null);
  }

 
}


