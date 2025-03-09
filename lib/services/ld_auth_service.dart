// Servei d'autenticació segura d'usuaris de l'aplicació.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]

import 'package:ld_wbench3/core/ld_service.dart';

class LdAuthService extends LdService {
  // 📝 ESTÀTICS -----------------------
  static LdAuthService single = LdAuthService();
  static const className = "LdAuthService";

  // VARIABLES ------------------------
  // late final LdAuthService _auth;

  // 🛠️ CONSTRUCTORS ---------------------
  LdAuthService() : super(pTag: className);

  Future<LdAuthService> init() async {
    return this;
  }
}
