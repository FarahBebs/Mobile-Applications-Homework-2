// Student: Farah Alhasan
// Student Number: 21120205709

// Week 2 Homework - Simple Shopping Cart Application
// Run with: dart run shopping_cart.dart

import 'dart:io';

// ---------------------------------------------------------------------------
// 3. Object Oriented Programming
// ---------------------------------------------------------------------------

class Product {
  String name;
  double price;

  Product(this.name, this.price);

  @override
  String toString() => '$name - \$${price.toStringAsFixed(2)}';
}

class ShoppingCart {
  List<Product> products = [];
  double totalAmount = 0;

  void addProduct(Product product) {
    products.add(product);
    calculateTotal();
  }

  double calculateTotal() {
    double sum = 0;
    for (var product in products) {
      sum += product.price;
    }
    totalAmount = sum;
    return totalAmount;
  }

  void printProducts() {
    print('\n--- Products in your cart ---');
    for (int i = 0; i < products.length; i++) {
      print('${i + 1}. ${products[i]}');
    }
    print('Total: \$${totalAmount.toStringAsFixed(2)}');
    print('-----------------------------\n');
  }
}

// ---------------------------------------------------------------------------
// 1. Variables and Decision Structures
// ---------------------------------------------------------------------------

/// Returns the discount rate based on the user's age.
double getDiscountRate(int age) {
  if (age < 18) {
    return 0.10;
  } else if (age <= 60) {
    return 0.05;
  } else {
    return 0.15;
  }
}

void main() {
  // The three variables required by the homework.
  int age;
  String customerNumber;
  double totalAmount = 0;

  stdout.write('Enter your age: ');
  age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  while (age <= 0) {
    stdout.write('Please enter a valid age: ');
    age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
  }

  stdout.write('Enter your customer number: ');
  customerNumber = (stdin.readLineSync() ?? '').trim();

  // -------------------------------------------------------------------------
  // 2. Loops - add products until the user types 'q'
  // -------------------------------------------------------------------------
  ShoppingCart cart = ShoppingCart();

  while (true) {
    stdout.write("Enter product name (or 'q' to finish): ");
    String name = (stdin.readLineSync() ?? '').trim();

    if (name.toLowerCase() == 'q') {
      break;
    }
    if (name.isEmpty) {
      print('Product name cannot be empty.');
      continue;
    }

    stdout.write('Enter price of $name: ');
    double? price = double.tryParse(stdin.readLineSync() ?? '');
    if (price == null || price < 0) {
      print('Invalid price, product was not added.');
      continue;
    }

    cart.addProduct(Product(name, price));
    // Total is calculated by the ShoppingCart method.
    totalAmount = cart.calculateTotal();
    cart.printProducts();
  }

  // Apply the age based discount.
  double discountRate = getDiscountRate(age);
  double discount = totalAmount * discountRate;
  double finalAmount = totalAmount - discount;

  print('\n========== RECEIPT ==========');
  print('Customer number : $customerNumber');
  print('Age             : $age');
  print('Number of items : ${cart.products.length}');
  print('Total           : \$${totalAmount.toStringAsFixed(2)}');
  print('Discount (${(discountRate * 100).toInt()}%)  : -\$${discount.toStringAsFixed(2)}');
  print('Amount to pay   : \$${finalAmount.toStringAsFixed(2)}');
  print('=============================');
}
