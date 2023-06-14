import 'package:cloud_firestore/cloud_firestore.dart';

class AppConstant {
  static Future<List<Map<String, dynamic>>> fetchListData() async {
    final collection = FirebaseFirestore.instance.collection('data');
    final querySnapshot = await collection.get();

    final List<Map<String, dynamic>> list = [];
    if (querySnapshot.docs.isNotEmpty) {
      for (var document in querySnapshot.docs) {
        final item = document.data();
        final url = item['postUrl'];
        final lat = item['lat'];
        final long = item['long'];

        list.add({
          'postUrl': url,
          'lat': lat,
          'long': long,
        });
      }
    } else {
      // Handle the case when data retrieval is unsuccessful
      return [

      ];
    }

    return list;
  }
}
