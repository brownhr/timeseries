update_exercise <- function(){
  rmarkdown::render("05-final-exercise.Rmd", output_format = "word_document")
  file <- googledrive::drive_get(id = "1iy2qe-O5EPGORAQrBQ0rYRhmVG-ISM6GRbhhXR4ePQY")
  googledrive::drive_update(file = file, media = "05-final-exercise.docx")
}
