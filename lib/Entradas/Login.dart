import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:custom_dropdown/custom_dropdown.dart';
import 'package:unik_inv/Animation/FadeAnimation.dart';
import 'package:unik_inv/Menus/MenuInventario.dart';
import 'package:unik_inv/Menus/MenuCompras.dart';




 class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

final myController = TextEditingController();
    final db = FirebaseFirestore.instance;
     String t ;
     int _checkboxValue, usuario;

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    
    return Scaffold(
        resizeToAvoidBottomInset: false,
       body: PageView(
         
        scrollDirection: Axis.vertical  ,
        children: <Widget>[
          
          _pagina1(),
          _pagina2(context),
        ],
      )
    );
  }
   Widget _pagina2(BuildContext context) {

    return Scaffold(
     resizeToAvoidBottomInset: false,
      body: 
      
 Container(
        
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.black,
                Colors.black
            ]
          )
        ),
        
        
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisSize: MainAxisSize.max, 
            children: <Widget>[
            SizedBox(height: 80,),
            
                
               
                  FadeAnimation(1,Text("Login", style: TextStyle(color:Colors.white,fontSize: 50),)),
                  SizedBox(height: 10,),
                  FadeAnimation(2,Text("Bienvenido de nuevo", style: TextStyle(color:Colors.white,fontSize: 18),)),
                
              
            
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(60), topRight:Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      Container(
      child: FadeAnimation(2.1, CustomDropdown(
        valueIndex: _checkboxValue,
        hint: "Seleccion Usuario",
        items: [
          CustomDropdownItem(text: "Admin"),
          CustomDropdownItem(text: "Inventario"),
          CustomDropdownItem(text: "Compras"),
          
        ],
        onChanged: (newValue) {
          setState(() => _checkboxValue = newValue);
          print(_checkboxValue);
        },
      )),
    ),
                      SizedBox(height: 40,),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [ BoxShadow(
                            color: Color.fromRGBO(153, 153, 153,153),
                            blurRadius: 20,
                            offset: Offset(0,10)
                          )]
                        ),
                        child: Column(
                          children: <Widget>[
                           FadeAnimation(2.1, Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: FadeAnimation(2.2,TextField(
                                controller: myController,
                                decoration: InputDecoration(
                                  
                                  hintText: "Introduce tu contraseña",
                                  hintStyle: TextStyle(color:Colors.grey),
                                  border: InputBorder.none
                                ),
                              )),
                            ))
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      
                   
                      
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal:50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[900]
                        ),
                        child: Center(
                      child: FadeAnimation(2.3,RaisedButton(
                              color: Colors.grey[900],
                             child: Text("Login", style: TextStyle(color: Colors.white),),
                             onPressed: (){
                                if(_checkboxValue==0)
                                {
                                 // validarLogin();
                                }
                                if(_checkboxValue==1)
                                {
                                  validarInventario();
                                }
                                if(_checkboxValue==2)
                                {
                                 validarContador();
                                }
                                else
                                {
                                  Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Seleccione Un Usuario",
  message: "Debe Seleccionar un Usuario ó Introducir una contraseña",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);
                                }
                                
                            
                             },
                      ))

                    ),
                      )
  
                    ],
                  )),
              ),
            )
         
          ],
          
          
        ),
      )
       
    );
  
   
  }
  Widget _pagina1() {

    
     return Stack(
       children: <Widget>[
         _colorFonto(),
         _imagenFondo(),
         _textos(),
       ],
     );

  }

  Widget _colorFonto(){

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black
    );


  }



  Widget _imagenFondo(){

    return Positioned(
            top: 170.0,
            left: 40,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Container(
      width: 300,
      height: 300,
    child: Image(image: AssetImage('assets/uniklogo.png'),
    fit: BoxFit.cover,
    ),
    ),
              ],
              )
              
            )
          );

  }

  Widget _textos(){
    
 

    
     
    

    return SafeArea(
          child: Column(
        
        children:<Widget> [
          SizedBox(height: 20.0),
        //  Text(currentPage.toString(), style: estiloTexto),
      //    Text(dia, style: estiloTexto,),
          Expanded(child: Container()),
          
        ],
      ),
    );
  }


  void validarContador()
  {

    
    db
                                          .collection("Accesos")
                                          .snapshots()
                                          .listen((result) {
                                        result.docs.forEach((result) {
                                          t = result.data()['Acceso'].toString();
                                          
                                        
                                           
                                            if(myController.text == t.toString() && t=="Contador#034")
                                            {
                                              Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Bienvenido",
  message: "Ha Iniciado sesion Correctamente",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);
                                                  print("Contador");
                                                  Route route = MaterialPageRoute(builder: (bc) => MenuCompras());
                                                Navigator.of(context).push(route);
                                            }
                                            if(myController.text.isEmpty)
                                            {
                                              Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Ingrese Contraseña",
  message: "Debe introducir una contraseña",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);
                                            }
                                           if(myController.text != "Contador#034")
                                           {
                                             Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Contraseña Incorrecta",
  message: "La contraseña Introducida no es Correcta ó \n Debe introducir una contraseña",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);
                                           }
                                            
                                           
                                        });
                                      
                                               
                                  });
                                  

                                             
                                              
  }
 
  void validarInventario()
  {

    
    db
                                          .collection("Accesos")
                                          .snapshots()
                                          .listen((result) {
                                        result.docs.forEach((result) {
                                          t = result.data()['Acceso'].toString();
                                          
                                           
                                         
                                            if(myController.text == t.toString() && t=="Inventario@002")
                                            {
                                              
  Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Bienvenido",
  message: "Ha Iniciado sesion Correctamente",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);

                                                  print("Inventario");
                                                  Route route = MaterialPageRoute(builder: (bc) => MenuVentas());
                                                Navigator.of(context).push(route);
                                            }
                                           
                                            if(myController.text.isEmpty)
                                            {
                                              Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Ingrese Contraseña",
  message: "Debe introducir una contraseña",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);
                                            }
                                           if( myController.text != "Inventario@001" )
                                           {
                                             Flushbar(
                   flushbarPosition: FlushbarPosition.TOP,
  title: "Contraseña Incorrecta",
  message: "La contraseña Introducida no es Correcta ó \n Debe introducir una contraseña",
  duration: Duration(seconds: 3),
  isDismissible: false,
)..show(context);
                                           }
                                            
                                           
                                        });
                                      
                                               
                                  });
                                  

                                             
                                              
  }
   
}