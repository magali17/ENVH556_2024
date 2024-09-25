
####################################################################################################################
# download & read in csv or rda file from the internet
####################################################################################################################
download_and_read_file <- function(data_url, output_file_path) {
  
  # Check if the file already exists in the specified path
  if (!file.exists(output_file_path)) {
    # If the file doesn't exist, download it 
    download.file(data_url, destfile = output_file_path, method = "auto")
    message("File downloaded successfully.")
  } else {
    message("File already exists in the directory.")
  }
  
  # Automatically detect file type based on the file extension
  file_ext <- tolower(tools::file_ext(output_file_path))
  
  message("Reading in file.")
  # read in file
  if (file_ext == "csv") {
    data <- read.csv(output_file_path)
  } else if (file_ext %in% c("rds", "rda")) {
    data <- readRDS(output_file_path)
  } else {
    stop(paste("Unsupported file type:", file_ext, ". Please handle manually."))
  }
  
  return(data)
}

####################################################################################################################
#  
####################################################################################################################

