library(targets)
library(tarchetypes)
library(crew)

# Reference for renv scan
languageserver::run

source(here::here("projects/prelude.R"))

if (parallel::detectCores() > 2) {
  tar_option_set(
    controller = crew_controller_local(
      workers = max(parallel::detectCores() - 1, 1),
      local_log_directory = here::here("_logs")
    ),
  )
}

rlang::list2(
  # ------ 0. Extract ------
  tar_file(
    raw_cah_pdf,
    file_from_url(
      file = here::here("data/raw/cah.pdf"),
      url = "https://cdn.sanity.io/files/vc07edlh/production/92c8ddb62ec852fdb1b3f0d2bbb9c82ce881bed2.pdf"
    )
  ),
  # ------ 1. Transform ------
  tar_target(
    cah_page_nums,
    seq_len(pdftools::pdf_length(raw_cah_pdf) - 2) + 1
  ),
  tar_target(
    cah_page_tiffs,
    page_to_tiff(raw_cah_pdf, cah_page_nums, dpi = 300),
    pattern = map(cah_page_nums)
  ),
  # First 5 pages are black cards, no mixing thankfully
  tar_target(
    black_card_tiffs,
    cah_page_tiffs |>
      sort() |>
      head(n = 6)
  ),
  tar_target(
    white_card_tiffs,
    setdiff(cah_page_tiffs, black_card_tiffs)
  ),
  # TODO: Collate the weird symbols (e.g. |) into normal text
  tar_target(
    white_card_raw_text,
    extract_raw_card_text(white_card_tiffs),
    pattern = map(white_card_tiffs)
  ),
)
