import 'package:crud_operation/db_helper.dart';
import 'package:flutter/material.dart';

class AddNewCourse extends StatefulWidget {
  // const AddNewCourse({Key? key}) : super(key: key);

  @override
  _AddNewCourseState createState() => _AddNewCourseState();
}

class _AddNewCourseState extends State<AddNewCourse> {
  final _FormKey = GlobalKey<FormState>();

  var NamaKursus = "";
  var Harga = "";
  var Waktu = "";

  final NamaKursusController = TextEditingController();
  final HargaController = TextEditingController();
  final WaktuController = TextEditingController();

  Future<void> addCourse(String NamaKursus, String Waktu, String Harga) async {
    await DBHelper.addNewCourses(NamaKursus, Waktu, Harga);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: 400,
        // width: 300,
        child: Material(
          child: Form(
            key: _FormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Tambah Kursus ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: NamaKursusController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Nama Kursus",
                          hintText: "Masukan Nama Kursus",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama Kursus tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: WaktuController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Durasi Kursus",
                          hintText: "Masukan Durasi Kursus",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Durasi Kursus tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: HargaController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            labelText: "Harga", hintText: "Masukan Harga"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harga tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        child: const Text("ADD"),
                        onPressed: () {
                          if (_FormKey.currentState!.validate()) {
                            setState(() {
                              NamaKursus = NamaKursusController.text;
                              Harga = HargaController.text;
                              Waktu = WaktuController.text;
                              addCourse(NamaKursus, Waktu, Harga);
                            });
                          }
                          ;
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //   ),
    // );
  }
}
