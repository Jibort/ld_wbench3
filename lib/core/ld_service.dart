// Classe embolcall per a tots els serveis de l'aplicació.
// CreatedAt: 2025/02/12 dc. JIQ

import 'package:ld_wbench3/core/ld_id_mixin.dart';
import 'package:get/get.dart';

abstract class LdService extends GetxService with LdIdMixin {
  // 📝 ESTÀTICS -----------------------
  static const className = "LdService";

  // 🛠️ CONSTRUCTORS -------------------
  LdService({String? pTag}) {
    tag = pTag ?? "${className}_$id";
    typeName = className;
    Get.put(this, tag: tag, permanent: true);
  }

  // 🔄 CICLE DE VIDA ------------------
  // Quan el servei ha estat inicialitzat

  // Quan el servei està completament carregat

  // Quan el servei s'està destruint
}
