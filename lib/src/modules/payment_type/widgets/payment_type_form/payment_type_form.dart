import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type.dart';
import '../../payment_type_controller.dart';

class PaymentTypeForm extends StatefulWidget {
  final PaymentTypeController controller;
  final PaymentType? model;

  const PaymentTypeForm({
    super.key,
    this.model,
    required this.controller,
  });

  @override
  State<PaymentTypeForm> createState() => _PaymentTypeFormState();
}

class _PaymentTypeFormState extends State<PaymentTypeForm> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController();
  final acronymEC = TextEditingController();
  var enabled = false;

  void _closeModel() => Navigator.of(context).pop();

  @override
  void dispose() {
    nameEC.dispose();
    acronymEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final paymentType = widget.model;
    if (paymentType != null) {
      nameEC.text = paymentType.name;
      acronymEC.text = paymentType.acronym;
      enabled = paymentType.enabled;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * (screenWidth > 1200 ? .5 : .7),
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.model == null ? 'Adicionar ' : 'Editar'} forma de pagamento',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: _closeModel,
                      child: const Icon(Icons.close),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: Validatorless.required('Nome obrigatório'),
                controller: nameEC,
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: Validatorless.required('Sigla obrigatória'),
                controller: acronymEC,
                decoration: const InputDecoration(
                  label: Text('Sigla'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Átivo',
                    style: context.textStyles.textRegular,
                  ),
                  Switch(
                    value: enabled,
                    onChanged: (value) {
                      setState(() {
                        enabled = value;
                      });
                    },
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton(
                      onPressed: () {
                        _closeModel();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: context.textStyles.textExtraBold
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final valid = formKey.currentState?.validate() ?? false;

                        if (valid) {
                          final name = nameEC.text;
                          final acronym = acronymEC.text;
                          widget.controller.savePayment(
                            id: widget.model?.id,
                            name: name,
                            acronym: acronym,
                            enabled: enabled,
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
