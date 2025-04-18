class ProjectsModel {
  dynamic projectIndex;
  dynamic clientUID;
  dynamic projectUID;
  dynamic clientName;
  dynamic clientCompany;
  dynamic projectName;
  dynamic projectPlatform;
  dynamic projectShortBio;
  dynamic projectDescription;
  dynamic projectDate;
  dynamic projectType;
  dynamic projectDuration;
  dynamic paidAmount;
  dynamic unPaidAmount;
  dynamic discountedAmount;
  dynamic projectBudget;
  dynamic projectChallengesFaced;
  dynamic projectResultsAndImpacts;
  dynamic projectStatus;
  dynamic darkMainImageBG;
  dynamic darkSecondImageBG;
  dynamic darkThirdImageBG;
  dynamic mainImage;
  dynamic secondImage;
  dynamic thirdImage;
  dynamic extraImage1;
  dynamic extraImage2;
  dynamic extraImage3;
  dynamic extraImage4;
  dynamic extraImage5;
  dynamic extraImage6;
  dynamic extraImage7;
  dynamic extraImage8;
  dynamic extraImage9;
  dynamic extraImage10;
  dynamic extraImage11;
  dynamic extraImage12;
  dynamic extraImage13;
  dynamic extraImage14;
  dynamic extraImage15;
  dynamic extraImage16;
  dynamic extraImage17;
  dynamic mobileView;
  dynamic likesCount;
  dynamic starsCount;
  dynamic loveCount;
  dynamic appIcon;
  dynamic iconPadding;
  dynamic appThemeColor;
  dynamic builtForAndroid;
  dynamic builtForApple;
  dynamic projectIsCompleted;
  dynamic clientReview;

  ProjectsModel({
    this.projectIndex = "",
    this.clientUID = "",
    this.projectUID = "",
    this.clientName = "",
    this.clientCompany = "",
    this.projectName = "",
    this.projectPlatform = "",
    this.projectShortBio = "",
    this.projectDescription = "",
    this.projectDate = "",
    this.projectType = "",
    this.projectDuration = "",
    this.paidAmount = "",
    this.unPaidAmount = "",
    this.discountedAmount = "",
    this.projectBudget = "",
    this.projectChallengesFaced = "",
    this.projectResultsAndImpacts = "",
    this.projectStatus = "",
    this.darkMainImageBG = false,
    this.darkSecondImageBG = false,
    this.darkThirdImageBG = false,
    this.mainImage = "",
    this.secondImage = "",
    this.thirdImage = "",
    this.extraImage1 = "",
    this.extraImage2 = "",
    this.extraImage3 = "",
    this.extraImage4 = "",
    this.extraImage5 = "",
    this.extraImage6 = "",
    this.extraImage7 = "",
    this.extraImage8 = "",
    this.extraImage9 = "",
    this.extraImage10 = "",
    this.extraImage11 = "",
    this.extraImage12 = "",
    this.extraImage13 = "",
    this.extraImage14 = "",
    this.extraImage15 = "",
    this.extraImage16 = "",
    this.extraImage17 = "",
    this.mobileView = "",
    this.likesCount = "",
    this.starsCount = "",
    this.loveCount = "",
    this.appIcon = "",
    this.iconPadding = true,
    this.appThemeColor = "",
    this.builtForAndroid = true,
    this.builtForApple = false,
    this.projectIsCompleted = false,
    this.clientReview = "",
  });

  factory ProjectsModel.fromJson(dynamic json) {
    if (json != null) {
      final projectIndex = json['projectIndex'] ?? "";
      final clientUID = json['clientUID'] ?? "";
      final projectUID = json['projectUID'] ?? "";
      final clientName = json['clientName'] ?? "";
      final clientCompany = json['clientCompany'] ?? "";
      final projectName = json['projectName'] ?? "";
      final projectPlatform = json['projectPlatform'] ?? "";
      final projectShortBio = json['projectShortBio'] ?? "";
      final projectDescription = json['projectDescription'] ?? "";
      final projectDate = json['projectDate'] ?? "";
      final projectType = json['projectType'] ?? "";
      final projectDuration = json['projectDuration'] ?? "";
      final paidAmount = json['paidAmount'] ?? "";
      final unPaidAmount = json['unPaidAmount'] ?? "";
      final discountedAmount = json['discountedAmount'] ?? "";
      final projectBudget = json['projectBudget'] ?? "";
      final projectChallengesFaced = json['projectChallengesFaced'] ?? "";
      final projectResultsAndImpacts = json['projectResultsAndImpacts'] ?? "";
      final projectStatus = json['projectStatus'] ?? "";
      final darkMainImageBG = json['darkMainImageBG'] ?? false;
      final darkSecondImageBG = json['darkSecondImageBG'] ?? false;
      final darkThirdImageBG = json['darkThirdImageBG'] ?? false;
      final mainImage = json['mainImage'] ?? "";
      final secondImage = json['secondImage'] ?? "";
      final thirdImage = json['thirdImage'] ?? "";
      final extraImage1 = json['extraImage1'] ?? "";
      final extraImage2 = json['extraImage2'] ?? "";
      final extraImage3 = json['extraImage3'] ?? "";
      final extraImage4 = json['extraImage4'] ?? "";
      final extraImage5 = json['extraImage5'] ?? "";
      final extraImage6 = json['extraImage6'] ?? "";
      final extraImage7 = json['extraImage7'] ?? "";
      final extraImage8 = json['extraImage8'] ?? "";
      final extraImage9 = json['extraImage9'] ?? "";
      final extraImage10 = json['extraImage10'] ?? "";
      final extraImage11 = json['extraImage11'] ?? "";
      final extraImage12 = json['extraImage12'] ?? "";
      final extraImage13 = json['extraImage13'] ?? "";
      final extraImage14 = json['extraImage14'] ?? "";
      final extraImage15 = json['extraImage15'] ?? "";
      final extraImage16 = json['extraImage16'] ?? "";
      final extraImage17 = json['extraImage17'] ?? "";
      final mobileView = json['mobileView'] ?? "";
      final likesCount = json['likesCount'] ?? "";
      final starsCount = json['starsCount'] ?? "";
      final loveCount = json['loveCount'] ?? "";
      final appIcon = json['appIcon'] ?? "";
      final iconPadding = json['iconPadding'] ?? false;
      final appThemeColor = json['appThemeColor'] ?? "";
      final builtForAndroid = json['builtForAndroid'] ?? true;
      final builtForApple = json['builtForApple'] ?? false;
      final projectIsCompleted = json['projectIsCompleted'] ?? false;
      final clientReview = json['clientReview'] ?? "";

      return ProjectsModel(
        projectIndex: projectIndex,
        clientUID: clientUID,
        projectUID: projectUID,
        clientName: clientName,
        clientCompany: clientCompany,
        projectName: projectName,
        projectPlatform: projectPlatform,
        projectShortBio: projectShortBio,
        projectDescription: projectDescription,
        projectDate: projectDate,
        projectType: projectType,
        projectDuration: projectDuration,
        paidAmount: paidAmount,
        unPaidAmount: unPaidAmount,
        discountedAmount: discountedAmount,
        projectBudget: projectBudget,
        projectChallengesFaced: projectChallengesFaced,
        projectResultsAndImpacts: projectResultsAndImpacts,
        projectStatus: projectStatus,
        darkMainImageBG: darkMainImageBG,
        darkSecondImageBG: darkSecondImageBG,
        darkThirdImageBG: darkThirdImageBG,
        mainImage: mainImage,
        secondImage: secondImage,
        thirdImage: thirdImage,
        extraImage1: extraImage1,
        extraImage2: extraImage2,
        extraImage3: extraImage3,
        extraImage4: extraImage4,
        extraImage5: extraImage5,
        extraImage6: extraImage6,
        extraImage7: extraImage7,
        extraImage8: extraImage8,
        extraImage9: extraImage9,
        extraImage10: extraImage10,
        extraImage11: extraImage11,
        extraImage12: extraImage12,
        extraImage13: extraImage13,
        extraImage14: extraImage14,
        extraImage15: extraImage15,
        extraImage16: extraImage16,
        extraImage17: extraImage17,
        mobileView: mobileView,
        likesCount: likesCount,
        starsCount: starsCount,
        loveCount: loveCount,
        appIcon: appIcon,
        iconPadding: iconPadding,
        appThemeColor: appThemeColor,
        builtForAndroid: builtForAndroid,
        builtForApple: builtForApple,
        projectIsCompleted: projectIsCompleted,
        clientReview: clientReview,
      );
    }
    return ProjectsModel();
  }

  Map<String, dynamic> toJson() {
    return {
      'projectIndex': projectIndex,
      'clientUID': clientUID,
      'projectUID': projectUID,
      'clientName': clientName,
      'clientCompany': clientCompany,
      'projectName': projectName,
      'projectPlatform': projectPlatform,
      'projectShortBio': projectShortBio,
      'projectDescription': projectDescription,
      'projectDate': projectDate,
      'projectType': projectType,
      'projectDuration': projectDuration,
      'paidAmount': paidAmount,
      'unPaidAmount': unPaidAmount,
      'discountedAmount': discountedAmount,
      'projectBudget': projectBudget,
      'projectChallengesFaced': projectChallengesFaced,
      'projectResultsAndImpacts': projectResultsAndImpacts,
      'projectStatus': projectStatus,
      'darkMainImageBG': darkMainImageBG,
      'darkSecondImageBG': darkSecondImageBG,
      'darkThirdImageBG': darkThirdImageBG,
      'mainImage': mainImage,
      'secondImage': secondImage,
      'thirdImage': thirdImage,
      'extraImage1': extraImage1,
      'extraImage2': extraImage2,
      'extraImage3': extraImage3,
      'extraImage4': extraImage4,
      'extraImage5': extraImage5,
      'extraImage6': extraImage6,
      'extraImage7': extraImage7,
      'extraImage8': extraImage8,
      'extraImage9': extraImage9,
      'extraImage10': extraImage10,
      'extraImage11': extraImage11,
      'extraImage12': extraImage12,
      'extraImage13': extraImage13,
      'extraImage14': extraImage14,
      'extraImage15': extraImage15,
      'extraImage16': extraImage16,
      'extraImage17': extraImage17,
      'mobileView': mobileView,
      'likesCount': likesCount,
      'starsCount': starsCount,
      'loveCount': loveCount,
      'appIcon': appIcon,
      'iconPadding': iconPadding,
      'appThemeColor': appThemeColor,
      'builtForAndroid': builtForAndroid,
      'builtForApple': builtForApple,
      'projectIsCompleted': projectIsCompleted,
      'clientReview': clientReview,
    };
  }

  // The copyWith method allows creating a new instance with some updated fields
  ProjectsModel copyWith({
    dynamic projectIndex,
    dynamic clientUID,
    dynamic projectUID,
    dynamic clientName,
    dynamic clientCompany,
    dynamic projectName,
    dynamic projectPlatform,
    dynamic projectShortBio,
    dynamic projectDescription,
    dynamic projectDate,
    dynamic projectType,
    dynamic projectDuration,
    dynamic paidAmount,
    dynamic unPaidAmount,
    dynamic discountedAmount,
    dynamic projectBudget,
    dynamic projectChallengesFaced,
    dynamic projectResultsAndImpacts,
    dynamic projectStatus,
    dynamic darkMainImageBG,
    dynamic darkSecondImageBG,
    dynamic darkThirdImageBG,
    dynamic mainImage,
    dynamic secondImage,
    dynamic thirdImage,
    dynamic extraImage1,
    dynamic extraImage2,
    dynamic extraImage3,
    dynamic extraImage4,
    dynamic extraImage5,
    dynamic extraImage6,
    dynamic extraImage7,
    dynamic extraImage8,
    dynamic extraImage9,
    dynamic extraImage10,
    dynamic extraImage11,
    dynamic extraImage12,
    dynamic extraImage13,
    dynamic extraImage14,
    dynamic extraImage15,
    dynamic extraImage16,
    dynamic extraImage17,
    dynamic mobileView,
    dynamic likesCount,
    dynamic starsCount,
    dynamic loveCount,
    dynamic appIcon,
    dynamic iconPadding,
    dynamic appThemeColor,
    dynamic builtForAndroid,
    dynamic builtForApple,
    dynamic projectIsCompleted,
    dynamic clientReview,
  }) {
    return ProjectsModel(
      projectIndex: projectIndex ?? this.projectIndex,
      clientUID: clientUID ?? this.clientUID,
      projectUID: projectUID ?? this.projectUID,
      clientName: clientName ?? this.clientName,
      clientCompany: clientCompany ?? this.clientCompany,
      projectName: projectName ?? this.projectName,
      projectPlatform: projectPlatform ?? this.projectPlatform,
      projectShortBio: projectShortBio ?? this.projectShortBio,
      projectDescription: projectDescription ?? this.projectDescription,
      projectDate: projectDate ?? this.projectDate,
      projectType: projectType ?? this.projectType,
      projectDuration: projectDuration ?? this.projectDuration,
      paidAmount: paidAmount ?? this.paidAmount,
      unPaidAmount: unPaidAmount ?? this.unPaidAmount,
      discountedAmount: discountedAmount ?? this.discountedAmount,
      projectBudget: projectBudget ?? this.projectBudget,
      projectChallengesFaced: projectChallengesFaced ?? this.projectChallengesFaced,
      projectResultsAndImpacts: projectResultsAndImpacts ?? this.projectResultsAndImpacts,
      projectStatus: projectStatus ?? this.projectStatus,
      darkMainImageBG: darkMainImageBG ?? this.darkMainImageBG,
      darkSecondImageBG: darkSecondImageBG ?? this.darkSecondImageBG,
      darkThirdImageBG: darkThirdImageBG ?? this.darkThirdImageBG,
      mainImage: mainImage ?? this.mainImage,
      secondImage: secondImage ?? this.secondImage,
      thirdImage: thirdImage ?? this.thirdImage,
      extraImage1: extraImage1 ?? this.extraImage1,
      extraImage2: extraImage2 ?? this.extraImage2,
      extraImage3: extraImage3 ?? this.extraImage3,
      extraImage4: extraImage4 ?? this.extraImage4,
      extraImage5: extraImage5 ?? this.extraImage5,
      extraImage6: extraImage6 ?? this.extraImage6,
      extraImage7: extraImage7 ?? this.extraImage7,
      extraImage8: extraImage8 ?? this.extraImage8,
      extraImage9: extraImage9 ?? this.extraImage9,
      extraImage10: extraImage10 ?? this.extraImage10,
      extraImage11: extraImage11 ?? this.extraImage11,
      extraImage12: extraImage12 ?? this.extraImage12,
      extraImage13: extraImage13 ?? this.extraImage13,
      extraImage14: extraImage14 ?? this.extraImage14,
      extraImage15: extraImage15 ?? this.extraImage15,
      extraImage16: extraImage16 ?? this.extraImage16,
      extraImage17: extraImage17 ?? this.extraImage17,
      mobileView: mobileView ?? this.mobileView,
      likesCount: likesCount ?? this.likesCount,
      starsCount: starsCount ?? this.starsCount,
      loveCount: loveCount ?? this.loveCount,
      appIcon: appIcon ?? this.appIcon,
      iconPadding: iconPadding ?? this.iconPadding,
      appThemeColor: appThemeColor ?? this.appThemeColor,
      builtForAndroid: builtForAndroid ?? this.builtForAndroid,
      builtForApple: builtForApple ?? this.builtForApple,
      projectIsCompleted: projectIsCompleted ?? this.projectIsCompleted,
      clientReview: clientReview ?? this.clientReview,
    );
  }
}
