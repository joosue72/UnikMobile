import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:unik_inv/Salidas/VistaCalidad.dart';
import 'package:unik_inv/Salidas/VistaInventario.dart';

import 'package:unik_inv/Entradas/CrearProductoDañado.dart';



 class MenuVentas extends StatefulWidget {
  MenuVentas({Key key}) : super(key: key);

  @override
  _MenuVentasState createState() => _MenuVentasState();
}
var selectedItem = 0;
class _MenuVentasState extends State<MenuVentas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      
      backgroundColor: Colors.black,
      body: new Column(
        
      children: <Widget>[
        SizedBox(height: 20.0),
        Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                Text('MENU INVENTARIO',
                    style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                        textStyle: TextStyle(color: Colors.white))),
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: Colors.black),
                  child: Center(
                    child: Icon(Icons.bookmark_border, color: Colors.white),
                  ),
                )
              ],
            )),
        SizedBox(height: 10.0),
        Container(
            height: MediaQuery.of(context).size.height - 156.0,
            child: ListView(
              children: <Widget>[
                
                    _buildListInventario('assets/inventariounik.jpg', 'Inventario',
                    'Ver Su Inventario'),
                    _buildListInventarioDanado('assets/inventariounik.jpg', 'Inventario Dañado',
                    'Ver Su Inventario Dañado'),
                    _buildRegistroInventarioDanado('assets/inventariounik.jpg', 'Registrar Un Producto Dañado',
                    ''),
                    
                   
                    
              ],
            ))
      ],
      )
      
      
      
    );
  }
  
  
   _buildListInventario(String imgPath, String country, String description) {
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: Stack(
          children: <Widget>[
            Container(height: 300.0),
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken))),
            ),
            Container(
                height: 300.0,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(country,
                        style: GoogleFonts.montserrat(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.white))),
                    Text(description,
                        style: GoogleFonts.montserrat(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            textStyle: TextStyle(color: Colors.white))),
                    SizedBox(height: 20.0),
                    InkWell(
                        onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  VistaInventario(imgPath: imgPath, title: country)));
                        },
                        child: Container(
                            height: 50.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),
                            child: Center(
                                child: Text('Entrar',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        textStyle: TextStyle(
                                            color: Color(0xDD000000)))))))
                  ],
                )))
          ],
        ));
  }

_buildListInventarioDanado(String imgPath, String country, String description) {
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: Stack(
          children: <Widget>[
            Container(height: 300.0),
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/unik-b4f2f.appspot.com/o/Menu%2Fpisos-rotos.jpg?alt=media&token=46454a83-f4fc-42a5-8f6a-cfbbd0ed78e4'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken))),
            ),
            Container(
                height: 300.0,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(country,
                        style: GoogleFonts.montserrat(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.white))),
                    Text(description,
                        style: GoogleFonts.montserrat(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            textStyle: TextStyle(color: Colors.white))),
                    SizedBox(height: 20.0),
                    InkWell(
                        onTap: () {
                         Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  VistaCalidad(imgPath: imgPath, title: country)));
                        },
                        child: Container(
                            height: 50.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),
                            child: Center(
                                child: Text('Entrar',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        textStyle: TextStyle(
                                            color: Color(0xDD000000)))))))
                  ],
                )))
          ],
        ));
  }

  
_buildRegistroInventarioDanado(String imgPath, String country, String description) {
    return Padding(
        padding: EdgeInsets.all(15.0),
        child: Stack(
          children: <Widget>[
            Container(height: 300.0),
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/unik-b4f2f.appspot.com/o/Menu%2Fpisos-rotos.jpg?alt=media&token=46454a83-f4fc-42a5-8f6a-cfbbd0ed78e4'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.6), BlendMode.darken))),
            ),
            Container(
                height: 300.0,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(country,
                        style: GoogleFonts.montserrat(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            textStyle: TextStyle(color: Colors.white))),
                    Text(description,
                        style: GoogleFonts.montserrat(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            textStyle: TextStyle(color: Colors.white))),
                    SizedBox(height: 20.0),
                    InkWell(
                        onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  CrearProductoDa()));
                        },
                        child: Container(
                            height: 50.0,
                            width: 125.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),
                            child: Center(
                                child: Text('Entrar',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        textStyle: TextStyle(
                                            color: Color(0xDD000000)))))))
                  ],
                )))
          ],
        ));
  }
  
  
}