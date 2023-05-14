import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/payment_type.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  inicial,
  loading,
  loaded,
  error,
  addOrUpdatePayment,
  saved
}

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  final PaymentTypeRepository _paymentTypeRepository;

  @readonly
  var _status = PaymentTypeStateStatus.inicial;

  @readonly
  var _paymentTypes = <PaymentType>[];

  @readonly
  String? _errorMessage;

  @readonly
  bool? filterEnabled;

  @readonly
  PaymentType? paymentTypeSelected;

  @action
  PaymentTypeControllerBase(this._paymentTypeRepository);

  void changeFilter(bool? enabled) => filterEnabled = enabled;
  @action
  Future<void> loadPayments() async {
    try {
      _status = PaymentTypeStateStatus.loading;
      _paymentTypes = await _paymentTypeRepository.findAll(filterEnabled);
      _status = PaymentTypeStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar as formas de pagamento', error: e, stackTrace: s);
      _status = PaymentTypeStateStatus.error;
      _errorMessage = 'Erro ao carregar as formas de pagamento';
    }
  }

  @action
  void addPayment() async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    paymentTypeSelected = null;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  Future<void> editPayment(PaymentType payment) async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    paymentTypeSelected = null;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  Future<void> savePayment({
    int? id,
    required String name,
    required String acronym,
    required bool enabled,
  }) async {
    _status = PaymentTypeStateStatus.loading;
    final model =
        PaymentType(id: id, name: name, acronym: acronym, enabled: enabled);
    await _paymentTypeRepository.save(model);
    _status = PaymentTypeStateStatus.saved;
  }
}
