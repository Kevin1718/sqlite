import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'student.dart';
import 'crud_operations.dart';
import 'main.dart';

class Insert extends StatefulWidget {
  @override
  _inserta createState() => new _inserta();
}
class _inserta extends State<Insert> {
  Future<List<Student>> Studentss;
  TextEditingController contr1 = TextEditingController();
  TextEditingController contr2  = TextEditingController();
  TextEditingController contr3  = TextEditingController();
  TextEditingController contr4  = TextEditingController();
  TextEditingController contr5  = TextEditingController();
  TextEditingController contr6  = TextEditingController();
  String name;
  String lastname;
  String surname;
  String mail;
  String tel;
  String matri;
  int currentUserId;
  var bdHelper;
  bool isUpdating;
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  final formkey = new GlobalKey<FormState>();

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
    contr5.text = "";
    contr6.text = "";
  }

  void dataValidate() async {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (isUpdating) {
        Student stu = Student(currentUserId, name, surname, lastname, matri, mail, tel);
        bdHelper.update(stu);
        setState(() {
          isUpdating = false;
        });
      } else {
        Student stu = Student(null, name, surname, lastname, matri, mail, tel);
        var validation = await bdHelper.validateInsert(stu);
        print(validation);
        if (validation) {
          bdHelper.insert(stu);
          final snackbar = SnackBar(
            content: new Text("DATOS INGRESADOS!"),
            backgroundColor: Colors.greenAccent,
          );
          _scaffoldkey.currentState.showSnackBar(snackbar);
        } else {
          final snackbar = SnackBar(
            content: new Text("Ya hay una matricula igual!"),
            backgroundColor: Colors.blueAccent,
          );
          _scaffoldkey.currentState.showSnackBar(snackbar);
        }
      }
      cleanData();
      refreshList();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Insertar datos de alumno"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              TextFormField(
                controller: contr1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Nombre"),
                validator: (val) => val.length == 0 ? 'Ingresa el nombre' : null,
                onSaved: (val) => name = val,
              ),
              TextFormField(
                controller: contr2,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Primer apellido"),
                validator: (val) => val.length == 0 ? 'Ingresa el apellido' : null,
                onSaved: (val) => surname = val,
              ),
              TextFormField(
                controller: contr3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Segundo apellido"),
                validator: (val) => val.length == 0 ? 'Ingresa el segundo apellido' : null,
                onSaved: (val) => lastname = val,
              ),
              TextFormField(
                controller: contr6,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Matricula"),
                validator: (val) => val.length == 0 ? 'Ingresa una matricula' : null,
                onSaved: (val) => matri = val,
              ),
              TextFormField(
                controller: contr4,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "correo"),
                validator: (val) => !val.contains('@') ? 'Ingresa un correo' : null,
                onSaved: (val) => mail = val,
              ),
              TextFormField(
                controller: contr5,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Numero"),
                validator: (val) =>
                val.length < 10 ? 'Ingresa el telefono' : null,
                onSaved: (val) => tel = val,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blueAccent)),
                    onPressed: dataValidate,
                    child: Text(isUpdating ? 'Update' : 'Añadir '),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.greenAccent)),
                    onPressed: () {
                      setState(() {
                        isUpdating = false;
                      });
                      cleanData();
                    },
                    child: Text('Cancelar'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}