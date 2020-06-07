import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'crud_operations.dart';
import 'student.dart';
import 'dart:async';

class Delete extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<Delete> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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

  var dbHelper;
  bool isUpdating;
  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    refreshList();
  }

  void refreshList() {
    setState(() {
      Studentss = dbHelper.getStudents();
    });
  }

  void ready(){
    setState(() {
      _showSnackBar(context,"Se elimino el alumno de la lista");
    });
  }

  void cleanData() {
    contr1.text = "";
    contr2.text = "";
    contr3.text = "";
    contr4.text = "";
    contr5.text = "";
    contr6.text = "";
  }


  SingleChildScrollView dataTable(List<Student> Studentss) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Borar datos"),
          ),
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
            label: Text("Correo electronico"),
          ),
          DataColumn(
            label: Text("Numero de telefono"),
          ),
          DataColumn(
            label: Text("Matricula"),
          ),
        ],
        rows: Studentss.map((student) => DataRow(cells: [

          DataCell(IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {
              dbHelper.delete(student.controlum);
              refreshList();
              ready();
            },
          )),
          DataCell(Text(student.name.toString().toUpperCase())),
          DataCell(Text(student.lastname.toString().toUpperCase())),
          DataCell(Text(student.surname.toString().toUpperCase())),
          DataCell(Text(student.mail.toString().toUpperCase())),
          DataCell(Text(student.tel.toString().toUpperCase())),
          DataCell(Text(student.matri.toString().toUpperCase())),
        ])).toList(),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Studentss,
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("Not hay datos");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text("Borrar"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: new Container(
        child: new Padding(
            padding: EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                  list(),
                ]
            )
        ),
      ),
    );
  }
  //Snackbar
  _showSnackBar(BuildContext, String texto) {
    final snackBar = SnackBar(
        content: new Text(texto)
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}