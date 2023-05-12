import '../../models/payment_type.dart';

abstract class PaymentTypeRepository {
  Future<List<PaymentType>> findAll(bool? enable);
  Future<void> save(PaymentType model);
  Future<PaymentType> getById(int id);
}
