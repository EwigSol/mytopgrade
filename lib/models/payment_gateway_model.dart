

import 'dart:convert';

List<PaymentGatewayModel> paymentGatewayModelFromJson(String str) => List<PaymentGatewayModel>.from(json.decode(str).map((x) => PaymentGatewayModel.fromJson(x)));


class PaymentGatewayModel {
  PaymentGatewayModel({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.settings,
    this.needsSetup,
    this.postInstallScripts,
    this.settingsUrl,
    this.connectionUrl,
    this.setupHelpText,
    this.requiredSettingsKeys,
    this.links,
  });

  String? id;
  String? title;
  String? description;
  int? order;
  bool? enabled;
  String? methodTitle;
  String? methodDescription;
  List<String>? methodSupports;
  Settings? settings;
  bool? needsSetup;
  List<dynamic>? postInstallScripts;
  String? settingsUrl;
  dynamic connectionUrl;
  dynamic setupHelpText;
  List<dynamic>? requiredSettingsKeys;
  Links? links;

  factory PaymentGatewayModel.fromJson(Map<String, dynamic> json) => PaymentGatewayModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    order: json["order"],
    enabled: json["enabled"],
    methodTitle: json["method_title"],
    methodDescription: json["method_description"],
    methodSupports: List<String>.from(json["method_supports"].map((x) => x)),
    settings: Settings.fromJson(json["settings"]),
    needsSetup: json["needs_setup"],
    postInstallScripts: List<dynamic>.from(json["post_install_scripts"].map((x) => x)),
    settingsUrl: json["settings_url"],
    connectionUrl: json["connection_url"],
    setupHelpText: json["setup_help_text"],
    requiredSettingsKeys: List<dynamic>.from(json["required_settings_keys"].map((x) => x)),
    links: Links.fromJson(json["_links"]),
  );

}

class Links {
  Links({this.self, this.collection});

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))),
    collection: List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
  );

}

class Collection {
  Collection({this.href});

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );
}

class Settings {
  Settings({
    this.title,
    this.instructions,
    this.enableForMethods,
    this.enableForVirtual,
    this.email,
    this.advanced,
    this.testmode,
    this.debug,
    this.ipnNotification,
    this.receiverEmail,
    this.identityToken,
    this.invoicePrefix,
    this.sendShipping,
    this.addressOverride,
    this.paymentaction,
    this.imageUrl,
    this.apiDetails,
    this.apiUsername,
    this.apiPassword,
    this.apiSignature,
    this.sandboxApiUsername,
    this.sandboxApiPassword,
    this.sandboxApiSignature,
    this.expressCheckout,
    this.credentialsTitle,
    this.environment,
    this.sandboxUsername,
    this.sandboxPassword,
    this.sandboxSignature,
    this.liveUsername,
    this.livePassword,
    this.liveSignature,
    this.expressTitle,
    this.expressButtonOnPages,
    this.creditButtonOnPages,
    this.expressDescription,
    this.buttonSize,
    this.abilitiesTitle,
    this.businessName,
    this.landingPage,
    this.checkoutLogo,
    this.checkoutBanner,
    this.paypalLocale,
    this.advancedOptionTitle,
    this.paypalAllowOverride,
    this.skipReview,
    this.saveCancelledOrder,
    this.policyNotes,
    this.smartButtonCredentialsTitle,
    this.smartButtonEnvironment,
    this.sandboxClientId,
    this.sandboxClientSecret,
    this.liveClientId,
    this.liveClientSecret,
    this.smartButtonTitle,
    this.smartButtonGatewayDescription,
    this.smartButtonDisplayTitle,
    this.smartButtonOnPages,
    this.smartButtonDescription,
    this.smartButtonSize,
    this.buttonLabel,
    this.buttonTagline,
    this.buttonColor,
    this.buttonShape,
    this.buttonLayout,
    this.disableFundingSource,
    this.smartButtonAbilitiesTitle,
    this.smartButtonBusinessName,
    this.smartButtonLandingPage,
    this.smartButtonPaypalLocale,
    this.smartButtonAdvancedOptionTitle,
    this.smartButtonInvoicePrefix,
    this.smartButtonPaypalAllowOverride,
    this.smartButtonSendShipping,
    this.smartButtonSkipReview,
    this.smartButtonSaveCancelledOrder,
    this.smartButtonPolicyNotes,
    this.logTitle,
    this.paypalLogging,
    this.goLive,
    this.loggingOption,
    this.barter,
    this.webhook,
    this.secretHash,
    this.testPublicKey,
    this.testSecretKey,
    this.livePublicKey,
    this.liveSecretKey,
    this.paymentStyle,
    this.paymentOptions,
    this.customTitle,
    this.customDesc,
    this.customLogo,
    this.savedCards,
  });

  Title? title;
  Title? instructions;
  Title? enableForMethods;
  Title? enableForVirtual;
  Title? email;
  Title? advanced;
  Title? testmode;
  Title? debug;
  Title? ipnNotification;
  Title? receiverEmail;
  Title? identityToken;
  Title? invoicePrefix;
  Title? sendShipping;
  Title? addressOverride;
  Title? paymentaction;
  Title? imageUrl;
  Title? apiDetails;
  Title? apiUsername;
  Title? apiPassword;
  Title? apiSignature;
  Title? sandboxApiUsername;
  Title? sandboxApiPassword;
  Title? sandboxApiSignature;
  Title? expressCheckout;
  Title? credentialsTitle;
  Title? environment;
  Title? sandboxUsername;
  Title? sandboxPassword;
  Title? sandboxSignature;
  Title? liveUsername;
  Title? livePassword;
  Title? liveSignature;
  Title? expressTitle;
  ButtonOnPages? expressButtonOnPages;
  ButtonOnPages? creditButtonOnPages;
  Title? expressDescription;
  Title? buttonSize;
  Title? abilitiesTitle;
  Title? businessName;
  Title? landingPage;
  Title? checkoutLogo;
  Title? checkoutBanner;
  Title? paypalLocale;
  Title? advancedOptionTitle;
  Title? paypalAllowOverride;
  Title? skipReview;
  Title? saveCancelledOrder;
  Title? policyNotes;
  Title? smartButtonCredentialsTitle;
  Title? smartButtonEnvironment;
  Title? sandboxClientId;
  Title? sandboxClientSecret;
  Title? liveClientId;
  Title? liveClientSecret;
  Title? smartButtonTitle;
  Title? smartButtonGatewayDescription;
  Title? smartButtonDisplayTitle;
  ButtonOnPages? smartButtonOnPages;
  Title? smartButtonDescription;
  Title? smartButtonSize;
  Title? buttonLabel;
  ButtonTagline? buttonTagline;
  Title? buttonColor;
  Title? buttonShape;
  Title? buttonLayout;
  Title? disableFundingSource;
  Title? smartButtonAbilitiesTitle;
  Title? smartButtonBusinessName;
  Title? smartButtonLandingPage;
  Title? smartButtonPaypalLocale;
  Title? smartButtonAdvancedOptionTitle;
  Title? smartButtonInvoicePrefix;
  Title? smartButtonPaypalAllowOverride;
  Title? smartButtonSendShipping;
  Title? smartButtonSkipReview;
  Title? smartButtonSaveCancelledOrder;
  Title? smartButtonPolicyNotes;
  Title? logTitle;
  Title? paypalLogging;
  Title? goLive;
  Title? loggingOption;
  Title? barter;
  Title? webhook;
  Title? secretHash;
  Title? testPublicKey;
  Title? testSecretKey;
  Title? livePublicKey;
  Title? liveSecretKey;
  Title? paymentStyle;
  Title? paymentOptions;
  Title? customTitle;
  Title? customDesc;
  Title? customLogo;
  Title? savedCards;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    title: Title.fromJson(json["title"]),
    instructions: json["instructions"] == null ? null : Title.fromJson(json["instructions"]),
    enableForMethods: json["enable_for_methods"] == null ? null : Title.fromJson(json["enable_for_methods"]),
    enableForVirtual: json["enable_for_virtual"] == null ? null : Title.fromJson(json["enable_for_virtual"]),
    email: json["email"] == null ? null : Title.fromJson(json["email"]),
    advanced: json["advanced"] == null ? null : Title.fromJson(json["advanced"]),
    testmode: json["testmode"] == null ? null : Title.fromJson(json["testmode"]),
    debug: json["debug"] == null ? null : Title.fromJson(json["debug"]),
    ipnNotification: json["ipn_notification"] == null ? null : Title.fromJson(json["ipn_notification"]),
    receiverEmail: json["receiver_email"] == null ? null : Title.fromJson(json["receiver_email"]),
    identityToken: json["identity_token"] == null ? null : Title.fromJson(json["identity_token"]),
    invoicePrefix: json["invoice_prefix"] == null ? null : Title.fromJson(json["invoice_prefix"]),
    sendShipping: json["send_shipping"] == null ? null : Title.fromJson(json["send_shipping"]),
    addressOverride: json["address_override"] == null ? null : Title.fromJson(json["address_override"]),
    paymentaction: json["paymentaction"] == null ? null : Title.fromJson(json["paymentaction"]),
    imageUrl: json["image_url"] == null ? null : Title.fromJson(json["image_url"]),
    apiDetails: json["api_details"] == null ? null : Title.fromJson(json["api_details"]),
    apiUsername: json["api_username"] == null ? null : Title.fromJson(json["api_username"]),
    apiPassword: json["api_password"] == null ? null : Title.fromJson(json["api_password"]),
    apiSignature: json["api_signature"] == null ? null : Title.fromJson(json["api_signature"]),
    sandboxApiUsername: json["sandbox_api_username"] == null ? null : Title.fromJson(json["sandbox_api_username"]),
    sandboxApiPassword: json["sandbox_api_password"] == null ? null : Title.fromJson(json["sandbox_api_password"]),
    sandboxApiSignature: json["sandbox_api_signature"] == null ? null : Title.fromJson(json["sandbox_api_signature"]),
    expressCheckout: json["express_checkout"] == null ? null : Title.fromJson(json["express_checkout"]),
    credentialsTitle: json["credentials_title"] == null ? null : Title.fromJson(json["credentials_title"]),
    environment: json["environment"] == null ? null : Title.fromJson(json["environment"]),
    sandboxUsername: json["sandbox_username"] == null ? null : Title.fromJson(json["sandbox_username"]),
    sandboxPassword: json["sandbox_password"] == null ? null : Title.fromJson(json["sandbox_password"]),
    sandboxSignature: json["sandbox_signature"] == null ? null : Title.fromJson(json["sandbox_signature"]),
    liveUsername: json["live_username"] == null ? null : Title.fromJson(json["live_username"]),
    livePassword: json["live_password"] == null ? null : Title.fromJson(json["live_password"]),
    liveSignature: json["live_signature"] == null ? null : Title.fromJson(json["live_signature"]),
    expressTitle: json["express_title"] == null ? null : Title.fromJson(json["express_title"]),
    expressButtonOnPages: json["express_button_on_pages"] == null ? null : ButtonOnPages.fromJson(json["express_button_on_pages"]),
    creditButtonOnPages: json["credit_button_on_pages"] == null ? null : ButtonOnPages.fromJson(json["credit_button_on_pages"]),
    expressDescription: json["express_description"] == null ? null : Title.fromJson(json["express_description"]),
    buttonSize: json["button_size"] == null ? null : Title.fromJson(json["button_size"]),
    abilitiesTitle: json["abilities_title"] == null ? null : Title.fromJson(json["abilities_title"]),
    businessName: json["business_name"] == null ? null : Title.fromJson(json["business_name"]),
    landingPage: json["landing_page"] == null ? null : Title.fromJson(json["landing_page"]),
    checkoutLogo: json["checkout_logo"] == null ? null : Title.fromJson(json["checkout_logo"]),
    checkoutBanner: json["checkout_banner"] == null ? null : Title.fromJson(json["checkout_banner"]),
    paypalLocale: json["paypal_locale"] == null ? null : Title.fromJson(json["paypal_locale"]),
    advancedOptionTitle: json["advanced_option_title"] == null ? null : Title.fromJson(json["advanced_option_title"]),
    paypalAllowOverride: json["paypal_allow_override"] == null ? null : Title.fromJson(json["paypal_allow_override"]),
    skipReview: json["skip_review"] == null ? null : Title.fromJson(json["skip_review"]),
    saveCancelledOrder: json["save_cancelled_order"] == null ? null : Title.fromJson(json["save_cancelled_order"]),
    policyNotes: json["policy_notes"] == null ? null : Title.fromJson(json["policy_notes"]),
    smartButtonCredentialsTitle: json["smart_button_credentials_title"] == null ? null : Title.fromJson(json["smart_button_credentials_title"]),
    smartButtonEnvironment: json["smart_button_environment"] == null ? null : Title.fromJson(json["smart_button_environment"]),
    sandboxClientId: json["sandbox_client_id"] == null ? null : Title.fromJson(json["sandbox_client_id"]),
    sandboxClientSecret: json["sandbox_client_secret"] == null ? null : Title.fromJson(json["sandbox_client_secret"]),
    liveClientId: json["live_client_id"] == null ? null : Title.fromJson(json["live_client_id"]),
    liveClientSecret: json["live_client_secret"] == null ? null : Title.fromJson(json["live_client_secret"]),
    smartButtonTitle: json["smart_button_title"] == null ? null : Title.fromJson(json["smart_button_title"]),
    smartButtonGatewayDescription: json["smart_button_gateway_description"] == null ? null : Title.fromJson(json["smart_button_gateway_description"]),
    smartButtonDisplayTitle: json["smart_button_display_title"] == null ? null : Title.fromJson(json["smart_button_display_title"]),
    smartButtonOnPages: json["smart_button_on_pages"] == null ? null : ButtonOnPages.fromJson(json["smart_button_on_pages"]),
    smartButtonDescription: json["smart_button_description"] == null ? null : Title.fromJson(json["smart_button_description"]),
    smartButtonSize: json["smart_button_size"] == null ? null : Title.fromJson(json["smart_button_size"]),
    buttonLabel: json["button_label"] == null ? null : Title.fromJson(json["button_label"]),
    buttonTagline: json["button_tagline"] == null ? null : ButtonTagline.fromJson(json["button_tagline"]),
    buttonColor: json["button_color"] == null ? null : Title.fromJson(json["button_color"]),
    buttonShape: json["button_shape"] == null ? null : Title.fromJson(json["button_shape"]),
    buttonLayout: json["button_layout"] == null ? null : Title.fromJson(json["button_layout"]),
    disableFundingSource: json["disable_funding_source"] == null ? null : Title.fromJson(json["disable_funding_source"]),
    smartButtonAbilitiesTitle: json["smart_button_abilities_title"] == null ? null : Title.fromJson(json["smart_button_abilities_title"]),
    smartButtonBusinessName: json["smart_button_business_name"] == null ? null : Title.fromJson(json["smart_button_business_name"]),
    smartButtonLandingPage: json["smart_button_landing_page"] == null ? null : Title.fromJson(json["smart_button_landing_page"]),
    smartButtonPaypalLocale: json["smart_button_paypal_locale"] == null ? null : Title.fromJson(json["smart_button_paypal_locale"]),
    smartButtonAdvancedOptionTitle: json["smart_button_advanced_option_title"] == null ? null : Title.fromJson(json["smart_button_advanced_option_title"]),
    smartButtonInvoicePrefix: json["smart_button_invoice_prefix"] == null ? null : Title.fromJson(json["smart_button_invoice_prefix"]),
    smartButtonPaypalAllowOverride: json["smart_button_paypal_allow_override"] == null ? null : Title.fromJson(json["smart_button_paypal_allow_override"]),
    smartButtonSendShipping: json["smart_button_send_shipping"] == null ? null : Title.fromJson(json["smart_button_send_shipping"]),
    smartButtonSkipReview: json["smart_button_skip_review"] == null ? null : Title.fromJson(json["smart_button_skip_review"]),
    smartButtonSaveCancelledOrder: json["smart_button_save_cancelled_order"] == null ? null : Title.fromJson(json["smart_button_save_cancelled_order"]),
    smartButtonPolicyNotes: json["smart_button_policy_notes"] == null ? null : Title.fromJson(json["smart_button_policy_notes"]),
    logTitle: json["log_title"] == null ? null : Title.fromJson(json["log_title"]),
    paypalLogging: json["paypal_logging"] == null ? null : Title.fromJson(json["paypal_logging"]),
    goLive: json["go_live"] == null ? null : Title.fromJson(json["go_live"]),
    loggingOption: json["logging_option"] == null ? null : Title.fromJson(json["logging_option"]),
    barter: json["barter"] == null ? null : Title.fromJson(json["barter"]),
    webhook: json["webhook"] == null ? null : Title.fromJson(json["webhook"]),
    secretHash: json["secret_hash"] == null ? null : Title.fromJson(json["secret_hash"]),
    testPublicKey: json["test_public_key"] == null ? null : Title.fromJson(json["test_public_key"]),
    testSecretKey: json["test_secret_key"] == null ? null : Title.fromJson(json["test_secret_key"]),
    livePublicKey: json["live_public_key"] == null ? null : Title.fromJson(json["live_public_key"]),
    liveSecretKey: json["live_secret_key"] == null ? null : Title.fromJson(json["live_secret_key"]),
    paymentStyle: json["payment_style"] == null ? null : Title.fromJson(json["payment_style"]),
    paymentOptions: json["payment_options"] == null ? null : Title.fromJson(json["payment_options"]),
    customTitle: json["custom_title"] == null ? null : Title.fromJson(json["custom_title"]),
    customDesc: json["custom_desc"] == null ? null : Title.fromJson(json["custom_desc"]),
    customLogo: json["custom_logo"] == null ? null : Title.fromJson(json["custom_logo"]),
    savedCards: json["saved_cards"] == null ? null : Title.fromJson(json["saved_cards"]),
  );

}

class Title {
  Title({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.titleDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String? id;
  String? label;
  String? description;
  Type? type;
  String? value;
  String? titleDefault;
  String? tip;
  Placeholder? placeholder;
  TitleOptions? options;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    id: json["id"],
    label: json["label"],
    description: json["description"],
    type: typeValues.map![json["type"]],
    value: json["value"],
    titleDefault: json["default"],
    tip: json["tip"],
    placeholder: placeholderValues.map![json["placeholder"]],
    options: json["options"] == null ? null : TitleOptions.fromJson(json["options"]),
  );

}

class TitleOptions {
  TitleOptions({
    this.gold,
    this.blue,
    this.silver,
    this.white,
    this.black,
    this.checkout,
    this.pay,
    this.buynow,
    this.paypal,
    this.vertical,
    this.horizontal,
    this.rect,
    this.pill,
    this.small,
    this.medium,
    this.large,
    this.card,
    this.credit,
    this.bancontact,
    this.blik,
    this.eps,
    this.giropay,
    this.ideal,
    this.mercadopago,
    this.mybank,
    this.p24,
    this.sepa,
    this.sofort,
    this.venmo,
    this.flatRate,
    this.freeShipping,
    this.localPickup,
    this.sandbox,
    this.live,
    this.login,
    this.billing,
    this.empty,
    this.account,
    this.ussd,
    this.qr,
    this.mpesa,
    this.mobilemoneyghana,
    this.inline,
    this.redirect,
    this.sale,
    this.authorization,
    this.responsive,
  });

  String? gold;
  String? blue;
  String? silver;
  String? white;
  String? black;
  String? checkout;
  String? pay;
  String? buynow;
  String? paypal;
  String? vertical;
  String? horizontal;
  String? rect;
  String? pill;
  String? small;
  String? medium;
  String? large;
  String? card;
  String? credit;
  String? bancontact;
  String? blik;
  String? eps;
  String? giropay;
  String? ideal;
  String? mercadopago;
  String? mybank;
  String? p24;
  String? sepa;
  String? sofort;
  String? venmo;
  FlatRate? flatRate;
  FreeShipping? freeShipping;
  LocalPickup? localPickup;
  String? sandbox;
  String? live;
  String? login;
  String? billing;
  String? empty;
  String? account;
  String? ussd;
  String? qr;
  String? mpesa;
  String? mobilemoneyghana;
  String? inline;
  String? redirect;
  String? sale;
  String? authorization;
  String? responsive;

  factory TitleOptions.fromJson(Map<String, dynamic> json) => TitleOptions(
    gold: json["gold"] == null ? null : json["gold"],
    blue: json["blue"] == null ? null : json["blue"],
    silver: json["silver"] == null ? null : json["silver"],
    white: json["white"] == null ? null : json["white"],
    black: json["black"] == null ? null : json["black"],
    checkout: json["checkout"] == null ? null : json["checkout"],
    pay: json["pay"] == null ? null : json["pay"],
    buynow: json["buynow"] == null ? null : json["buynow"],
    paypal: json["paypal"] == null ? null : json["paypal"],
    vertical: json["vertical"] == null ? null : json["vertical"],
    horizontal: json["horizontal"] == null ? null : json["horizontal"],
    rect: json["rect"] == null ? null : json["rect"],
    pill: json["pill"] == null ? null : json["pill"],
    small: json["small"] == null ? null : json["small"],
    medium: json["medium"] == null ? null : json["medium"],
    large: json["large"] == null ? null : json["large"],
    card: json["card"] == null ? null : json["card"],
    credit: json["credit"] == null ? null : json["credit"],
    bancontact: json["bancontact"] == null ? null : json["bancontact"],
    blik: json["blik"] == null ? null : json["blik"],
    eps: json["eps"] == null ? null : json["eps"],
    giropay: json["giropay"] == null ? null : json["giropay"],
    ideal: json["ideal"] == null ? null : json["ideal"],
    mercadopago: json["mercadopago"] == null ? null : json["mercadopago"],
    mybank: json["mybank"] == null ? null : json["mybank"],
    p24: json["p24"] == null ? null : json["p24"],
    sepa: json["sepa"] == null ? null : json["sepa"],
    sofort: json["sofort"] == null ? null : json["sofort"],
    venmo: json["venmo"] == null ? null : json["venmo"],
    flatRate: json["Flat rate"] == null ? null : FlatRate.fromJson(json["Flat rate"]),
    freeShipping: json["Free shipping"] == null ? null : FreeShipping.fromJson(json["Free shipping"]),
    localPickup: json["Local pickup"] == null ? null : LocalPickup.fromJson(json["Local pickup"]),
    sandbox: json["sandbox"] == null ? null : json["sandbox"],
    live: json["live"] == null ? null : json["live"],
    login: json["login"] == null ? null : json["login"],
    billing: json["billing"] == null ? null : json["billing"],
    empty: json[""] == null ? null : json[""],
    account: json["account"] == null ? null : json["account"],
    ussd: json["ussd"] == null ? null : json["ussd"],
    qr: json["qr"] == null ? null : json["qr"],
    mpesa: json["mpesa"] == null ? null : json["mpesa"],
    mobilemoneyghana: json["mobilemoneyghana"] == null ? null : json["mobilemoneyghana"],
    inline: json["inline"] == null ? null : json["inline"],
    redirect: json["redirect"] == null ? null : json["redirect"],
    sale: json["sale"] == null ? null : json["sale"],
    authorization: json["authorization"] == null ? null : json["authorization"],
    responsive: json["responsive"] == null ? null : json["responsive"],
  );

}

class FlatRate {
  FlatRate({
    this.flatRate,
  });

  String? flatRate;

  factory FlatRate.fromJson(Map<String, dynamic> json) => FlatRate(
    flatRate: json["flat_rate"],
  );

}

class FreeShipping {
  FreeShipping({
    this.freeShipping,
  });

  String? freeShipping;

  factory FreeShipping.fromJson(Map<String, dynamic> json) => FreeShipping(
    freeShipping: json["free_shipping"],
  );

}

class LocalPickup {
  LocalPickup({
    this.localPickup,
  });

  String? localPickup;

  factory LocalPickup.fromJson(Map<String, dynamic> json) => LocalPickup(
    localPickup: json["local_pickup"],
  );

}

enum Placeholder { EMPTY, OPTIONAL, YOU_YOUREMAIL_COM, EH }

final placeholderValues = EnumValues({
  "EH_": Placeholder.EH,
  "": Placeholder.EMPTY,
  "Optional": Placeholder.OPTIONAL,
  "you@youremail.com": Placeholder.YOU_YOUREMAIL_COM
});

enum Type { TITLE, CHECKBOX, PASSWORD, TEXT, SELECT, IMAGE, MULTISELECT, EMAIL, TEXTAREA, HIDDEN }

final typeValues = EnumValues({
  "checkbox": Type.CHECKBOX,
  "email": Type.EMAIL,
  "hidden": Type.HIDDEN,
  "image": Type.IMAGE,
  "multiselect": Type.MULTISELECT,
  "password": Type.PASSWORD,
  "select": Type.SELECT,
  "text": Type.TEXT,
  "textarea": Type.TEXTAREA,
  "title": Type.TITLE
});

class ButtonTagline {
  ButtonTagline({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.buttonTaglineDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String? id;
  String? label;
  String? description;
  Type? type;
  String? value;
  bool? buttonTaglineDefault;
  String? tip;
  String? placeholder;
  ButtonTaglineOptions? options;

  factory ButtonTagline.fromJson(Map<String, dynamic> json) => ButtonTagline(
    id: json["id"],
    label: json["label"],
    description: json["description"],
    type: typeValues.map![json["type"]],
    value: json["value"],
    buttonTaglineDefault: json["default"],
    tip: json["tip"],
    placeholder: json["placeholder"],
    options: ButtonTaglineOptions.fromJson(json["options"]),
  );

}

class ButtonTaglineOptions {
  ButtonTaglineOptions({
    this.show,
    this.hide,
  });

  String? show;
  String? hide;

  factory ButtonTaglineOptions.fromJson(Map<String, dynamic> json) => ButtonTaglineOptions(
    show: json["show"],
    hide: json["hide"],
  );

}

class ButtonOnPages {
  ButtonOnPages({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.buttonOnPagesDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String? id;
  String? label;
  String? description;
  Type? type;
  String? value;
  List<String>? buttonOnPagesDefault;
  String? tip;
  String? placeholder;
  CreditButtonOnPagesOptions? options;

  factory ButtonOnPages.fromJson(Map<String, dynamic> json) => ButtonOnPages(
    id: json["id"],
    label: json["label"],
    description: json["description"],
    type: typeValues.map![json["type"]],
    value: json["value"],
    buttonOnPagesDefault: List<String>.from(json["default"].map((x) => x)),
    tip: json["tip"],
    placeholder: json["placeholder"],
    options: CreditButtonOnPagesOptions.fromJson(json["options"]),
  );

}

class CreditButtonOnPagesOptions {
  CreditButtonOnPagesOptions({
    this.cart,
    this.checkout,
  });

  String? cart;
  String? checkout;

  factory CreditButtonOnPagesOptions.fromJson(Map<String, dynamic> json) => CreditButtonOnPagesOptions(
    cart: json["cart"],
    checkout: json["checkout"],
  );

}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) =>  MapEntry(v, k));
    return reverseMap!;
  }
}
