import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreditCard {
  String cardNumber;
  String expirationDate;
  String cvcCode;

  Icon icon = Icon(
    Icons.credit_card,
    color: Colors.purple[800],
    size: 40,
  );

  CreditCard(String cardNumber, String expirationDate, String cvcCode) {
    this.cardNumber = cardNumber;
    this.expirationDate = expirationDate;
    this.cvcCode = cvcCode;
  }
}