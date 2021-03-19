import 'package:eatnaija/common/Utils.dart';
import 'package:eatnaija/common/custom_loader_indicator.dart';
import 'package:eatnaija/common/resources.dart';
import 'package:eatnaija/presentation/screens/food_order_detail/another_food_detail.dart';
import 'package:eatnaija/presentation/screens/order_history/bloc/food_order_bloc.dart';
import 'package:eatnaija/presentation/screens/order_history/new_food_order/bloc/new_food_order_bloc.dart';
import 'package:eatnaija/presentation/screens/order_history/repository/food_order_repository.dart';
import 'package:eatnaija/presentation/screens/order_history/model/order_history_response.dart';
import 'package:eatnaija/presentation/screens/order_history/repository/uploaded_food_repository.dart';

import 'package:flutter/cupertino.dart';
import 'package:date_format/date_format.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewFoodOrderPage extends StatefulWidget {
  @override
  _NewFoodOrderPageState createState() => _NewFoodOrderPageState();
}

class _NewFoodOrderPageState extends State<NewFoodOrderPage>
    with AutomaticKeepAliveClientMixin {
  final allFoodRepository = FoodOrdersRepository();

  final updateFoodRepository = AllFoodRepository();
  FoodOrdersRepository foodOrderRepository;

  CustomLoader _loader;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    foodOrderRepository = FoodOrdersRepository();
    _loader = CustomLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocProvider(
         create: (context) => FoodOrderBloc(),
            child: Container(
                height: MediaQuery.of(context).size.height - 100.0,
                width: MediaQuery.of(context).size.width,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Expanded(
                      flex: 8,
                      child: BlocListener<FoodOrderBloc, FoodOrderState>(
                            listener: (context, state) {

                              if(state is FoodOrderFailureState){
                                _loader.hideLoader();
                                Fluttertoast.showToast(
                                    msg: state.error,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                        child: BlocBuilder<FoodOrderBloc, FoodOrderState>(
                          // ignore: missing_return
                            builder: (context, state) {
                              if (state is FoodOrderLoadingState) {
                                print(
                                    "------------------------------------------------------------------------Loading all foods");

                                var _loginBloc =
                                BlocProvider.of<FoodOrderBloc>(context)
                                    .add(FetchAllFoodRequestsEvent());

                                return Commons.loadingWidget("Loading Food Orders");
                              }

                              if (state is FoodOrderSuccessState) {
                                final List<Orderhistory> foodRequests = state.orderHistory;

                                List<Orderhistory> newRequests = foodRequests
                                    .where((i) =>
                                i.accept == "0" &&
                                    i.delivered == "0" &&
                                    i.reject == "0")
                                    .toList();

                                return RefreshIndicator(
                                  key: _refreshIndicatorKey,
                                  onRefresh: () async {
                                    if (state is! FoodOrderLoadingState)
                                      BlocProvider.of<FoodOrderBloc>(context)
                                          .add(ReFetchAllFoodRequestsEvent());
                                  },
                                  child: newRequests.isEmpty
                                      ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svgs/serving-dish.svg",
                                          height: 110.0,
                                          width: 90.0,
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        Text(
                                          "No Food Order yet",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color: Resources.PRIMARY_COLOR),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                      ],
                                    ),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: ListView.builder(
                                      itemCount: newRequests.length,
                                      itemBuilder: (context, index) {
                                        return _myStoreItem(
                                            newRequests[index], context);
                                      },
                                    ),
                                  ),
                                );
                              }
                              if (state is FoodOrderFailureState) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svgs/failure.svg",
                                          height: 110.0,
                                          width: 90.0,
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        Text(
                                          "Failed to Load All Orders",
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color: Resources.PRIMARY_COLOR),
                                        ),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        RaisedButton(
                                            color: Resources.PRIMARY_COLOR,
                                            child: Text(
                                              "Try again",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0),
                                            ),
                                            onPressed: () {
                                              if (state is FoodOrderFailureState) {
                                                BlocProvider.of<FoodOrderBloc>(
                                                    context)
                                                    .add(FetchAllFoodRequestsEvent());
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }),

                      ),

                      ),
                ]))));
  }

  Widget _myStoreItem(Orderhistory foodRequests, BuildContext context) {
    final formattedStr = formatDate(DateTime.parse(foodRequests.createdAt),
        [dd, '.', mm, '.', yy, ' ', HH, ':', nn]);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                AnotherFoodDetail(foodRequests: foodRequests)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Card(
            color: Colors.white,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("New Order"),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Resources.PRIMARY_COLOR),
                      ),
                      Text(formattedStr),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "${foodRequests.product} (${foodRequests.quantity})",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "₦${foodRequests.price}",
                    style: TextStyle(color: Colors.grey.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
