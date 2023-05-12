import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repsitory_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/payment_type.dart';
import 'payment_type_repository.dart';

class PaymentTypeRepositoryImpl extends PaymentTypeRepository {
  final CustomDio _dio;

  PaymentTypeRepositoryImpl(this._dio);

  @override
  Future<List<PaymentType>> findAll(bool? enable) async {
    try {
      final paymentType = await _dio.auth().get(
        '/payment-type',
        queryParameters: {if (enable != null) 'enable': enable},
      );
      return paymentType.data
          .map<PaymentType>((map) => PaymentType.fromMap(map));
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamentos', error: e, stackTrace: s);
      throw RepsitoryException(message: 'Erro ao buscar formas de pagamento');
    }
  }

  @override
  Future<PaymentType> getById(int id) async {
    try {
      final paymentType = await _dio.auth().get(
            '/payment-type/$id',
          );
      return PaymentType.fromMap(paymentType.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar forma de pagamentos', error: e, stackTrace: s);
      throw RepsitoryException(
        message: 'Erro ao buscar forma de pagamento $id',
      );
    }
  }

  @override
  Future<void> save(PaymentType model) async {
    try {
      final client = _dio.auth();

      if (model.id != null) {
        await client.put(
          '/payment-type/${model.id}',
          data: model.toMap(),
        );
      } else {
        await client.post(
          '/payment-type',
          data: model.toMap(),
        );
      }
    } on DioError catch (e, s) {
      log('Erro ao salvar forma de pagamentos', error: e, stackTrace: s);
      throw RepsitoryException(message: 'Erro ao salvar forma de pagamento');
    }
  }
}
