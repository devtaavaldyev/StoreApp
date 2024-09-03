import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/future/data/repository/store_repository.dart';
import 'package:taskproject/future/presentation/provider/store_provider.dart';
import 'package:taskproject/core/cache/cache_image.dart';
import 'package:taskproject/future/presentation/screens/detail_screen.dart';
import 'package:taskproject/future/presentation/screens/form_screen.dart';
import 'package:taskproject/future/presentation/widgets/my_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StoreProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('StoreApp'),
        centerTitle: true,
        actions: [
          FloatingActionButton.small(
              heroTag: "btn2",
              backgroundColor: Colors.tealAccent,
              child: const Icon(Icons.get_app),
              onPressed: () {
                vm.getProducts();
              }),
          const SizedBox(width: 8),
          FloatingActionButton.small(
              heroTag: "btn1",
              backgroundColor: Colors.amber,
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateFormScreen(),
                  ),
                );
              }),
          const SizedBox(width: 8),
          // CasheImageWidget(url: 'https://fakestoreapi.com/products')
        ],
      ),
      body:
       NotificationListener(
        onNotification: (ScrollNotification notification) {
          final max = notification.metrics.maxScrollExtent;
          final current = notification.metrics.pixels + 100;
          if (current >= max) {
            vm.getProducts();
          }
          return true;
        },
        child: ListView(
          children: [
            if (vm.isLoading && vm.allProducts.isEmpty)
              const Center(child: CircularProgressIndicator()),
            if (vm.allProducts.isEmpty &&
                vm.errorMessage.isEmpty &&
                !vm.isLoading)
              const Text(
                'Список пуст. Загрузите данные!',
                textAlign: TextAlign.center,
              ),
            if (vm.errorMessage.isEmpty &&
                vm.allProducts.isNotEmpty &&
                !vm.isLoading)
              ...vm.allProducts.map(
                (e) => Dismissible(
                  onDismissed: (direction) {
                    vm.deleteProduct(product: e);
                  },
                  key: ValueKey(e),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(detailModel: e),
                        ),
                      );
                    },
                    child: MyList(
                        category: e.category ?? '',
                        id: e.id ?? 1,
                        title: e.title ?? '',
                        image: e.image ?? ''),
                  ),
                ),
              ),
            if (vm.errorMessage.isNotEmpty && !vm.isLoading)
              Text(
                vm.errorMessage,
                textAlign: TextAlign.center,
              )
          ],
        ),
      ),
    );
  }
}
