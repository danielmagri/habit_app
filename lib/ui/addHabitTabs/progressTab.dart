import 'package:flutter/material.dart';
import 'package:habit/objects/Progress.dart';
import 'package:habit/utils/enums.dart';
import 'package:habit/utils/Color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habit/utils/Validator.dart';

class ProgressTab extends StatefulWidget {
  ProgressTab({Key key, this.category, this.onTap}) : super(key: key);

  final CategoryEnum category;
  final Function onTap;

  @override
  _ProgressTabState createState() => new _ProgressTabState();
}

class _ProgressTabState extends State<ProgressTab> {
  int _chosen = 2;

  int _numeric;
  String _unit;

  int _days;

  void _validate() {
    if (_chosen == 0) {
      Progress progress = new Progress(type: ProgressEnum.NUMBER, goal: _numeric, progress: 0);

      widget.onTap(true, progress);
    } else if (_chosen == 1) {
      Progress progress = new Progress(type: ProgressEnum.DAY, goal: _days, progress: 0);

      widget.onTap(true, progress);
    } else if (_chosen == 2) {
      Progress progress = new Progress(type: ProgressEnum.INFINITY, goal: 0, progress: 0);

      widget.onTap(true, progress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 60.0, left: 8.0),
          child: Text(
            "Deseja acompanhar sua meta?",
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w300),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment(0.0, 1.0),
            margin: EdgeInsets.only(bottom: 12.0),
            child: Text(
              "Escolha uma opção:",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Align(
            alignment: Alignment(0.0, -1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      color: CategoryColors.getSecundaryColor(widget.category),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => NumericDialog(
                                  category: widget.category,
                                  numeric: _numeric,
                                  unit: _unit,
                                ),
                          ).then((result) {
                            if (result != null) {
                              setState(() {
                                _chosen = 0;
                                _numeric = result[0];
                                _unit = result[1];
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              border: _chosen == 0
                                  ? Border.all(color: Colors.white, width: 2.0, style: BorderStyle.solid)
                                  : null,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: BoxContent(
                            title: "Defina um valor",
                            example: "Ex. 7kg, 5 livros, 20km",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      color: CategoryColors.getSecundaryColor(widget.category),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => DayDialog(
                                  category: widget.category,
                                  days: _days,
                                ),
                          ).then((result) {
                            if (result != null) {
                              setState(() {
                                _chosen = 1;
                                _days = result;
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              border: _chosen == 1
                                  ? Border.all(color: Colors.white, width: 2.0, style: BorderStyle.solid)
                                  : null,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: BoxContent(
                            title: "Quantidade de dias feito",
                            example: "Ex. Realizar por 60 dias",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Card(
                      color: CategoryColors.getSecundaryColor(widget.category),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _chosen = 2;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              border: _chosen == 2
                                  ? Border.all(color: Colors.white, width: 2.0, style: BorderStyle.solid)
                                  : null,
                              borderRadius: BorderRadius.circular(5.0)),
                          child: BoxContent(
                            title: "Não acompanhar",
                            example: null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                color: CategoryColors.getSecundaryColor(widget.category),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                elevation: 5.0,
                onPressed: () {
                  widget.onTap(false, null);
                },
                child: const Text("VOLTAR"),
              ),
              RaisedButton(
                color: CategoryColors.getSecundaryColor(widget.category),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                elevation: 5.0,
                onPressed: _validate,
                child: const Text("AVANÇAR"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BoxContent extends StatelessWidget {
  final String title;
  final String example;

  BoxContent({
    @required this.title,
    @required this.example,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        example == null
            ? SizedBox(
                height: 0,
              )
            : Expanded(
                child: Center(
                  child: Text(
                    example,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ),
              ),
      ],
    );
  }
}

class NumericDialog extends StatefulWidget {
  NumericDialog({Key key, this.numeric, this.unit, this.category}) : super(key: key);

  final int numeric;
  final String unit;
  final CategoryEnum category;

  @override
  _NumericDialogState createState() => new _NumericDialogState();
}

class _NumericDialogState extends State<NumericDialog> {
  final List _units = ["km", "kg", "Livros", "Outros"];

  TextEditingController _numberController = TextEditingController();

  String _currentUnit;

  List<DropdownMenuItem<String>> _dropDownMenuItems;

  @override
  initState() {
    super.initState();

    _dropDownMenuItems = getDropDownMenuItems();
    _currentUnit = widget.unit != null ? widget.unit : _dropDownMenuItems[0].value;
    if (widget.numeric != null) {
      _numberController.text = widget.numeric.toString();
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String unit in _units) {
      items.add(new DropdownMenuItem(value: unit, child: new Text(unit)));
    }
    return items;
  }

  void _validate() {
    String result = Validate.progressNumericTextValidate(_numberController.text);

    if (result == null) {
      Navigator.of(context).pop({0: int.tryParse(_numberController.text), 1: _currentUnit});
    } else {
      Fluttertoast.showToast(
          msg: result,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color.fromARGB(255, 220, 220, 220),
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5.0,
      backgroundColor: Colors.white,
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: CategoryColors.getSecundaryColor(widget.category)),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "Defina um valor",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text("Defina até onde será sua meta para podermos acompanha-lá com você:"),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    margin: EdgeInsets.only(right: 8.0),
                    child: TextField(
                      controller: _numberController,
                      maxLength: 5,
                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      onEditingComplete: _validate,
                      decoration: InputDecoration(
                        counterText: "",
                      ),
                    ),
                  ),
                  DropdownButton(
                    items: _dropDownMenuItems,
                    value: _currentUnit,
                    onChanged: (selectedCity) => setState(() {
                          _currentUnit = selectedCity;
                        }),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancelar"),
                      ),
                      FlatButton(
                        onPressed: _validate,
                        child: Text(
                          "Ok",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class DayDialog extends StatefulWidget {
  DayDialog({Key key, this.days, this.category}) : super(key: key);

  final int days;
  final CategoryEnum category;

  @override
  _DayDialogState createState() => new _DayDialogState();
}

class _DayDialogState extends State<DayDialog> {
  TextEditingController _numberController = TextEditingController();

  @override
  initState() {
    super.initState();

    if (widget.days != null) {
      _numberController.text = widget.days.toString();
    }
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  void _validate() {
    String result = Validate.progressDayTextValidate(_numberController.text);

    if (result == null) {
      Navigator.of(context).pop(int.tryParse(_numberController.text));
    } else {
      Fluttertoast.showToast(
          msg: result,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color.fromARGB(255, 220, 220, 220),
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 5.0,
      backgroundColor: Colors.white,
      child: Theme(
        data: Theme.of(context).copyWith(accentColor: CategoryColors.getSecundaryColor(widget.category)),
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "Quantidade de dias feito",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text("Defina por quantos dias você quer fazer o hábito até completar a meta:"),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60.0,
                    margin: EdgeInsets.only(right: 8.0),
                    child: TextField(
                      controller: _numberController,
                      maxLength: 5,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      onEditingComplete: _validate,
                      decoration: InputDecoration(
                        hintText: "30",
                        counterText: "",
                      ),
                    ),
                  ),
                  Text(
                    "dias.",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("Cancelar"),
                      ),
                      FlatButton(
                        onPressed: _validate,
                        child: Text(
                          "Ok",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
