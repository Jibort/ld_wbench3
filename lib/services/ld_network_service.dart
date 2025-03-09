// Servei de coumunicacion segures de l'aplicació.
// CreatedAt: 2025/02/14 dv. GPT[JIQ]

import 'package:ld_wbench3/core/ld_service.dart';

class LdNetworkService extends LdService {
  // 📝 ESTÀTICS -----------------------
  static LdNetworkService single = LdNetworkService();
  static const className = "LdNetworkService";

  // VARIABLES ------------------------
  // late final LdNetworkService _network;

  // 🛠️ CONSTRUCTORS ---------------------
  LdNetworkService() : super(pTag: className);

  Future<LdNetworkService> init() async {
    return this;
  }
}
