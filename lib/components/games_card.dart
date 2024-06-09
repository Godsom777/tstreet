// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';



  Container games_card() {
    return Container(
    height: 150,
    width: 250,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0x4F252525), width: 0.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0x5D39553E).withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ]),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            RichText(
              text: const TextSpan(
                text: 'Premier',
                style: TextStyle(
                  color: Color(0x90373737),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: ' League',
                    style: TextStyle(
                      color: Color(0xA6F44336),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            RichText(
                text: const TextSpan(
              text: 'Sat',
              style: TextStyle(
                color: Color(0x90373737),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: ' 28 April',
                  style: TextStyle(
                    color: Color(0xA6F44336),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
          ]),
        ],
      ),
    ),
  );
  }