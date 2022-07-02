import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mytopgrade/controllers/order%20controller/allOrderController.dart';
import 'package:mytopgrade/models/orderByIdModel.dart';
import 'package:mytopgrade/utils/color_manager.dart';

class OrderList extends StatefulWidget {
  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final OrderByIdController orderByIdController = OrderByIdController();
  OrderByIdModel orderByIdModel = OrderByIdModel();

  @override
  void initState() {
    getAllOrders();
    super.initState();
  }

  void getAllOrders() async {
    await orderByIdController.allOrderByCustomer();
    Future.delayed(Duration(seconds: 3)).then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return orderByIdController.isLoading.value == false
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: orderByIdController.orderByIdList.value.length > 0
                  ? ListView.builder(
                      itemCount: orderByIdController.orderByIdList.value.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: ColorManager.primaryColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Order Id:'),
                                    Text(orderByIdController
                                        .orderByIdList.value[index].id
                                        .toString()),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Order Date:'),
                                    Text(orderByIdController
                                        .orderByIdList.value[index].dateCreated
                                        .toString()),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Status:'),
                                    orderByIdController.orderByIdList
                                                .value[index].dateCompleted
                                                .toString() !=
                                            'null'
                                        ? Text('Completed')
                                        : Text('On-Hold'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Order Total:'),
                                    orderByIdController.orderByIdList
                                                .value[index].total
                                                .toString() !=
                                            null
                                        ? Text(orderByIdController
                                            .orderByIdList.value[index].total
                                            .toString())
                                        : Text('Free'),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Date Paid:'),
                                    orderByIdController.orderByIdList
                                                .value[index].dateCompleted
                                                .toString() !=
                                            'null'
                                        ? Text(orderByIdController.orderByIdList
                                            .value[index].dateCompleted
                                            .toString())
                                        : Text('UnPaid'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Orders',
                        style: TextStyle(
                          color: ColorManager.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
          )
        : Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 50,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Connecting to the Server..',
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      speed: const Duration(milliseconds: 180),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
