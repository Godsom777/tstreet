// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:paystack_manager/paystack_manager.dart';

// class PaymentService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> initiatePayment(BuildContext context) async {
//     var user = _auth.currentUser;
//     if (user == null) {
//       // Handle user not logged in
//       return;
//     }

//     // Initialize PaystackManager with your public key
//     PaystackPayManager(context: context)
//       ..setSecretKey("YOUR_PAYSTACK_PUBLIC_KEY")
//       // Set transaction parameters
//       ..setAmount(10000) // Amount in kobo
//       ..setEmail(user.email!)
//       ..setReference(DateTime.now().millisecondsSinceEpoch.toString())
//       // Handle the response from Paystack
//       ..onSuccesful(_onPaymentSuccessful)
//       ..onFailed(_onPaymentFailed)
//       ..initialize();
//   }

//   Future<void> _onPaymentSuccessful(Transaction transaction) async {
//     // Verify payment on your server
//     var response = await http.post(
//       Uri.parse("YOUR_BACKEND_ENDPOINT_TO_VERIFY_PAYMENT"),
//       body: {'reference': transaction.reference},
//     );

//     if (response.statusCode == 200) {
//       // Assuming your API returns a success status for verified payments
//       await _updateUserPaymentStatus();
//     } else {
//       // Handle payment verification failure
//     }
//   }

//   void _onPaymentFailed(Transaction transaction) {
//     // Handle payment failure
//   }

//   Future<void> _updateUserPaymentStatus() async {
//     var user = _auth.currentUser;
//     if (user != null) {
//       await _firestore.collection('users').doc(user.uid).update({
//         'paid': true,
//       });
//     }
//   }
// }