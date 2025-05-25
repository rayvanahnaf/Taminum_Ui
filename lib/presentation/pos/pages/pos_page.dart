import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pos/models/product.dart';
import 'package:flutter_pos/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:flutter_pos/presentation/order/pages/order_confirmation_page.dart';
import '../../../core/preferences/color.dart';
import '../../auth/pages/login_page.dart';
import '../widgets/product_card.dart';
import '../widgets/order_field.dart';

class PosPage extends StatefulWidget {
  const PosPage({Key? key}) : super(key: key);

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  String selectedCategory = 'Drink';
  final Map<Product, int> cart = {};

  final customerNameController = TextEditingController();
  final tableNumberController = TextEditingController();

  final List<Product> allProducts = [
    Product(name: 'Espresso', price: 4.2, imageUrl: 'assets/coffee.png', category: 'Drink'),
    Product(name: 'Latte', price: 4.0, imageUrl: 'assets/coffee 1.png', category: 'Drink'),
    Product(name: 'Latte', price: 4.0, imageUrl: 'assets/coffee 1.png', category: 'Drink'),
    Product(name: 'Latte', price: 4.0, imageUrl: 'assets/coffee 1.png', category: 'Drink'),
    Product(name: 'Latte', price: 4.0, imageUrl: 'assets/coffee 1.png', category: 'Drink'),
    Product(name: 'Latte', price: 4.0, imageUrl: 'assets/coffee 1.png', category: 'Drink'),
    Product(name: 'Latte', price: 4.0, imageUrl: 'assets/coffee 1.png', category: 'Drink'),
    Product(name: 'Latte', price: 4.0, imageUrl: 'assets/coffee 1.png', category: 'Drink'),
    Product(name: 'Green Jasmine Tea', price: 4.0, imageUrl: 'assets/tea.png', category: 'Snack'),
    Product(name: 'Chamomile', price: 4.0, imageUrl: 'assets/tea 1.png', category: 'Snack'),
    Product(name: 'Chamomile', price: 4.0, imageUrl: 'assets/tea 1.png', category: 'Snack'),
    Product(name: 'Chamomile', price: 4.0, imageUrl: 'assets/tea 1.png', category: 'Snack'),
    Product(name: 'Chamomile', price: 4.0, imageUrl: 'assets/tea 1.png', category: 'Snack'),
    Product(name: 'Chamomile', price: 4.0, imageUrl: 'assets/tea 1.png', category: 'Snack'),
    Product(name: 'Avocado Toast', price: 4.0, imageUrl: 'assets/snacks.png', category: 'Snack'),
    Product(name: 'Avocado Toast', price: 4.0, imageUrl: 'assets/snacks.png', category: 'Snack'),
    Product(name: 'Avocado Toast', price: 4.0, imageUrl: 'assets/snacks.png', category: 'Snack'),
    Product(name: 'Avocado Toast', price: 4.0, imageUrl: 'assets/snacks.png', category: 'Snack'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
    Product(name: 'Acai Bowl', price: 3.0, imageUrl: 'assets/snacks 1.png', category: 'Food'),
  ];

  List<Product> get filteredProducts =>
      allProducts.where((p) => p.category == selectedCategory).toList();

  void _addToCart(Product product) {
    setState(() {
      cart[product] = (cart[product] ?? 0) + 1;
    });
  }

  void _changeQuantity(Product product, int delta) {
    setState(() {
      final currentQty = cart[product] ?? 0;
      final newQty = currentQty + delta;
      if (newQty <= 0) {
        cart.remove(product);
      } else {
        cart[product] = newQty;
      }
    });
  }

  double get total =>
      cart.entries.fold(0.0, (sum, item) => sum + item.key.price * item.value);

  @override
  void dispose() {
    customerNameController.dispose();
    tableNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Logo + Title
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/logo.png', height: 36),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'POS System',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // Center: Search + Orders
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Search Bar
                        SizedBox(
                          width: 400,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search item...',
                              hintStyle: TextStyle(color: secondaryTextColor),
                              filled: true,
                              fillColor: cardColor,
                              prefixIcon: const Icon(Icons.search, color: Colors.white70),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 24),

                        // Orders info
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Orders: ${cart.length}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocListener<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      if (state is LogoutSuccess) {
                        // ✅ Print info ke console
                        print('🔴 Logout Berhasil');
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                              (route) => false,
                        );
                      } else if (state is LogoutFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onSelected: (String value) {
                        switch (value) {
                          case 'settings':
                            Navigator.pushNamed(context, '/settings');
                            break;
                          case 'profile':
                            Navigator.pushNamed(context, '/profile');
                            break;
                          case 'logout':
                          // ✅ Trigger logout event
                            context.read<LogoutBloc>().add(LogoutButtonPressed());
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'settings',
                          child: ListTile(
                            leading: Icon(Icons.settings),
                            title: Text('Settings'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'profile',
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Profile'),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'logout',
                          child: ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildCategorySelector(primaryColor, cardColor),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: filteredProducts.length,
                              // itemCount: 11,
                              itemBuilder: (context, index) {
                                final product = filteredProducts[index];
                                // kalau udah masuk ke BLOC, return widget ProductCard
                                return GestureDetector(
                                  onTap: () => _addToCart(product),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: cardColor,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: primaryColor.withOpacity(0.2)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 6,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: primaryColor.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: ClipOval(
                                              child: Image.asset(
                                                product.imageUrl,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Coffee',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: 320,
                    padding: const EdgeInsets.all(16),
                    color: cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            OrderField(controller: customerNameController, labelText: 'Customer Name'),
                            OrderField(labelText: 'Table Number', controller: tableNumberController,),
                          ],
                        ),

                        const SizedBox(height: 16),
                        const Text('Order List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView(
                            children: cart.entries.map((entry) {
                              final product = entry.key;
                              final qty = entry.value;
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        product.imageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(product.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                          Text('\$${product.price.toStringAsFixed(2)}', style: TextStyle(color: secondaryTextColor)),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                                          onPressed: () => _changeQuantity(product, -1),
                                        ),
                                        Text('$qty', style: const TextStyle(color: Colors.white)),
                                        IconButton(
                                          icon: Icon(Icons.add_circle_outline, color: primaryColor),
                                          onPressed: () => _changeQuantity(product, 1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Total: \$${total.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: cart.isEmpty
                              ? null
                              : () {
                            final customerName = customerNameController.text.trim();
                            final table = tableNumberController.text.trim();

                            if (customerName.isEmpty || table.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill customer name and table'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OrderConfirmationPage(
                                  cart: Map<Product, int>.from(cart),
                                  total: total,
                                  customerName: customerName,
                                  table: table,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            minimumSize: const Size.fromHeight(48),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                          child: const Text('Place Order'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget buildCategorySelector(Color primaryColor, Color cardColor) {
    final categories = ['Drink', 'Snack', 'Food'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories.map((category) {
          final isSelected = category == selectedCategory;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

