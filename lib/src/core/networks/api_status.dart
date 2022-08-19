class ApiStatus<T> {
  Status status;
  T? data;
  String? message;

  ApiStatus.loading(this.message) : status = Status.LOADING;
  ApiStatus.completed(this.data) : status = Status.COMPLETED;
  ApiStatus.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }