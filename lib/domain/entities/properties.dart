import 'package:wheelmap/common/utils/log.dart';
import 'package:wheelmap/domain/entities/accessibility.dart';
import 'package:wheelmap/domain/entities/address.dart';

import 'package:wheelmap/domain/entities/description.dart';
import 'package:wheelmap/domain/entities/enum_values.dart';
import 'package:wheelmap/domain/entities/name.dart';

class Properties {
  // String sourceId;
  SourceId sourceId;
  String originalId;
  String? infoPageUrl;
  String category;

  String? nameString;
  Name? name;
  String? addressString;
  Address? address;
  String? descriptionString;
  Description? description;
  String? phoneNumber;
  String? placeWebsiteUrl;
  String? emailAddress;
  Accessibility accessibility;
  SourceImportId sourceImportId;
  String id;
  Ids? ids;
  double distance;

  Properties({
    required this.sourceId,
    required this.originalId,
    this.infoPageUrl,
    required this.category,
    this.name,
    this.nameString,
    this.address,
    this.addressString,
    this.description,
    this.descriptionString,
    this.phoneNumber,
    this.emailAddress,
    this.placeWebsiteUrl,
    required this.accessibility,
    required this.sourceImportId,
    required this.id,
    this.ids,
    required this.distance,
  });

  factory Properties.fromJson(Map<String, dynamic> json) {
    try {
      bool hasWaypointNameString = json["name"] is String;
      bool hasNameString = json["name"] is String;
      bool hasDescriptionString = json["description"] is String;
      bool hasAddressString = json["address"] is String;
      String originalID = json["originalId"];

      // if(originalID == "BF5719"){
      //   print("hello I am here:");
      // }

      return Properties(
        //sourceId: sourceIdValues.map[json["sourceId"]]!,
        sourceId: sourceIdValues.map[json["sourceId"]] ?? SourceId.DEFAULT,
        originalId: json["originalId"],
        infoPageUrl: json["infoPageUrl"],
        category: json["category"],
        name: hasNameString
            ? null
            : json["name"] == null
                ? null
                : Name.fromJson(json["name"]),
        nameString: hasNameString ? json["name"] : null,
        address: hasAddressString
            ? null
            : json["address"] == null
                ? null
                : Address.fromJson(json["address"]),
        addressString: hasAddressString ? json["address"] : null,
        description: hasDescriptionString
            ? null
            : json["description"] == null
                ? null
                : Description.fromJson(json["description"]),
        descriptionString: hasDescriptionString ? json["description"] : null,
        phoneNumber: json["phoneNumber"],
        emailAddress: json["emailAddress"],
        placeWebsiteUrl: json["placeWebsiteUrl"],
        //sourceImportId: sourceImportIdValues.map[json["sourceImportId"]]!,
        sourceImportId: sourceImportIdValues.map[json["sourceImportId"]] ??
            SourceImportId.DEFAULT,
        id: json["_id"],
        distance: json["distance"]?.toDouble(),
        accessibility: Accessibility.fromJson(json["accessibility"]),
        ids: json["ids"] == null ? null : Ids.fromJson(json["ids"]),
      );
    } catch (e) {
      log.e(e);
      rethrow;
    }
  }
}

class Ids {
  String ebhf;
  String epa;
  String eva;
  String ibnr;
  String ifopt;
  String plc;
  String rl100;
  String stada;
  String uic;

  Ids({
    required this.ebhf,
    required this.epa,
    required this.eva,
    required this.ibnr,
    required this.ifopt,
    required this.plc,
    required this.rl100,
    required this.stada,
    required this.uic,
  });

  factory Ids.fromJson(Map<String, dynamic> json) => Ids(
        ebhf: json["ebhf"],
        epa: json["epa"],
        eva: json["eva"],
        ibnr: json["ibnr"],
        ifopt: json["ifopt"],
        plc: json["plc"],
        rl100: json["rl100"],
        stada: json["stada"],
        uic: json["uic"],
      );
}

enum SourceId {
  LI_BTS67_TJM_BC_XD_EM_X,
  RSAN_CCQLE8_YQ26_CZ6,
  THE_5_N_YM_GT_WYWW_YASKSQ_Q,
  ZY_DA_F8_ZR_JE_GL3_M4_CQ,
  Z_FPOQET_HJG_GBMY_HN_R,
  Q9_JZ_J_MXYDEG_Z_YF_FB_K,
  DEFAULT
}

final sourceIdValues = EnumValues({
  "LiBTS67TjmBcXdEmX": SourceId.LI_BTS67_TJM_BC_XD_EM_X,
  "Q9jzJMxydegZYfFbK": SourceId.Q9_JZ_J_MXYDEG_Z_YF_FB_K,
  "rsanCCQLE8yq26CZ6": SourceId.RSAN_CCQLE8_YQ26_CZ6,
  "5nYmGtWywwYasksqQ": SourceId.THE_5_N_YM_GT_WYWW_YASKSQ_Q,
  "ZyDaF8ZrJeGL3m4Cq": SourceId.ZY_DA_F8_ZR_JE_GL3_M4_CQ,
  "zFpoqetHjgGbmyHnR": SourceId.Z_FPOQET_HJG_GBMY_HN_R,
  "default_value": SourceId.DEFAULT,
});

//enum SourceImportId { X_YU_FNP5_TP4_DJ_HB_R_CW, Y_N6_S9_YGZ_QZSN_M_JU6_F, RP34_LWEK8_FHTMKUQF, Q_WJ_X_ER_ZR4_Z_XIS_CZCB, J6_Z_FSR_ZL8_PKKAGB_DX, F_CCOZ2_BN3_YFT_LN_QSP, D4_Z_ST_ED_JW_A_EO_SRDN_D, I_GC_XFNC4_D_L_LCB3_OI7, THE_2_S6_S8_B_KT_A4_JD_KGQO_H, CE_CWF_MMCP3_F_RE4_B72, ID_D9_S_CCP6_YO_BR_JJ_HS, AXD6_KEEJ5_C_ZGN25_Z9, O_K_MBFE_L_XH4_Q_Q_WK_MA_G, H_XH_JO_Z_JYY_F_ZI_SF_FB_Q, NI_RJK_KFIX5_CR_C_WQ7_Q, CP_FI_QL_JX_C8_SKWP_L98, GK_S_KG_YC9_J_YHI_J_WW_QX, NFV8_QW_J2_JN_W_HH_CF4_U, ZMBQ_C2_KXAW_BNR_GS_WJ, MU_Z3_WV_YOC_M6_QD3_MKP, Y_KXZFV_W_YJ_G_AW9_DT_RM, QFAS_EFGVDK_JQHRTD2, PM_Z4_GKNN_TPQINZZ_FM, PJ4_P9_R_XOSOBHW_M8_KK, DPHGGTJ_TEFZH_G_BK_MM, S_XC_K_DV_BM4_P_PH7_J_H_KA, X_YT_EHWV_PRN3_N_F_JJR_D, F_ESENNU_N_ZU_CBN_WRYS, THE_7_LB_PUT78_S_GTB2_M_Y7_Z }
enum SourceImportId {
  DEFAULT,
  X_YU_FNP5_TP4_DJ_HB_R_CW,
  Y_N6_S9_YGZ_QZSN_M_JU6_F,
  RP34_LWEK8_FHTMKUQF,
  Q_WJ_X_ER_ZR4_Z_XIS_CZCB,
  J6_Z_FSR_ZL8_PKKAGB_DX,
  F_CCOZ2_BN3_YFT_LN_QSP,
  D4_Z_ST_ED_JW_A_EO_SRDN_D,
  I_GC_XFNC4_D_L_LCB3_OI7,
  THE_2_S6_S8_B_KT_A4_JD_KGQO_H,
  CE_CWF_MMCP3_F_RE4_B72,
  ID_D9_S_CCP6_YO_BR_JJ_HS,
  AXD6_KEEJ5_C_ZGN25_Z9,
  O_K_MBFE_L_XH4_Q_Q_WK_MA_G,
  H_XH_JO_Z_JYY_F_ZI_SF_FB_Q,
  NI_RJK_KFIX5_CR_C_WQ7_Q,
  CP_FI_QL_JX_C8_SKWP_L98,
  GK_S_KG_YC9_J_YHI_J_WW_QX,
  NFV8_QW_J2_JN_W_HH_CF4_U,
  ZMBQ_C2_KXAW_BNR_GS_WJ,
  MU_Z3_WV_YOC_M6_QD3_MKP,
  Y_KXZFV_W_YJ_G_AW9_DT_RM,
  QFAS_EFGVDK_JQHRTD2,
  PM_Z4_GKNN_TPQINZZ_FM,
  PJ4_P9_R_XOSOBHW_M8_KK,
  DPHGGTJ_TEFZH_G_BK_MM,
  S_XC_K_DV_BM4_P_PH7_J_H_KA,
  X_YT_EHWV_PRN3_N_F_JJR_D,
  F_ESENNU_N_ZU_CBN_WRYS,
  THE_7_LB_PUT78_S_GTB2_M_Y7_Z,
  THE_97E3_UCHF_RHWN_MY9ZW,
  THE_8GT2_WMJ7_DYR9_YVO3X
}

final sourceImportIdValues = EnumValues({
  "axd6keej5cZGN25z9": SourceImportId.AXD6_KEEJ5_C_ZGN25_Z9,
  "CECwfMMCP3FRe4B72": SourceImportId.CE_CWF_MMCP3_F_RE4_B72,
  "CPFiQLJxC8skwpL98": SourceImportId.CP_FI_QL_JX_C8_SKWP_L98,
  "d4ZStEDJwAEoSrdnD": SourceImportId.D4_Z_ST_ED_JW_A_EO_SRDN_D,
  "DphggtjTefzhGBkMm": SourceImportId.DPHGGTJ_TEFZH_G_BK_MM,
  "fCcoz2Bn3YftLnQSP": SourceImportId.F_CCOZ2_BN3_YFT_LN_QSP,
  "fEsennuNZuCBNWrys": SourceImportId.F_ESENNU_N_ZU_CBN_WRYS,
  "gkSKgYc9jYhiJWwQX": SourceImportId.GK_S_KG_YC9_J_YHI_J_WW_QX,
  "HXhJoZJyyFZiSfFbQ": SourceImportId.H_XH_JO_Z_JYY_F_ZI_SF_FB_Q,
  "idD9sCCP6yoBrJjHs": SourceImportId.ID_D9_S_CCP6_YO_BR_JJ_HS,
  "iGCXfnc4dLLcb3oi7": SourceImportId.I_GC_XFNC4_D_L_LCB3_OI7,
  "j6ZFsrZL8pkkagbDx": SourceImportId.J6_Z_FSR_ZL8_PKKAGB_DX,
  "muZ3wvYocM6Qd3mkp": SourceImportId.MU_Z3_WV_YOC_M6_QD3_MKP,
  "Nfv8qwJ2JnWHhCF4u": SourceImportId.NFV8_QW_J2_JN_W_HH_CF4_U,
  "niRjkKfix5crCWq7Q": SourceImportId.NI_RJK_KFIX5_CR_C_WQ7_Q,
  "oKMbfeLXh4qQWkMaG": SourceImportId.O_K_MBFE_L_XH4_Q_Q_WK_MA_G,
  "pj4P9RXosobhwM8kk": SourceImportId.PJ4_P9_R_XOSOBHW_M8_KK,
  "PmZ4gknnTpqinzzFm": SourceImportId.PM_Z4_GKNN_TPQINZZ_FM,
  "qfasEfgvdkJQHRTD2": SourceImportId.QFAS_EFGVDK_JQHRTD2,
  "QWjXErZR4ZXisCzcb": SourceImportId.Q_WJ_X_ER_ZR4_Z_XIS_CZCB,
  "rp34Lwek8Fhtmkuqf": SourceImportId.RP34_LWEK8_FHTMKUQF,
  "sXcKDvBM4PPh7jHKa": SourceImportId.S_XC_K_DV_BM4_P_PH7_J_H_KA,
  "2S6S8bKtA4jdKgqoH": SourceImportId.THE_2_S6_S8_B_KT_A4_JD_KGQO_H,
  "7LbPut78sGTB2mY7z": SourceImportId.THE_7_LB_PUT78_S_GTB2_M_Y7_Z,
  "xYtEhwvPrn3nFJjrD": SourceImportId.X_YT_EHWV_PRN3_N_F_JJR_D,
  "XYuFNP5Tp4djHbRCw": SourceImportId.X_YU_FNP5_TP4_DJ_HB_R_CW,
  "yKxzfvWYjGAw9DTRm": SourceImportId.Y_KXZFV_W_YJ_G_AW9_DT_RM,
  "yN6s9ygzQzsnMJu6f": SourceImportId.Y_N6_S9_YGZ_QZSN_M_JU6_F,
  "ZmbqC2KxawBnrGsWJ": SourceImportId.ZMBQ_C2_KXAW_BNR_GS_WJ,
  "97E3uCHFRHwnmy9Zw": SourceImportId.THE_97E3_UCHF_RHWN_MY9ZW,
  "8gT2WmJ7DyR9yvo3X": SourceImportId.THE_8GT2_WMJ7_DYR9_YVO3X,
  "default_value": SourceImportId.DEFAULT,
});
