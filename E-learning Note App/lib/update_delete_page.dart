import 'package:crud_operation/course_list_page.dart';
import 'package:crud_operation/db_helper.dart';
import 'package:flutter/material.dart';

class UpdateDeletePage extends StatefulWidget {
  final int id;
  final String orgNamaKursus;
  final String orgWaktu;
  final String orgHarga;

  UpdateDeletePage({
    required this.id,
    required this.orgNamaKursus,
    required this.orgWaktu,
    required this.orgHarga,
  });

  @override
  _UpdateDeletePageState createState() => _UpdateDeletePageState();
}

class _UpdateDeletePageState extends State<UpdateDeletePage> {
  final _FormKey = GlobalKey<FormState>();

  var NamaKursus = "";
  var Harga = "";
  var Waktu = "";

  final NamaKursusController = TextEditingController();
  final HargaController = TextEditingController();
  final WaktuController = TextEditingController();

  Future<void> UpdateCourse(
      int id, String NamaKursus, String Harga, String Waktu) async {
    await DBHelper.updateCourses(id, NamaKursus, Waktu, Harga);
    Navigator.pop(context);
  }

  Future<void> DeleteCourse(int id) async {
    await DBHelper.deleteCourse(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    NamaKursusController.text = widget.orgNamaKursus;
    HargaController.text = widget.orgHarga;
    WaktuController.text = widget.orgWaktu;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update & Hapus Kursus"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _FormKey,
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              const Text(
                "Update/Hapus Kursus ",
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
                          hintText: "Masukan Nama Kursus"),
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
                          labelText: "Waktu", hintText: "Masukan Waktu"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Waktu tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: HargaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Harga",
                        hintText: "Masukan Harga",
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text("UPDATE"),
                          onPressed: () {
                            if (_FormKey.currentState!.validate()) {}
                            ;
                            setState(() {
                              NamaKursus = NamaKursusController.text;
                              Harga = HargaController.text;
                              Waktu = WaktuController.text;
                              UpdateCourse(widget.id, NamaKursus, Waktu, Harga);
                            });
                          },
                          style:
                              ElevatedButton.styleFrom(shape: StadiumBorder()),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          child: const Text("DELETE"),
                          onPressed: () {
                            if (_FormKey.currentState!.validate()) {}
                            ;
                            setState(() {
                              DeleteCourse(widget.id);
                            });
                          },
                          style:
                              ElevatedButton.styleFrom(shape: StadiumBorder()),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
