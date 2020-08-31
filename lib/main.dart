import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // global keys
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  // private vars
  String _infoMessage = "Informe os dados";

  void _resetForm() {
    weightController.text = "";
    heightController.text = "";

    setState(() {
      _infoMessage = "Informe os dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoMessage = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoMessage = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoMessage =
            "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoMessage = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoMessage = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else {
        _infoMessage = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetForm,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.assignment_ind,
                      size: 150.0, color: Colors.lightGreen),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.lightGreen)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Por favor, informe seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.lightGreen)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.lightGreen, fontSize: 25.0),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Por favor, informe sua Altura!";
                      }
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Container(
                        height: 50.0,
                        child: RaisedButton(
                          child: Text(
                            "Calcular",
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          color: Colors.lightGreen,
                        ),
                      )),
                  Text(
                    _infoMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25.0, color: Colors.lightGreen),
                  )
                ],
              ),
            )));
  }
}
