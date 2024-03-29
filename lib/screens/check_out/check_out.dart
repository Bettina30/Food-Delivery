import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/routes.dart';
import '../../firebase_helper/firebase_firestore.dart';
import '../../models/product_model.dart';
import '../../provider/app_provider.dart';
import '../../stripe_helper/stripe_helper.dart';
import '../../widgets/primary_button/primary_button.dart';
import '../custom_bottom_bar/custom_bottom_bar.dart';
import 'add_credit_debit_card_view.dart';

class Checkout extends StatefulWidget {
  final ProductModel singleProduct;
  const Checkout({super.key, required this.singleProduct});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController address = TextEditingController();
  TextEditingController customer = TextEditingController();
  TextEditingController phone = TextEditingController();
  int groupValue = 1;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 36.0,
              ),
              TextFormField(
                controller: customer,
                decoration: const InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: address,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Address",
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Phone",
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 3.0)),
                width: double.infinity,
                child: Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    const Icon(Icons.money),
                    const SizedBox(
                      width: 12.0,
                    ),
                    const Text(
                      "Cash on Delivery",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 3.0)),
                width: double.infinity,
                child: Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    const Icon(Icons.money),
                    const SizedBox(
                      width: 12.0,
                    ),
                    const Text(
                      "Pay Online",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              PrimaryButton(
                title: "Continues",
                onPressed: () async {
                  appProvider.clearBuyProduct();
                  appProvider.addBuyProduct(widget.singleProduct);
                  if(groupValue == 1)
                   {
                    bool value = await FirebaseFirestoreHelper.instance
                        .uploadOrderedProductFirebase(
                        appProvider.getBuyProductList,
                        context,
                        groupValue == 1 ? "Cash on delivery" : "Online payment",address.text,customer.text,phone.text);

                    appProvider.clearBuyProduct();
                    if (value && groupValue==1) {
                      Future.delayed(const Duration(seconds: 2), () {
                        Routes.instance.push(
                            widget: const CustomBottomBar(), context: context);
                      });
                    }
                  } if (groupValue == 2)
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddCreditDebitCardView()),
                        );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
