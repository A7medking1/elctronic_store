import 'package:ecommerce_app/src/core/app_constant.dart';
import 'package:ecommerce_app/src/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/default_button.dart';
import 'checkout_controller.dart';

class CheckOutScreen extends GetView<CheckOutController> {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<CheckOutController>(CheckOutController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: const CustomAppBarWidget(
          isCartScreen: true,
          title: 'CheckOut',
          leadingBack: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          15.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10,
                    start: 10,
                    end: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Address :',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              'change address',
                              style: TextStyle(
                                fontSize: 20,
                                color: AppConstant().kPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Obx(
                          () => Text(
                            controller.address.value,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              elevation: 5,
              child: SizedBox(
                width: double.infinity,
                height: 260,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 10,
                    start: 10,
                    end: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment method',
                            style: TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppConstant().kPrimaryColor,
                                ),
                                Text(
                                  'Add card',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppConstant().kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PaymentCard(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Cash on delivery"),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(
                                  side: BorderSide(color: Colors.orange),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PaymentCard(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 40,
                                    child: SvgPicture.asset(
                                        'assets/icons/visa.svg')),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("**** **** **** 2187"),
                              ],
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(
                                  side: BorderSide(color: Colors.orange),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PaymentCard(
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 40,
                                    child: SvgPicture.asset(
                                        'assets/icons/paypal.svg')),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("**** **** **** 2187"),
                              ],
                            ),
                            Container(
                              width: 15,
                              height: 15,
                              decoration: const ShapeDecoration(
                                shape: CircleBorder(
                                  side: BorderSide(color: Colors.orange),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 10,
                  start: 10,
                  end: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sub Total"),
                        Text(
                          "\$68",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delivery Cost"),
                        Text(
                          "\$2",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Discount"),
                        Text(
                          "-\$4",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                    const Divider(
                      height: 40,
                      color: Colors.grey,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total"),
                        Text(
                          "\$66",
                          style: Theme.of(context).textTheme.headline5,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DefaultButton(
              text: 'Check Out',
              press: () => Get.to(() => const CheckOutScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final Widget widget;

  const PaymentCard({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.25),
          ),
        ),
        color: const Color(0xFFF2F2F2),
      ),
      child: widget,
    );
  }
}
