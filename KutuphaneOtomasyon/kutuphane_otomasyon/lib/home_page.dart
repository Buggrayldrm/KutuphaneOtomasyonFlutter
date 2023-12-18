import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kutuphane_otomasyon/book_add.dart';
import 'package:kutuphane_otomasyon/service.dart';

class Book {
  final String title;
  final String subtitle;

  Book({required this.title, required this.subtitle});
}

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _homePageState();
}

class _homePageState extends State<HomePage> {
  List<Book> bookList = [];
  FireStoreService fireStoreService = FireStoreService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Buğra Yıldırım 02210201002",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getBooksStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String bookName = data['books'];
              String writer = data['writer'];
              String number_of_pages = data['number_of_pages'];
              return BookList(
                title: bookName,
                subtitle: ['Yazar:$writer', 'Sayfa Sayisi:$number_of_pages'],
                docID: document.id,
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addBook()),
          );

          if (result != null && result is Book) {
            setState(() {
              bookList.add(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Books',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.black,
        onTap: (index) {},
      ),
    );
  }
}

class BookList extends StatefulWidget {
  final String title;
  final List<String> subtitle;
  final String docID;
  BookList({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.docID,
  });

  @override
  State<BookList> createState() => _KitapCardState();
}

class _KitapCardState extends State<BookList> {
  FireStoreService fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.title),
        subtitle: Text(widget.subtitle.join(', ')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addBook(docID: widget.docID)),
                );
              },
              child: const Icon(Icons.edit),
            ),
            const SizedBox(width: 20.0),
            GestureDetector(
 onTap: () {
   showDialog(
     context: context,
     builder: (BuildContext context) {
       return AlertDialog(
         title: const Text('Silmek istediğinize emin misiniz?'),
         actions: <Widget>[
           ElevatedButton(
             child: const Text('Evet'),
             onPressed: () {
               // Silme işlemi
               fireStoreService.deleteBook(widget.docID);
               Navigator.pop(context);
             },
           ),
           ElevatedButton(
             child: const Text('Hayır'),
             onPressed: () {
               Navigator.pop(context);
             },
           ),
         ],
       );
     },
   );
 },
 child: const Icon(Icons.delete),
),
          ],
        ),
      ),
    );
  }
}
