class ApiResult<E, T> {
  E? failure;
  T? success;

  ApiResult.error(this.failure);
  ApiResult.success(this.success);

  void when<R>(
      {required R Function(T data) success,
      required void Function(E error) failure}) {
    if (this.success != null)
      success(this.success!);
    else if (this.failure != null) failure(this.failure!);
  }
}
