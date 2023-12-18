import 'package:flutter/material.dart';
import 'package:kutuphane_otomasyon/home_page.dart';
import 'package:kutuphane_otomasyon/service.dart';
import 'package:flutter/services.dart';

class addBook extends StatefulWidget {
  final String? docID;
  const addBook({Key? key, this.docID}) : super(key: key);

  @override
  _addBookState createState() => _addBookState();
}

class _addBookState extends State<addBook> {
  final FireStoreService fireStoreService = FireStoreService();
  var book = TextEditingController();
  var publisher = TextEditingController();
  var writer = TextEditingController();
  var category = "Seçiniz";
  var number_of_pages = TextEditingController();
  var year_of_publication = TextEditingController();
  var eger = false;

  @override
  Widget build(BuildContext context) {
    var ekranBilgi = MediaQuery.of(context);
    final double ekranGenislik = ekranBilgi.size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Book",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: book,
                decoration: const InputDecoration(
                  hintText: "Kitap Adı",
                  hintStyle: TextStyle(color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: publisher,
                decoration: const InputDecoration(
                  hintText: "Yayın Evi",
                  hintStyle: TextStyle(color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: writer,
                decoration: const InputDecoration(
                  hintText: "Yazarlar",
                  hintStyle: TextStyle(color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: DropdownButtonFormField<String>(
                value: category,
                onChanged: (newValue) {
                  setState(() {
                    category = newValue!;
                  });
                },
                items: <String>[
                  'Seçiniz',
                  'Roman',
                  'Tarih',
                  'Edebiyat',
                  'Şiir',
                  'Ansiklopedi',
                  'Diğer'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: number_of_pages,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
                  ],
                  decoration: const InputDecoration(
                    hintText: "Sayfa Sayısı",
                    hintStyle: TextStyle(color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: year_of_publication,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*$')),
                ],
                decoration: const InputDecoration(
                  hintText: "Basım Yılı",
                  hintStyle: TextStyle(color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Listede yayınlanacak mı?",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Checkbox(
                      value: eger,
                      onChanged: (value) {
                        setState(() {
                          eger = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: ekranGenislik - 120),
              child: ElevatedButton(
                onPressed: () {
                  if (widget.docID != null) {
                    // updateBook metodunu çağırın
                    fireStoreService.updateBook(
                        widget.docID!,
                        book.text,
                        category,
                        writer.text,
                        eger,
                        publisher.text,
                        year_of_publication.text,
                        number_of_pages.text);
                  } else {
                    // addBook metodunu çağırın
                    fireStoreService.addBook(
                        book.text,
                        category,
                        writer.text,
                        eger,
                        publisher.text,
                        year_of_publication.text,
                        number_of_pages.text);
                  }
                  book.clear();
                  number_of_pages.clear();
                  publisher.clear();
                  writer.clear();
                  year_of_publication.clear();
                  Navigator.pop(context, HomePage());
                },
                child: Text("Kaydet"),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(120, 70),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
