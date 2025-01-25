class CheckDeliveryAvailabilityModel {
  bool? companyAutoShipmentInsuranceSetting;
  CovidZones? covidZones;
  String? currency;
  Data? data;
  int? dgCourier;
  int? eligibleForInsurance;
  bool? insuraceOptedAtOrderCreation;
  bool? isAllowTemplatizedPricing;
  int? isLatlong;
  bool? isOldZoneOpted;
  bool? isZoneFromMongo;
  int? labelGenerateType;
  int? onNewZone;
  //List<Null>? sellerAddress;
  int? status;
  bool? userInsuranceManadatory;

  CheckDeliveryAvailabilityModel(
      {this.companyAutoShipmentInsuranceSetting,
      this.covidZones,
      this.currency,
      this.data,
      this.dgCourier,
      this.eligibleForInsurance,
      this.insuraceOptedAtOrderCreation,
      this.isAllowTemplatizedPricing,
      this.isLatlong,
      this.isOldZoneOpted,
      this.isZoneFromMongo,
      this.labelGenerateType,
      this.onNewZone,
      // this.sellerAddress,
      this.status,
      this.userInsuranceManadatory});

  CheckDeliveryAvailabilityModel.fromJson(Map<String, dynamic> json) {
    companyAutoShipmentInsuranceSetting =
        json['company_auto_shipment_insurance_setting'];
    covidZones = json['covid_zones'] != null
        ? CovidZones.fromJson(json['covid_zones'])
        : null;
    currency = json['currency'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    dgCourier = json['dg_courier'];
    eligibleForInsurance = json['eligible_for_insurance'];
    insuraceOptedAtOrderCreation = json['insurace_opted_at_order_creation'];
    isAllowTemplatizedPricing = json['is_allow_templatized_pricing'];
    isLatlong = json['is_latlong'];
    isOldZoneOpted = json['is_old_zone_opted'];
    isZoneFromMongo = json['is_zone_from_mongo'];
    labelGenerateType = json['label_generate_type'];
    onNewZone = json['on_new_zone'];
    // if (json['seller_address'] != null) {
    //   sellerAddress = <Null>[];
    //   json['seller_address'].forEach((v) {
    //     sellerAddress!.add(Null.fromJson(v));
    //   });
    // }
    status = json['status'];
    userInsuranceManadatory = json['user_insurance_manadatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_auto_shipment_insurance_setting'] =
        companyAutoShipmentInsuranceSetting;
    if (covidZones != null) {
      data['covid_zones'] = covidZones!.toJson();
    }
    data['currency'] = currency;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['dg_courier'] = dgCourier;
    data['eligible_for_insurance'] = eligibleForInsurance;
    data['insurace_opted_at_order_creation'] = insuraceOptedAtOrderCreation;
    data['is_allow_templatized_pricing'] = isAllowTemplatizedPricing;
    data['is_latlong'] = isLatlong;
    data['is_old_zone_opted'] = isOldZoneOpted;
    data['is_zone_from_mongo'] = isZoneFromMongo;
    data['label_generate_type'] = labelGenerateType;
    data['on_new_zone'] = onNewZone;
    // if (sellerAddress != null) {
    //   data['seller_address'] =
    //       sellerAddress!.map((v) => v.toJson()).toList();
    // }
    data['status'] = status;
    data['user_insurance_manadatory'] = userInsuranceManadatory;
    return data;
  }
}

class CovidZones {
  dynamic deliveryZone;
  dynamic pickupZone;

  CovidZones({this.deliveryZone, this.pickupZone});

  CovidZones.fromJson(Map<String, dynamic> json) {
    deliveryZone = json['delivery_zone'];
    pickupZone = json['pickup_zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delivery_zone'] = deliveryZone;
    data['pickup_zone'] = pickupZone;
    return data;
  }
}

class Data {
  List<AvailableCourierCompanies>? availableCourierCompanies;
  dynamic childCourierId;
  int? isRecommendationEnabled;
  int? recommendationAdvanceRule;
  RecommendedBy? recommendedBy;
  int? recommendedCourierCompanyId;
  int? shiprocketRecommendedCourierId;

  Data(
      {this.availableCourierCompanies,
      this.childCourierId,
      this.isRecommendationEnabled,
      this.recommendationAdvanceRule,
      this.recommendedBy,
      this.recommendedCourierCompanyId,
      this.shiprocketRecommendedCourierId});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['available_courier_companies'] != null) {
      availableCourierCompanies = <AvailableCourierCompanies>[];
      json['available_courier_companies'].forEach((v) {
        availableCourierCompanies!.add(AvailableCourierCompanies.fromJson(v));
      });
    }
    childCourierId = json['child_courier_id'];
    isRecommendationEnabled = json['is_recommendation_enabled'];
    recommendationAdvanceRule = json['recommendation_advance_rule'];
    recommendedBy = json['recommended_by'] != null
        ? RecommendedBy.fromJson(json['recommended_by'])
        : null;
    recommendedCourierCompanyId = json['recommended_courier_company_id'];
    shiprocketRecommendedCourierId = json['shiprocket_recommended_courier_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (availableCourierCompanies != null) {
      data['available_courier_companies'] =
          availableCourierCompanies!.map((v) => v.toJson()).toList();
    }
    data['child_courier_id'] = childCourierId;
    data['is_recommendation_enabled'] = isRecommendationEnabled;
    data['recommendation_advance_rule'] = recommendationAdvanceRule;
    if (recommendedBy != null) {
      data['recommended_by'] = recommendedBy!.toJson();
    }
    data['recommended_courier_company_id'] = recommendedCourierCompanyId;
    data['shiprocket_recommended_courier_id'] = shiprocketRecommendedCourierId;
    return data;
  }
}

class AvailableCourierCompanies {
  String? airMaxWeight;
  int? assuredAmount;
  dynamic baseCourierId;
  String? baseWeight;
  int? blocked;
  String? callBeforeDelivery;
  int? chargeWeight;
  String? city;
  int? cod;
  int? codCharges;
  int? codMultiplier;
  String? cost;
  int? courierCompanyId;
  String? courierName;
  String? courierType;
  int? coverageCharges;
  String? cutoffTime;
  String? deliveryBoyContact;
  num? deliveryPerformance;
  String? description;
  String? edd;
  int? entryTax;
  String? estimatedDeliveryDays;
  String? etd;
  int? etdHours;
  num? freightCharge;
  int? id;
  int? isCustomRate;
  bool? isHyperlocal;
  int? isInternational;
  bool? isRtoAddressAvailable;
  bool? isSurface;
  int? localRegion;
  int? metro;
  int? minWeight;
  int? mode;
  bool? odablock;
  int? otherCharges;
  String? others;
  String? pickupAvailability;
  int? pickupPerformance;
  String? pickupPriority;
  int? pickupSupressHours;
  String? podAvailable;
  String? postcode;
  int? qcCourier;
  String? rank;
  num? rate;
  int? rating;
  String? realtimeTracking;
  int? region;
  double? rtoCharges;
  double? rtoPerformance;
  int? secondsLeftForPickup;
  int? shipType;
  String? state;
  String? suppressDate;
  String? suppressText;
  SuppressionDates? suppressionDates;
  String? surfaceMaxWeight;
  double? trackingPerformance;
  dynamic volumetricMaxWeight;
  double? weightCases;
  String? zone;

  AvailableCourierCompanies(
      {this.airMaxWeight,
      this.assuredAmount,
      this.baseCourierId,
      this.baseWeight,
      this.blocked,
      this.callBeforeDelivery,
      this.chargeWeight,
      this.city,
      this.cod,
      this.codCharges,
      this.codMultiplier,
      this.cost,
      this.courierCompanyId,
      this.courierName,
      this.courierType,
      this.coverageCharges,
      this.cutoffTime,
      this.deliveryBoyContact,
      this.deliveryPerformance,
      this.description,
      this.edd,
      this.entryTax,
      this.estimatedDeliveryDays,
      this.etd,
      this.etdHours,
      this.freightCharge,
      this.id,
      this.isCustomRate,
      this.isHyperlocal,
      this.isInternational,
      this.isRtoAddressAvailable,
      this.isSurface,
      this.localRegion,
      this.metro,
      this.minWeight,
      this.mode,
      this.odablock,
      this.otherCharges,
      this.others,
      this.pickupAvailability,
      this.pickupPerformance,
      this.pickupPriority,
      this.pickupSupressHours,
      this.podAvailable,
      this.postcode,
      this.qcCourier,
      this.rank,
      this.rate,
      this.rating,
      this.realtimeTracking,
      this.region,
      this.rtoCharges,
      this.rtoPerformance,
      this.secondsLeftForPickup,
      this.shipType,
      this.state,
      this.suppressDate,
      this.suppressText,
      this.suppressionDates,
      this.surfaceMaxWeight,
      this.trackingPerformance,
      this.volumetricMaxWeight,
      this.weightCases,
      this.zone});

  AvailableCourierCompanies.fromJson(Map<String, dynamic> json) {
    airMaxWeight = json['air_max_weight'];
    assuredAmount = json['assured_amount'];
    baseCourierId = json['base_courier_id'];
    baseWeight = json['base_weight'];
    blocked = json['blocked'];
    callBeforeDelivery = json['call_before_delivery'];
    chargeWeight = json['charge_weight'];
    city = json['city'];
    cod = json['cod'];
    codCharges = json['cod_charges'];
    codMultiplier = json['cod_multiplier'];
    cost = json['cost'];
    courierCompanyId = json['courier_company_id'];
    courierName = json['courier_name'];
    courierType = json['courier_type'];
    coverageCharges = json['coverage_charges'];
    cutoffTime = json['cutoff_time'];
    deliveryBoyContact = json['delivery_boy_contact'];
    deliveryPerformance = json['delivery_performance'];
    description = json['description'];
    edd = json['edd'];
    entryTax = json['entry_tax'];
    estimatedDeliveryDays = json['estimated_delivery_days'];
    etd = json['etd'];
    etdHours = json['etd_hours'];
    freightCharge = json['freight_charge'];
    id = json['id'];
    isCustomRate = json['is_custom_rate'];
    isHyperlocal = json['is_hyperlocal'];
    isInternational = json['is_international'];
    isRtoAddressAvailable = json['is_rto_address_available'];
    isSurface = json['is_surface'];
    localRegion = json['local_region'];
    metro = json['metro'];
    minWeight = json['min_weight'];
    mode = json['mode'];
    odablock = json['odablock'];
    otherCharges = json['other_charges'];
    others = json['others'];
    pickupAvailability = json['pickup_availability'];
    pickupPerformance = json['pickup_performance'];
    pickupPriority = json['pickup_priority'];
    pickupSupressHours = json['pickup_supress_hours'];
    podAvailable = json['pod_available'];
    postcode = json['postcode'];
    qcCourier = json['qc_courier'];
    rank = json['rank'];
    rate = json['rate'];
    rating = json['rating'];
    realtimeTracking = json['realtime_tracking'];
    region = json['region'];
    rtoCharges = json['rto_charges'];
    rtoPerformance = json['rto_performance'];
    secondsLeftForPickup = json['seconds_left_for_pickup'];
    shipType = json['ship_type'];
    state = json['state'];
    suppressDate = json['suppress_date'];
    suppressText = json['suppress_text'];
    suppressionDates = json['suppression_dates'] != null
        ? SuppressionDates.fromJson(json['suppression_dates'])
        : null;
    surfaceMaxWeight = json['surface_max_weight'];
    trackingPerformance = json['tracking_performance'];
    volumetricMaxWeight = json['volumetric_max_weight'];
    weightCases = json['weight_cases'];
    zone = json['zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['air_max_weight'] = airMaxWeight;
    data['assured_amount'] = assuredAmount;
    data['base_courier_id'] = baseCourierId;
    data['base_weight'] = baseWeight;
    data['blocked'] = blocked;
    data['call_before_delivery'] = callBeforeDelivery;
    data['charge_weight'] = chargeWeight;
    data['city'] = city;
    data['cod'] = cod;
    data['cod_charges'] = codCharges;
    data['cod_multiplier'] = codMultiplier;
    data['cost'] = cost;
    data['courier_company_id'] = courierCompanyId;
    data['courier_name'] = courierName;
    data['courier_type'] = courierType;
    data['coverage_charges'] = coverageCharges;
    data['cutoff_time'] = cutoffTime;
    data['delivery_boy_contact'] = deliveryBoyContact;
    data['delivery_performance'] = deliveryPerformance;
    data['description'] = description;
    data['edd'] = edd;
    data['entry_tax'] = entryTax;
    data['estimated_delivery_days'] = estimatedDeliveryDays;
    data['etd'] = etd;
    data['etd_hours'] = etdHours;
    data['freight_charge'] = freightCharge;
    data['id'] = id;
    data['is_custom_rate'] = isCustomRate;
    data['is_hyperlocal'] = isHyperlocal;
    data['is_international'] = isInternational;
    data['is_rto_address_available'] = isRtoAddressAvailable;
    data['is_surface'] = isSurface;
    data['local_region'] = localRegion;
    data['metro'] = metro;
    data['min_weight'] = minWeight;
    data['mode'] = mode;
    data['odablock'] = odablock;
    data['other_charges'] = otherCharges;
    data['others'] = others;
    data['pickup_availability'] = pickupAvailability;
    data['pickup_performance'] = pickupPerformance;
    data['pickup_priority'] = pickupPriority;
    data['pickup_supress_hours'] = pickupSupressHours;
    data['pod_available'] = podAvailable;
    data['postcode'] = postcode;
    data['qc_courier'] = qcCourier;
    data['rank'] = rank;
    data['rate'] = rate;
    data['rating'] = rating;
    data['realtime_tracking'] = realtimeTracking;
    data['region'] = region;
    data['rto_charges'] = rtoCharges;
    data['rto_performance'] = rtoPerformance;
    data['seconds_left_for_pickup'] = secondsLeftForPickup;
    data['ship_type'] = shipType;
    data['state'] = state;
    data['suppress_date'] = suppressDate;
    data['suppress_text'] = suppressText;
    if (suppressionDates != null) {
      data['suppression_dates'] = suppressionDates!.toJson();
    }
    data['surface_max_weight'] = surfaceMaxWeight;
    data['tracking_performance'] = trackingPerformance;
    data['volumetric_max_weight'] = volumetricMaxWeight;
    data['weight_cases'] = weightCases;
    data['zone'] = zone;
    return data;
  }
}

class SuppressionDates {
  String? actionOn;
  String? delayRemark;
  int? deliveryDelayBy;
  String? deliveryDelayDays;
  String? deliveryDelayFrom;
  String? deliveryDelayTo;
  int? pickupDelayBy;
  String? pickupDelayDays;
  String? pickupDelayFrom;
  String? pickupDelayTo;

  SuppressionDates(
      {this.actionOn,
      this.delayRemark,
      this.deliveryDelayBy,
      this.deliveryDelayDays,
      this.deliveryDelayFrom,
      this.deliveryDelayTo,
      this.pickupDelayBy,
      this.pickupDelayDays,
      this.pickupDelayFrom,
      this.pickupDelayTo});

  SuppressionDates.fromJson(Map<String, dynamic> json) {
    actionOn = json['action_on'];
    delayRemark = json['delay_remark'];
    deliveryDelayBy = json['delivery_delay_by'];
    deliveryDelayDays = json['delivery_delay_days'];
    deliveryDelayFrom = json['delivery_delay_from'];
    deliveryDelayTo = json['delivery_delay_to'];
    pickupDelayBy = json['pickup_delay_by'];
    pickupDelayDays = json['pickup_delay_days'];
    pickupDelayFrom = json['pickup_delay_from'];
    pickupDelayTo = json['pickup_delay_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action_on'] = actionOn;
    data['delay_remark'] = delayRemark;
    data['delivery_delay_by'] = deliveryDelayBy;
    data['delivery_delay_days'] = deliveryDelayDays;
    data['delivery_delay_from'] = deliveryDelayFrom;
    data['delivery_delay_to'] = deliveryDelayTo;
    data['pickup_delay_by'] = pickupDelayBy;
    data['pickup_delay_days'] = pickupDelayDays;
    data['pickup_delay_from'] = pickupDelayFrom;
    data['pickup_delay_to'] = pickupDelayTo;
    return data;
  }
}

class RecommendedBy {
  int? id;
  String? title;

  RecommendedBy({this.id, this.title});

  RecommendedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
