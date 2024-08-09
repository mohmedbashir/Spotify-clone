import 'package:firebase_auth/firebase_auth.dart';

String handleFirebaseAuthError(FirebaseAuthException e) {
  String message;

  switch (e.code) {
    case 'invalid-email':
      message = 'The email address you entered is invalid.';
      break;
    case 'user-not-found':
      message =
          'No user found for that email. Please check your email address or create an account.';
      break;
    case 'wrong-password':
      message = 'The password you entered is incorrect. Please try again.';
      break;
    case 'weak-password':
      message =
          'The password you entered is too weak. Please choose a stronger password.';
      break;
    case 'email-already-in-use':
      message =
          'The email address you entered is already in use by another account.';
      break;
    case 'account-exists-with-different-credential':
      message =
          'An account already exists with the same email address but different sign-in credentials. Sign in using a different method or reset your password.';
      break;
    case 'invalid-credential':
      // Handle cases where credentials might be invalid (e.g., expired token)
      message =
          'The email address or password is wrong, or both. Please try again.';
      break;
    case 'network-request-failed':
      message =
          'There was a network error. Please check your internet connection and try again.';
      break;
    case 'invalid-app-id':
      // Handle incorrect app ID (less likely in development)
      message = 'An internal error has occurred. Please contact support.';
      break;
    case 'invalid-user-token':
      // Handle expired or invalid user tokens
      message = 'Your session has expired. Please sign in again.';
      break;
    case 'too-many-requests':
      message =
          'Too many sign-in attempts in a short time. Please try again later.';
      break;
    case 'operation-not-allowed':
      // Handle disabled authentication methods
      message = 'This sign-in method is not enabled for this project.';
      break;
    default:
      message = 'An unknown error occurred. Please try again later.';
  }

  return message;
}
