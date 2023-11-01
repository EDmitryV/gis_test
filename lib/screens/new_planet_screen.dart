import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gis_test/models/planet.dart';

class NewPlanetScreen extends StatefulWidget {
  const NewPlanetScreen({super.key});

  @override
  State<NewPlanetScreen> createState() => _NewPlanetScreenState();
}

class _NewPlanetScreenState extends State<NewPlanetScreen> {
  final GlobalKey<FormState> _newPlanetFormKey = GlobalKey<FormState>();
  Color color = Colors.white;
  double? remoteness;
  int? speed;
  double? radius;

  void changeColor(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Параметры новой планеты"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () => Navigator.pop(context, null)),
      ),
      body: Center(
        child: Form(
          key: _newPlanetFormKey,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: double.infinity,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: <Widget>[
                const Text("Параметры новой планеты"),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Радиус'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле радиуса не может быть пустым';
                    }
                    if(double.tryParse(value)==null){
                      return "Радиус может быть только числом";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      radius = double.parse(value);
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Удаленность'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле удаленности не может быть пустым';
                    }
                    if(double.tryParse(value)==null){
                      return "Удаленность может быть только числом";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      remoteness = double.parse(value);
                    }
                  },
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Скорость вращения'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле скорости вращения не может быть пустым';
                    }
                    if (int.tryParse(value) == null) {
                      return "Скорости вращения может быть только целым числом";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      speed = int.parse(value);
                    }
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Цвет планеты:"),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.blueGrey, width: 2.0),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(24),
                            ),
                            color: color),
                      ),
                      onTap: () {
                        showDialog(
                          builder: (context) {
                            Color pickerColor = color;
                            return AlertDialog(
                              title: const Text('Выберите цвет планеты'),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  colorPickerWidth: 200,
                                  pickerColor: pickerColor,
                                  onColorChanged: (newColor) => setState(() {
                                    pickerColor = newColor;
                                  }),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Выбрать'),
                                  onPressed: () {
                                    changeColor(pickerColor);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                          context: context,
                        );
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_newPlanetFormKey.currentState!.validate()) {
                      _newPlanetFormKey.currentState!.save();
                      if (remoteness != null &&
                          radius != null &&
                          speed != null) {
                        Planet planet = Planet(
                            color: color,
                            remoteness: remoteness!,
                            speed: speed!,
                            radius: radius!);
                        Navigator.pop(context, planet);
                      }
                    }
                  },
                  child: const Text('Создать'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
