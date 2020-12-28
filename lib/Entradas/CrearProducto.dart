

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';









 class CrearProducto extends StatefulWidget {
  CrearProducto({Key key}) : super(key: key);

  @override
  _CrearProductoState createState() => _CrearProductoState();
}


//Controllers de text
TextEditingController _nombreProducto = TextEditingController();
TextEditingController _pesoProducto = TextEditingController();
TextEditingController _precioProducto = TextEditingController();

TextEditingController nombre = TextEditingController();


//fiscal
String fiscal="";


//Variables Firebase
var selectedCurrency;
final db = FirebaseFirestore.instance;
dynamic nombreProd, canProd, pesoProd;
dynamic cantidadProd;
dynamic codigo, telefono, correo, idPro;
dynamic codigoGen;
dynamic categoria, unidad, ubicacion;
dynamic _checkboxValue;
dynamic switchValue, selected;
DocumentSnapshot doc;
int codigoNuevo;
dynamic _checkboxValue2;
dynamic precio, precioiva;




class _CrearProductoState extends State<CrearProducto> {


   @override
 void initState() { 
   super.initState();
    FirebaseFirestore.instance
                .collection('Codigos')
                .snapshots()
                .listen((result) {
                result.docs.forEach((result) { 
                  codigo = result.data()['Codigo'].toString();
    
                });
          

                    print("Codigo rd"+ codigo);
                });
 }



  @override
  Widget build(BuildContext context) {

    


    return Scaffold(
      appBar: _getCustomAppBar(),
       body:  Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: <Widget>[
             
          
             
         
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
             SizedBox(height: 20,),
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
       SizedBox(height: 20.0,),
  
               CustomDropdown(
                    valueIndex: _checkboxValue2,
                    enabledIconColor: Colors.black,
                    hint: "Unidad De Medida",
                    items: [
                      CustomDropdownItem(text: "Caja"),
                      CustomDropdownItem(text: "Pieza"),
                      CustomDropdownItem(text: "Metros Cuadrados"),
                      CustomDropdownItem(text: "Peso"), 
                    ],
                    onChanged: (newValue) {
                      setState(() {
                      
                        _checkboxValue2 = newValue;
                      } );
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
                
               
                
                SizedBox(height: 20,),
                
                 SizedBox(height:20),
             Text("Precio Del Producto"),
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
                 controller: _precioProducto,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: "    Precio",
                   suffixText: "\$"
                 ),
               ),
               
               ),
               SizedBox(height:20),
             Text("Peso del Producto"),
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
                 controller: _pesoProducto,
                 decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: "     0",
                   suffixText: "Kg"
                 ),
               ),
               
               ),
                  SizedBox(height:20),
                   

                //switch
                LiteRollingSwitch(
    //initial value
    value: false,
    textOn: 'Iva',
    textOff: 'Sin Iva',
    colorOn: Colors.green[700].withOpacity(0.5),
    colorOff: Colors.red[700].withOpacity(0.8),
    iconOn: Icons.done,
    iconOff: Icons.remove_circle_outline,
    textSize: 16.0,
    onChanged: (bool state) {
      selected = state;
      if(selected == true)
      {
        fiscal = "Iva";
      }
      else
      {
        fiscal = "Sin Iva";
      }
    },
),
SizedBox(height: 20,),

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
                     FirebaseFirestore.instance
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
  

    
switch(_checkboxValue2)
  {
    case 0:
    unidad="Caja";
    break;
    case 1:
    unidad="Pz";
    break;
    case 2:
    unidad="M2";
    break;
    case 3:
    unidad="Peso";
    break;
  }

  if(fiscal == "Iva")
  {
  precio = double.parse(_precioProducto.text.toString());
  precioiva = precio;
  precio = precio * 0.16;
  precio += precioiva;
  }
  if(fiscal == "Sin Iva")
  {
    print(precio.toString());
    precio = double.parse(_precioProducto.text.toString());
  
    print("Precio final: "+precio.toString());
  }
 
  nombreProd = _nombreProducto.text;
  pesoProd = _pesoProducto.text;
 
  
  FirebaseFirestore.instance.collection("Productos").add({'Categoria': '$categoria','NombreProducto': '$nombreProd',  'Codigo': '$codigoGen', 'Fiscal': '$fiscal', 'NombreProveedor': '$selectedCurrency',  'Id': '$idPro', 'UltimoPrecio':precio, 'Unidad': '$unidad', 'Peso': double.parse(pesoProd)});
  codigoNuevo = int.parse(codigo)+1;
  FirebaseFirestore.instance.collection('Codigos').doc('Cd').update({'Codigo': codigoNuevo});
 _nombreProducto.text="";
 _pesoProducto.text="";
 _precioProducto.text="";

  Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Producto Agregado",
  message: "Se Agrego correctamente en la base de datos",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);
setState(() {
  
});

  
 
                     }


                            
                 
                 
                 ),
                 
             

           ],
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
        Text('Agrega un Producto', style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w900),),
        IconButton(icon: Icon(Icons.create, color: Colors.black), onPressed: (){}),
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