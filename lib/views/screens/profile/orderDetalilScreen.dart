import 'package:flutter/material.dart';
import 'package:mytopgrade/controllers/order%20controller/allOrderController.dart';
import 'package:mytopgrade/models/orderByIdModel.dart';

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
              child: ListView.builder(
                itemCount: orderByIdController.orderByIdList.value.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFffa110),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Status:'),
                              orderByIdController.orderByIdList.value[index]
                                          .dateCompleted
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Total:'),
                              orderByIdController
                                          .orderByIdList.value[index].total
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Date Paid:'),
                              orderByIdController.orderByIdList.value[index]
                                          .dateCompleted
                                          .toString() !=
                                      'null'
                                  ? Text(orderByIdController
                                      .orderByIdList.value[index].dateCompleted
                                      .toString())
                                  : Text('UnPaid'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
