import 'package:pos_application_mobile/domain/repositories/repository.dart';

abstract class UseCase<R extends Repository, Params> {
  final R repository;
  UseCase(this.repository);

  Future call([Params params]);
}

class ParamTuple<T1, T2> {
  final T1 item1;
  final T2 item2;

  ParamTuple(this.item1, this.item2);
}