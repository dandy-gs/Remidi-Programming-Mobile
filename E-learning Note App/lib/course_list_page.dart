import 'package:crud_operation/add_new_course.dart';
import 'package:crud_operation/db_helper.dart';
import 'package:crud_operation/update_delete_page.dart';
import 'package:flutter/material.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  _CourseListPageState createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  List<Map<String, dynamic>> allCourses = [];

  void refreshCourses() async {
    final data = await DBHelper.getAllCourses();
    setState(() {
      allCourses = data;
    });
  }

  @override
  void initState() {
    refreshCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      refreshCourses();
    });

    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: const Text("E-Learning App"),
        backgroundColor: Colors.white24,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateDeletePage(
                            id: allCourses[index]['id'],
                            orgNamaKursus: allCourses[index]['NamaKursus'],
                            orgWaktu: allCourses[index]['Waktu'],
                            orgHarga: allCourses[index]['Harga'],
                          )));
            },
            child: Details(
              NamaKursus: allCourses[index]['NamaKursus'],
              Waktu: allCourses[index]['Waktu'],
              Harga: allCourses[index]['Harga'],
            ),
          );
        },
        itemCount: allCourses.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogFunc(context);
          // Navigator.push(context,MaterialPageRoute(builder: (context)=>AddNewCourse()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future showDialogFunc(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: AddNewCourse(),
          );
        });
  }
}

class Details extends StatelessWidget {
  // const Details({Key? key}) : super(key: key);
  final String NamaKursus, Waktu, Harga;

  Details({
    required this.NamaKursus,
    required this.Waktu,
    required this.Harga,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        color: Colors.white24,
        margin: EdgeInsets.all(10),
        child: Container(
          width: 190,
          margin: EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.network(
                      "https://media.istockphoto.com/photos/elearning-concept-online-classes-picture-id1140691163?k=20&m=1140691163&s=612x612&w=0&h=3Cheju65N4DYbgsH-bfFj_-6T_wZKkf_svoj0uRLLtg=",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$NamaKursus",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Durasi Kursus : $Waktu hari",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text("Harga Kursus : \Rp. $Harga",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
