page_to_tiff <- function(pdf_file,
                         page_num,
                         out_dir = here::here("data/derived/page-tiffs"),
                         ...) {
  if (!dir.exists(out_dir)) {
    dir.create(out_dir, recursive = TRUE)
  }

  pdftools::pdf_convert(
    pdf_file,
    pages = page_num,
    format = "tiff",
    filenames = file.path(
      out_dir,
      paste0(
        "page_",
        stringi::stri_pad_left(page_num, width = 2, pad = "0"),
        ".tiff"
      )
    ),
    ...
  )
}

extract_raw_card_text <- function(card_tiff) {
  # each page has 20 cards
  cards <- matrix(rep(NA_character_, 20), ncol = 4)
  img <- magick::image_read(card_tiff)

  for (i in seq_len(5)) {
    for (j in seq_len(4)) {
      offset_i <- (600 * (i - 1)) + 70
      offset_j <- (600 * (j - 1)) + 80

      zone <- paste0("600x520+", offset_j, "+", offset_i)

      cards[i, j] <- img |>
        magick::image_crop(zone) |>
        tesseract::ocr() |>
        gsub("\\s", " ", x = _) |>
        trimws()
    }
  }

  data.frame(
    card = as.vector(cards)
  )
}
