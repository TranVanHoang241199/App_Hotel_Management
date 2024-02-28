enum UserRole { admin, customer, manager, accountant, hr, employee, warehouse }

class EnumHelp {
  static String getDisplayRoleText(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return "Adminsss";
      case UserRole.customer:
        return "Customer";
      case UserRole.manager:
        return "Manager";
      case UserRole.accountant:
        return "Accountant";
      case UserRole.hr:
        return "HR";
      case UserRole.employee:
        return "Employee";
      case UserRole.warehouse:
        return "Warehouse";
    }
  }
}

// Định nghĩa enum EStatusRoom
enum EStatusRoom {
  active,
  stop,
  end,
  maintenance,
}

// Thêm extension để chuyển đổi giá trị enum thành chuỗi (string)
extension EStatusRoomExtension on EStatusRoom {
  String get value {
    switch (this) {
      case EStatusRoom.active:
        return 'Active';
      case EStatusRoom.stop:
        return 'Stop';
      case EStatusRoom.end:
        return 'End';
      case EStatusRoom.maintenance:
        return 'Maintenance';
      default:
        return '';
    }
  }
}

enum EStatusService {
  active,
  end,
  maintenance,
}

// Thêm extension để chuyển đổi giá trị enum thành chuỗi (string)
extension EStatusServiceExtension on EStatusService {
  String get value {
    switch (this) {
      case EStatusRoom.active:
        return 'Active';
      case EStatusRoom.end:
        return 'End';
      case EStatusRoom.maintenance:
        return 'Maintenance';
      default:
        return '';
    }
  }
}
