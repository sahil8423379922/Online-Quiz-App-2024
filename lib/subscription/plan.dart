import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:online_quiz_app/dashboard/dashboard.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  // State variable to track the selected radio button
  int? _selectedValue;
  late Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment successful: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment error: ${response.code} | ${response.message}');
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Dashboard(),
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External wallet selected: ${response.walletName}');
  }

  //Opening Payment Gateway
  void openCheckout() {
    var options = {
      'key': 'your_api_key', // Add your Razorpay API key here
      'amount': 100, // Amount in paise (100 = 1 INR)
      'name': 'Test Payment',
      'description': 'Test transaction',
      'prefill': {
        'contact': '1234567890',
        'email': 'test@example.com',
      },
      'external': {
        'wallets': ['paytm'] // Optionally enable Paytm or other wallets
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 241, 241, 241),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Select Your Plan to\nGet the Unlimited Access",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        openCheckout();
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Unlimited Access",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: Text("\$2.3/Month"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                // Adjusts spacing between items
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: 20.0,
                                          color: Colors.green,
                                        ), // Icon
                                        SizedBox(
                                            width:
                                                8.0), // Spacing between icon and text
                                        Text(
                                            'Ads Free'), // Text next to the icon
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.check,
                                          size: 20.0,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 8.0),
                                        Text('Weekly Updates'),
                                      ],
                                    ),
                                  ),

                                  // Add more Row widgets for more icons and labels
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10, // Adjust as needed
                      right: 10,
                      // Adjust as needed
                      child: Radio<int>(
                        value: 1, // Value of this radio button
                        groupValue: _selectedValue, // Current selected value
                        onChanged: (int? value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Stack(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Free Access",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: Text("\$0/Month"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              // Adjusts spacing between items
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/close.png', // Path to your asset
                                        width: 16.0, // Size of the image
                                        height: 16.0,
                                        color: Colors
                                            .red, // Apply color overlay if needed (only works with monochrome images)
                                      ),
                                      SizedBox(
                                          width:
                                              8.0), // Spacing between icon and text
                                      Text('Ads Free'), // Text next to the icon
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/close.png', // Path to your asset
                                        width: 16.0, // Size of the image
                                        height: 16.0,
                                        color: Colors
                                            .red, // Apply color overlay if needed (only works with monochrome images)
                                      ),
                                      SizedBox(width: 8.0),
                                      Text('Weekly Updates'),
                                    ],
                                  ),
                                ),

                                // Add more Row widgets for more icons and labels
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10, // Adjust as needed
                      right: 10,
                      // Adjust as needed
                      child: Radio<int>(
                        value: 1, // Value of this radio button
                        groupValue: _selectedValue, // Current selected value
                        onChanged: (int? value) {
                          setState(() {
                            _selectedValue = value;
                          });
                        },
                      ),
                    ),
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
