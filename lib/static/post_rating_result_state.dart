sealed class PostRatingResultState {}

class PostRatingNoneState extends PostRatingResultState {}

class PostRatingLoadingState extends PostRatingResultState {}

class PostRatingErrorState extends PostRatingResultState {
  final String error;
  
  PostRatingErrorState(this.error);
}

class PostRatingSuccessState extends PostRatingResultState {}