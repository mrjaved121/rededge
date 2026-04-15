import 'package:flutter/foundation.dart';

class SuprPayProvider with ChangeNotifier {
  double _balance = 1000.0;
  List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> _cards = [];
  List<Map<String, dynamic>> _contacts = [];

  // Getters
  double get balance => _balance;
  List<Map<String, dynamic>> get transactions => _transactions;
  List<Map<String, dynamic>> get cards => _cards;
  List<Map<String, dynamic>> get contacts => _contacts;

  // Add Funds
  void addFunds(double amount) {
    _balance += amount;
    _addTransaction('Credit', amount, 'Wallet Top-up');
    notifyListeners();
  }

  // Make Payment
  bool makePayment(double amount, String recipient) {
    if (_balance >= amount) {
      _balance -= amount;
      _addTransaction('Debit', amount, 'Payment to $recipient');
      notifyListeners();
      return true;
    }
    return false;
  }

  // Add Card
  void addCard(Map<String, dynamic> card) {
    _cards.add(card);
    notifyListeners();
  }

  // Add Contact
  void addContact(Map<String, dynamic> contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  // Split Expense
  void splitExpense(double totalAmount, List<String> participants) {
    final splitAmount = totalAmount / participants.length;
    _balance -= splitAmount;
    _addTransaction('Debit', splitAmount, 'Split expense with ${participants.length} people');
    notifyListeners();
  }

  // Private method for transactions
  void _addTransaction(String type, double amount, String description) {
    _transactions.insert(0, {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'type': type,
      'amount': amount,
      'description': description,
      'date': DateTime.now(),
    });
  }
}