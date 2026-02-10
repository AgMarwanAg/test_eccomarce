import '../../core/logging/logger.dart';

enum Gender { male, female }

extension GenderEx on Gender {
  static Gender fromString(String? value) {
    switch (value) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.male;
    }
  }
}

enum CountryEnum { yemen, saudiArabia }

enum OtpContext { phoneLogin, phoneRegister }

enum AdType {
  product(1),
  category(2),
  external(3);

  final int value;
  const AdType(this.value);

  static AdType fromValue(int value) {
    return AdType.values.firstWhere(
      (type) => type.value == value,
      orElse: () {
        Logger.error('Unknown AdType value: $value');
        return AdType.product;
      },
    );
  }
}

enum DeliveryType {
  now(1),
  schedule(2);

  final int value;
  const DeliveryType(this.value);
  static DeliveryType fromString(String? value) {
    switch (value) {
      case 'now':
        return DeliveryType.now;
      case 'schedule':
        return DeliveryType.schedule;
      default:
        return DeliveryType.now;
    }
  }
}

enum AddressType {
  home(1),
  work(2);

  final int value;
  const AddressType(this.value);

  static AddressType fromValue(int value) {
    return AddressType.values.firstWhere(
      (type) => type.value == value,
      orElse: () {
        Logger.error('Unknown AddressType value: $value');
        return AddressType.home;
      },
    );
  }
}

enum OtpType {
  register(1),
  login(2),
  update(3);

  final int value;
  const OtpType(this.value);
}

enum OrderStatus {
  pending(1),
  processing(2),
  delivering(3),
  finished(4),
  //status 5 only needed for dashboard,
  // closed(5),
  cancelled(6);

  final int value;
  const OrderStatus(this.value);

  static OrderStatus fromValue(int value) {
    switch (value) {
      case 1:
        return OrderStatus.pending;
      case 2:
        return OrderStatus.processing;
      case 3:
        return OrderStatus.delivering;
      case 4:
        return OrderStatus.finished;
      case 5:
        // status 5 only needed for dashboard,
        // so it must be trait as finished
        return OrderStatus.finished;
      case 6:
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }

  bool get isCancelled => this == OrderStatus.cancelled;
  bool get isFinished => this == OrderStatus.finished;
  bool get isRecent =>
      this == OrderStatus.pending ||
      this == OrderStatus.processing ||
      this == OrderStatus.delivering;
  bool get isNotRecent =>
      this == OrderStatus.cancelled ||
      this == OrderStatus.finished;
}

enum NotificationEnum {
  general(1),
  order(3),
  security(2),
  ticket(4);

  final int value;
  const NotificationEnum(this.value);

  static NotificationEnum fromValue(int value) {
    return NotificationEnum.values.firstWhere(
      (type) => type.value == value,
      orElse: () {
        Logger.error('Unknown NotificationEnum value: $value');
        return NotificationEnum.general;
      },
    );
  }
}

enum PaymentMethod {
  payNow,
  payOnDelivery;
  bool get isPayNow=>this==PaymentMethod.payNow;
  static PaymentMethod fromString(String value) {
    switch (value) {
      case 'pay-now':
        return PaymentMethod.payNow;
      case 'pay-on-delivery':
        return PaymentMethod.payOnDelivery;
      default:
        Logger.error('Unknown PaymentMethod value: $value');
        return PaymentMethod.payNow;
    }
  }
}
