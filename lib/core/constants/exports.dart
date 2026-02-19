library;

export 'dart:async';
export 'dart:convert';

/// Flutter Imports
export 'dart:io';
export 'dart:math';
export 'package:flutter/material.dart';

/// Packages Imports
export 'package:provider/provider.dart';
export 'package:go_router/go_router.dart';
export 'package:google_fonts/google_fonts.dart';

/// Config
///-- Router
export 'package:mini_products_listing_app/config/router/app_router.dart';
export 'package:mini_products_listing_app/config/router/route_names.dart';

///-- Theme
export 'package:mini_products_listing_app/config/theme/text_styles.dart';
export 'package:mini_products_listing_app/config/theme/app_theme.dart';

/// Core
///-- Constants
export 'package:mini_products_listing_app/core/constants/exports.dart';
export 'package:mini_products_listing_app/core/enums/product_list_status.dart';
export 'package:mini_products_listing_app/core/arguments/product_detail_args.dart';
export 'package:mini_products_listing_app/core/error/failures.dart';
export 'package:mini_products_listing_app/core/constants/global_variables.dart';

///-- Use Cases
export 'package:mini_products_listing_app/core/use_case/use_case.dart';

///-- Resources
export 'package:mini_products_listing_app/core/constants/constants_resource.dart';
export 'package:mini_products_listing_app/core/constants/strings_resource.dart';

///-- Models
export 'package:mini_products_listing_app/app/product/data/models/product_model.dart';
export 'package:mini_products_listing_app/app/product/data/models/card_item_model.dart';

///-- providers
export 'package:mini_products_listing_app/app/product/presentation/providers/product_list_provider.dart';
export 'package:mini_products_listing_app/app/product/presentation/providers/cart_provider.dart';

///-- usecases
export 'package:mini_products_listing_app/app/product/domain/usecases/get_products_use_case.dart';

///-- widgets
export 'package:mini_products_listing_app/app/product/presentation/widgets/cart_item_widget.dart';
export 'package:mini_products_listing_app/app/product/presentation/widgets/product_card_widget.dart';
export 'package:mini_products_listing_app/app/product/presentation/widgets/text_view_widget.dart';

///-- presentation
export 'package:mini_products_listing_app/app/product/presentation/pages/cart_page.dart';
export 'package:mini_products_listing_app/app/product/presentation/pages/product_detail_page.dart';
export 'package:mini_products_listing_app/app/product/presentation/pages/product_list_page.dart';

///-- domain
///--- entities
export 'package:mini_products_listing_app/app/product/domain/entities/product_entity.dart';

///-- Utils
export 'package:mini_products_listing_app/core/utils/injector.dart';
