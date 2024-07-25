# Cards Against Humanity Scraper

Little utility to scrape the CAH deck for a project I'm working on.

## Setup

This project uses `renv` to manage its dependencies, so installing them is as simple as:

```r
renv::restore()
```

No external (outside of R) dependencies are required.

## Run

To run the scraper, execute

```r
targets::tar_make()
```

# Licenses

Cards Against Humanity is free to use under the Creative Commons BY-NC-SA 2.0 License. You can read more about the license at: [http://creativecommons.org/licenses/by-nc-sa/2.0/](http://creativecommons.org/licenses/by-nc-sa/2.0/).
