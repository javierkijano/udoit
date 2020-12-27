import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

enum SignInProvider { Own, Facebook, Google, Twitter }

class SignIn {
  FacebookLogin facebookSignIn = new FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignIn();

// Example code for sign out.
  Future signOut() async {
    final User user = await _auth.currentUser;
    if (user != null) await _auth.signOut();
  }

  // Example code of how to sign in with email and password.
  void signInWithEmailAndPassword(email, password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      print("${user.email} signed in");
    } catch (e) {
      print("Failed to sign in with Email & Password");
    }
  }

  // Example code of how to sign in with Facebook.
  Future<Null> signInWithFacebook() async {
    String _message = 'Log in/out by pressing the buttons below.';

    Future<Null> _login() async {
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
          break;
        case FacebookLoginStatus.cancelledByUser:
          print('Login cancelled by the user.');
          break;
        case FacebookLoginStatus.error:
          print('Something went wrong with the login process.\n'
              'Here\'s the error Facebook gave us: ${result.errorMessage}');
          break;
      }
    }

    return await _login();
  }

  void webSignUp(SignInProvider signInProvider,
      {String email, String password}) {
    _auth.authStateChanges().listen((event) {
      int a = 0;
      _auth.currentUser;
    });
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {})
        .catchError((onError) {
      int a = 0;
    });
    webSignIn(SignInProvider.Own, email: email, password: password);
    int a = 0;
  }

  void webSignIn(SignInProvider signInProvider,
      {String email, String password}) {
    FirebaseAuth.instance.setPersistence(Persistence.NONE);
    signOut().then((x) {
      FirebaseAuth.instance.setPersistence(Persistence.NONE);

      var provider;
      switch (signInProvider) {
        case SignInProvider.Facebook:
          {
            provider = FacebookAuthProvider();
            provider.addScope('user_birthday');
          }
          break;
        case SignInProvider.Twitter:
          {
            provider = TwitterAuthProvider();
          }
          break;
        case SignInProvider.Google:
          {
            provider = GoogleAuthProvider();
            provider
                .addScope('https://www.googleapis.com/auth/contacts.readonly');
          }
          break;
        default:
          {
            print('method not implemented');
          }
      }
      if (signInProvider == SignInProvider.Own) {
        // loquesea
        _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((user) {
          print('hola');
          return (user);
        }).catchError((error) {
          var errorCode = error.code;
          var errorMessage = error.message;
          print('hola2');
        });
      } else {
        _auth.setLanguageCode('es');
        //_auth.useDeviceLanguage();
        provider.setCustomParameters({
          'lang': 'es',
          'display': 'popup',
          'login_hint': 'user@example.com'
        });

        provider.addScope('public_profile');
        provider.addScope('email');
        provider.addScope('user_birthday');
        provider.addScope('user_about_me');
        provider.addScope('user_work_history');
        provider.addScope('user_education_history');
        provider.addScope('user_age_range');
        provider.addScope('user_friends');
        provider.addScope('user_gender');
        provider.addScope('user_likes');
        provider.addScope('user_link');
        provider.addScope('user_location');

        _auth.signInWithPopup(provider).then((result) {
          var token = result.credential.token;
          var user = result.user;
          String photo = result.user.providerData[0].photoURL +
              '?type=square&width=500&access_token=' +
              result.credential.asMap()['accessToken'];

          user.updateEmail(result.user.providerData[0].email).then((value) {
            int a = 0;
            user.sendEmailVerification().then((vale) {
              int a = 0;
            }).catchError((onError) {
              int a = 0;
            });
          }).catchError((onError) {
            int a = 0;
          });

          /*user.getIdTokenResult().then((value) {
            int a = 0;
          }).catchError((onError) {
            int a = 0;
          });*/
          return user;
        }).catchError((error) {
          var errorCode = error.code;
          var errorMessage = error.message;
          var email = error.email;
          var credential = error.credential;
          return null;
        });
      }
      int a = 0;
    });
  }

  // Example code of how to sign in with Twitter.
  void signInWithTwitter() async {
    /*
    String api_key = '3t1NFkbbdWV14NUN7lp4kcdOw';
    String api_secret_key =
        'YG170XfSarNVlnYikYq7r1rbSyaECSsdiBMTFosFJa7VNbtwhM';
    String bearen_token =
        'AAAAAAAAAAAAAAAAAAAAAAQ9KwEAAAAAhePG2M6sNzkpPf%2Bsq%2BctcaBgluI%3Dd37x2GHG4Wl5pdwvm6tFXoFT1lvY7ZECJGhKnaANyz8si7iCmt';
    String access_token = '1340442745526251525-rhBrmKnytUtclKkgUslENhTAmuS7wH';
    String access_token_secret =
        '0m2mba5YwyCfMJFtr30XGMaBaRwVuo0HVF2GJVItyx9Ex';
        */

    try {
      UserCredential userCredential;

      if (kIsWeb) {
        TwitterAuthProvider twitterProvider = TwitterAuthProvider();
        _auth.setLanguageCode('es');
        //firebase.auth().useDeviceLanguage();
        twitterProvider.setCustomParameters({'lang': 'es'});
        _auth.signInWithPopup(twitterProvider).then((value) {
          var token = value.credential.token;
          var secret = value.credential.providerId;
          // The signed-in user info.
          var user = value.user;
          var user_additional = value.additionalUserInfo;
        }).catchError((error) {
          // Handle Errors here.
          var errorCode = error.code;
          var errorMessage = error.message;
          // The email of the user's account used.
          var email = error.email;
          // The firebase.auth.AuthCredential type that was used.
          var credential = error.credential;
          // ...
        });
      } else {
        /*
        final AuthCredential credential = TwitterAuthProvider.credential(
            accessToken: access_token, secret: access_token_secret);
        userCredential = await _auth.signInWithCredential(credential);
        */
      }

      final user = userCredential.user;

      print("Sign In ${user.uid} with Twitter");
    } catch (e) {
      print(e);
      print("Failed to sign in with Twitter: ${e}");
    }
  }

  //Example code of how to sign in with Google.
  void signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        _auth.setLanguageCode('es');
        //firebase.auth().useDeviceLanguage();
        googleProvider.setCustomParameters({'lang': 'es'});
        _auth.signInWithPopup(googleProvider).then((value) {
          var token = value.credential.token;
          var secret = value.credential.providerId;
          // The signed-in user info.
          var user = value.user;
          var user_additional = value.additionalUserInfo;
        }).catchError((error) {
          // Handle Errors here.
          var errorCode = error.code;
          var errorMessage = error.message;
          // The email of the user's account used.
          var email = error.email;
          // The firebase.auth.AuthCredential type that was used.
          var credential = error.credential;
          // ...
        });
      } else {
        /*
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final GoogleAuthCredential googleAuthCredential =
            GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
        */
      }

      final user = userCredential.user;
      print("Sign In ${user.uid} with Google");
    } catch (e) {
      print(e);

      print("Failed to sign in with Google: ${e}");
    }
  }
}
