import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import 'payment_type_controller.dart';
import 'widgets/payment_type_form/payment_type_form.dart';
import 'widgets/payment_type_header.dart';
import 'widgets/payment_type_item.dart';

class PaymentTypePage extends StatefulWidget {
  const PaymentTypePage({Key? key}) : super(key: key);

  @override
  State<PaymentTypePage> createState() => _PaymentTypePageState();
}

class _PaymentTypePageState extends State<PaymentTypePage>
    with Loader, Messages {
  final controller = Modular.get<PaymentTypeController>();

  final disposers = <ReactionDisposer>[];

  void showAddorUpdatePayment() {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 10,
            child: PaymentTypeForm(
              controller: controller,
              model: controller.paymentTypeSelected,
            ),
          ),

          // Dialog
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final filterDiposer = reaction((_) => controller.filterEnabled, (_) {
        controller.loadPayments();
      });

      final statusDisposer = reaction((_) => controller.status, (status) {
        switch (status) {
          case PaymentTypeStateStatus.inicial:
            break;
          case PaymentTypeStateStatus.loading:
            showLoader();
            break;
          case PaymentTypeStateStatus.loaded:
            hideLoader();
            break;
          case PaymentTypeStateStatus.error:
            hideLoader();
            showError(
              controller.errorMessage ?? 'Erro ao buscar formas de pagamentos',
            );
            break;
          case PaymentTypeStateStatus.addOrUpdatePayment:
            hideLoader();
            showAddorUpdatePayment();
            break;
          case PaymentTypeStateStatus.saved:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            controller.loadPayments();
            break;
        }
      });
      disposers.addAll([statusDisposer, filterDiposer]);
      controller.loadPayments();
    });
  }

  @override
  void dispose() {
    for (final dispose in disposers) {
      dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.only(left: 40, top: 40, right: 40),
      child: Column(
        children: [
          PaymentTypeHeader(controller: controller),
          const SizedBox(
            height: 50,
          ),
          Expanded(child: Observer(
            builder: (context) {
              return GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 680,
                  mainAxisExtent: 120,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final paymentType = controller.paymentTypes[index];
                  return PaymentTypeItem(
                    payment: paymentType,
                    controller: controller,
                  );
                },
              );
            },
          )),
        ],
      ),
    );
  }
}
