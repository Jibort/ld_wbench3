// Servei de base de dades segura de l'aplicació.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]

import 'package:ld_wbench3/core/ld_service.dart';

class LdDatabaseService extends LdService {
  // 📝 ESTÀTICS -----------------------
  static LdDatabaseService single = LdDatabaseService();
  static const className = "LdDatabaseService";

  // 🛠️ CONSTRUCTORS ---------------------
  LdDatabaseService() : super(pTag: className);

  Future<LdDatabaseService> init() async {
    return this;
  }
}
