
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'student.dart';
import 'crud_operations.dart';
import 'dart:async';
import 'insert.dart';
import 'update.dart';
import 'delete.dart';
import 'select.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage> {

  Future<List<Student>> Studentss;
  TextEditingController contr1 = TextEditingController();
  TextEditingController contr2 = TextEditingController();
  TextEditingController contr3 = TextEditingController();
  TextEditingController contr4 = TextEditingController();
  TextEditingController contr5 = TextEditingController();
  TextEditingController contr6 = TextEditingController();
  String name;
  String lastname;
  String surname;
  String mail;
  String tel;
  String matri;
  int currentUserId;
  var bdHelper;
  bool isUpdating;
  final _scaffoldkey=GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    bdHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = bdHelper.getStudents();
    });
  }

  void cleanData() {
    contr1.text = "";
    contr2.text = "";
    contr3.text = "";
    contr4.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Center(
                child: Text(
                  "MENU (Kevin)",
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('INSERTAR'), onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Insert()));
            },

            ),
            ListTile(
              leading: Icon(Icons.system_update),
              title: Text('UPDATE'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Update()));
              },
            ),
            ListTile(
              leading: Icon(Icons.youtube_searched_for),
              title: Text('BUSCAR'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => select()));
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_sweep),
              title: Text('DELETE'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Delete()));
              },
            ),
          ],
        ),
      ),
      key: _scaffoldkey,
      appBar: new AppBar(
        title: Text("Basic SQL operations"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,

        leading: IconButton(
          icon: Icon(Icons.refresh),
          onPressed: (){
            setState(() {
              refreshList();
            });
          },
        ),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            list(),
          ],
        ),
      ),
    );
  }


  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Nombre"),
          ),
          DataColumn(
            label: Text("Primer apellido"),
          ),
          DataColumn(
            label: Text("Segundo apellido"),
          ),
          DataColumn(
            label: Text("Matricula"),
          ),
          DataColumn(
            label: Text("Direccion de correo"),
          ),
          DataColumn(
            label: Text("Numero de telefono"),
          ),
        ],
        rows: Studentss.map((student) => DataRow(cells: [

          DataCell(
            Text(student.name.toString().toUpperCase()),
            onTap: () {
              setState(() {
                isUpdating = true;
                currentUserId = student.controlum;
              });
              contr1.text = student.name;
            },
          ),
          DataCell(Text(student.lastname.toString().toUpperCase())),
          DataCell(Text(student.surname.toString().toUpperCase())),
          DataCell(Text(student.matri.toString().toUpperCase())),
          DataCell(Text(student.mail.toString().toUpperCase())),
          DataCell(Text(student.tel.toString().toUpperCase())),
        ])).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("No hay datos");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }


  _snack(BuildContext context, String texto) {
    final snackbar = SnackBar(
      content: new Text(texto),
      backgroundColor: Colors.lightGreenAccent,
    );
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }
}