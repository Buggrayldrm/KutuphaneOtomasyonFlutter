import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final CollectionReference books =
      FirebaseFirestore.instance.collection("books");
  Future<void> addBook(
    String book,
    String category,
    String writer,
    eger,
    String publisher,
    String year_of_publication,
    String number_of_pages,
  ) {
    return books.add({
      'books': book,
      'category': category,
      'writer': writer,
      'Liste': eger,
      'publisher': publisher,
      'year_of_publication': year_of_publication,
      'number_of_pages': number_of_pages,
      'timestamp': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getBooksStream() {
    return books.snapshots();
  }

  Future<void> deleteBook(String docID) {
    if (docID.isEmpty) {
      return Future.value();
    }
    return books.doc(docID).delete();
  }

  Future<void> updateBook(
    String docID,
    String book,
    String category,
    String writer,
    eger,
    String publisher,
    String year_of_publication,
    String number_of_pages,
    /* diğer değerler... */
  ) {
    return books.doc(docID).update({
      'books': book,
      'category': category,
      'books': book,
      'category': category,
      'writer': writer,
      'Liste': eger,
      'publisher': publisher,
      'year_of_publication': year_of_publication,
      'number_of_pages': number_of_pages,
      'timestamp': Timestamp.now()
      // Diğer alanları güncelleyin...
    });
  }

  Future<DocumentSnapshot> getBook(String docID) {
    return books.doc(docID).get();
  }
}
