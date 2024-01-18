import 'package:bloc_firebase_test/dependency_injection/di_container.dart';
import 'package:bloc_firebase_test/model/calculated_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogicMethods {
  final FirebaseFirestore _firestore = locator<FirebaseFirestore>();

  Future<CalculatedData> getTotalValues(String uid) async {
    try {
      double totalMoney = 0;
      double totalRange = 0;
      double totalUsageLiters = 0; //v litrih

      // Query all documents for the current user
      QuerySnapshot querySnapshot =
          await _firestore.collection('data').doc(uid).collection(uid).get();

      // Iterate through each document
      for (var doc in querySnapshot.docs) {
        var data = doc.data() as Map<String, dynamic>;

        totalMoney = totalMoney + data['money'];
        totalRange = totalRange + data['range'];

        // Calculate fuel used for each document and accumulate
        double fuelUsagePerDoc = data['fuelUsage'];
        totalUsageLiters += (fuelUsagePerDoc * data['range']) / 100;
      }

      double averageFuelUsage = (totalUsageLiters / totalRange) * 100;

      final CalculatedData calculatedData = CalculatedData(
          totalMoney: totalMoney,
          totalRange: totalRange,
          totalUsage: totalUsageLiters,
          averageUsage: averageFuelUsage);

      return calculatedData;
    } catch (e) {
      throw e;
    }
  }
}
