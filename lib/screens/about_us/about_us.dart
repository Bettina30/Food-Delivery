import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colo,
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Text(
            "Delight in Every Bite, Right at Your Doorstep!"
                "\n \nFOOD RUSH is the fastest and easiest way to order food from the restaurants. We have a wide selection of food items to choose from, and our app is easy to use and navigate. Plus, our food is delivered to you hot and fresh, every time."
                "\nOur mission is to make it easy and convenient for people to enjoy delicious food from the restaurants. We want to be the go-to food delivery app for everyone."
                "\nWe are committed to providing our customers with the best possible experience. We value quality, customer service, and innovation."
                "\n \nWe hope you enjoy using FOOD RUSH"),
      ),
    );
  }
}
