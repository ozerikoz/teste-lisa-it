import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:teste_lisa_it/data/repositories/auth/auth_repository.dart';
import 'package:teste_lisa_it/data/repositories/auth/firebase_auth_repository.dart';
import 'package:teste_lisa_it/data/repositories/post_users/firestore_post_users_repository.dart';
import 'package:teste_lisa_it/data/repositories/post_users/post_users_repository.dart';
import 'package:teste_lisa_it/data/repositories/posts/jsonplaceholder_repository.dart';
import 'package:teste_lisa_it/data/repositories/posts/posts_repository.dart';
import 'package:teste_lisa_it/data/services/api/api_client.dart';
import 'package:teste_lisa_it/data/services/api/dio_api_client.dart';
import 'package:teste_lisa_it/data/services/api/posts/jsonplaceholder_posts_api_service.dart';
import 'package:teste_lisa_it/data/services/auth/firebase_auth_service.dart';
import 'package:teste_lisa_it/data/services/db/firestore_service.dart';

/// List of services and repositories dependencies
List<SingleChildWidget> get dependencies {
  return [
    // Firebase auth
    Provider(create: (_) => FirebaseAuth.instance),
    // Firebase firestore
    Provider(create: (_) => FirebaseFirestore.instance),
    // Firebase auth service
    Provider(
      create: (context) => FirebaseAuthService(
        firebaseAuth: context.read(),
      ),
    ),
    // ApiClient
    Provider(
      create: (context) => DioApiClient() as ApiClient,
    ),
    // JsonPlaceholderPostsApiService
    Provider(
      create: (context) => JsonPlaceholderPostsApiService(
        apiClient: context.read(),
      ),
    ),
    // FirestoreService
    Provider(
      create: (context) => FirestoreService(
        firestore: context.read(),
      ),
    ),
    // PostUsersRepository
    Provider(
      create: (context) => FirebaseAuthRepository(
        firebaseAuthService: context.read(),
      ) as AuthRepository,
    ),
    // PostsUsersRepository
    Provider(
      create: (context) => FirestorePostUsersRepository(
        firestoreService: context.read(),
      ) as PostUsersRepository,
    ),
    // PostsRepository
    Provider(
      create: (context) => JsonplaceholderPostsRepository(
        postsApiService: context.read(),
      ) as PostsRepository,
    ),
  ];
}
