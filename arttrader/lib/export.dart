export 'core/constants/strings.dart';
export 'core/exceptions/route_exception.dart';
export 'core/themes/app_theme.dart';
export 'core/utils/utils.dart';
export 'core/utils/network_helper.dart';
export 'core/utils/snackbar_helper.dart';

export 'data/data_providers/app.dart';
export 'data/data_providers/bloc/app_bloc.dart';
export 'data/data_providers/bloc/conectivity_bloc.dart';
export 'data/repositories/Authentication/authentication.dart';
export 'data/repositories/Art/art_repository.dart';
export 'data/repositories/Cache/cache.dart';
export 'presentation/router/routes/routes.dart';

//Pages
export 'presentation/screens/add/add_page.dart';
export 'presentation/screens/add/extension/xfile_extension.dart';
export 'presentation/screens/add/add_art_form.dart';
export 'presentation/screens/add/widgets/art_camera.dart';

export 'presentation/screens/bids/bids_page.dart';
export 'presentation/screens/details/details.dart';
export 'presentation/screens/home/home.dart';
export 'presentation/screens/home/widgets/custom_bottom_bar.dart';
export 'presentation/screens/login/view/login_view.dart';
export 'presentation/screens/login/view/login_form.dart';
export 'presentation/screens/search/search_page.dart';
export 'presentation/screens/settings/settings_page.dart';
export 'presentation/screens/settings/widgets/settings_section.dart';
export 'presentation/screens/signup/view/sign_up_page.dart';
export 'presentation/screens/signup/view/sign_up.form.dart';

export 'presentation/router/routes/widget/page_widget.dart';
//Bloc
export 'presentation/screens/home/bloc/art_bloc.dart';
export 'presentation/screens/add/cubit/add_art_cubit.dart';
export 'presentation/screens/add/bloc/camera_bloc.dart';
export 'presentation/screens/home/bloc/art_state.dart';

export 'presentation/screens/signup/cubit/sign_up_cubit.dart';
export 'presentation/screens/login/cubit/login_cubit.dart';
export 'presentation/screens/login/cubit/login_state.dart';

//Models
export 'data/models/art/art.dart';
export 'data/models/art/bid.dart';
export 'data/models/art/name.dart';
export 'data/models/art/price.dart';
export 'data/models/login/email.dart';
export 'data/models/login/password.dart';
export 'data/models/login/password_confirmed.dart';
export 'data/models/user/user.dart';

//Packages
export 'package:formz/formz.dart';
export 'package:equatable/equatable.dart';
export 'package:bloc/bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
//export 'package:fpdart/fpdart.dart' hide Order;
export 'package:image_picker/image_picker.dart';
export 'package:camera/camera.dart';
export 'package:flow_builder/flow_builder.dart';
export 'firebase_options.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:carousel_slider/carousel_slider.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:connectivity_plus/connectivity_plus.dart';



//other
export 'dart:typed_data';
export 'dart:async';
export 'dart:convert';
export 'package:flutter/material.dart';
export 'l10n/l10n.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';
