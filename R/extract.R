file_from_url <- function(file, url, ...) {
  if (!file.exists(file)) {
    curl::curl_download(url, file, ...)
  }

  file
}
