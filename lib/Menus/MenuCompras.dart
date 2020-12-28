import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unik_inv/Entradas/Login.dart';
import 'package:unik_inv/GastosRapidos/add_page.dart';
import 'package:unik_inv/Salidas/VistaListaGastos.dart';
import 'package:unik_inv/Salidas/VistaProovedorCompras.dart';

 class MenuCompras extends StatefulWidget {
  MenuCompras({Key key}) : super(key: key);

  @override
  _MenuComprasState createState() => _MenuComprasState();
}
var selectedItem = 0;
int _page = 0;
class _MenuComprasState extends State<MenuCompras> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar:  CurvedNavigationBar(
        
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.add, size: 18, color: Colors.white),
            Icon(Icons.list, size: 18, color: Colors.white),
            Icon(Icons.compare_arrows, size: 18, color: Colors.white),
            Icon(Icons.call_split, size: 18, color: Colors.white),
            Icon(Icons.perm_identity, size: 18, color: Colors.white),
          ],
          color: Colors.black,
          buttonBackgroundColor: Colors.black,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
              switch(_page)
              {
                case 1:
                  Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  Login()));
                break;
              }
            });
          },
        ),
      backgroundColor: Colors.black,
      body: new Column(
        
      children: <Widget>[
        SizedBox(height: 20.0),
        Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                Text('MENU COMPRAS',
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
                
                    
                    _buildListGastos('assets/expenses.jpg', 'Gastos',
                    'Agregue Sus Gastos'),
                    _buildListaGastos('assets/inventariounik.jpg', 'Lista de Gastos',
                    ''),
                    _buildListCompras('https://firebasestorage.googleapis.com/v0/b/unik-b4f2f.appspot.com/o/Menu%2Fproducto.jpg?alt=media&token=18c59919-81d3-486c-93d2-029925d4b031', 'Productos',
                    'Ver Los Productos de sus Proveedores'),
                   
                    
              ],
            ))
      ],
      )
      
      
      
    );
  }
  
  _buildListCompras(String imgPath, String country, String description) {
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
                      image: NetworkImage(imgPath),
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
                            builder: (context) =>  VistaProovedorCompras(imgPath: imgPath, title: country,)));
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
   
   _buildListGastos(String imgPath, String country, String description) {
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
                            builder: (context) =>  AddPage()));
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


 _buildListaGastos(String imgPath, String country, String description) {
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
                      image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/unik-b4f2f.appspot.com/o/Menu%2Fgastos.jpg?alt=media&token=e6ddd6a5-00d0-4dc0-98ab-51a73400a05e'),
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
                            builder: (context) =>  VistaListaGastos(imgPath: imgPath, title: country)));
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