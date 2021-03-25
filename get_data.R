# Script to download images from iNaturalist
library(rinat)
library(sf)

# Function to download images and save them to files
download_images <- function(spp_recs = NULL, image_folder = "images", spp_folder = NULL) {
  dir.create(image_folder, warnings=FALSE)
  if(is.null(spp_recs) | is.null(spp_folder)){
    print("Please set spp_recs and spp_folder")
    return()
  }  
  dir.create(paste0(image_folder, "/", spp_folder))
  for(image in 1:nrow(spp_recs)){
    print(paste("Processing image number...", image))
    spp_url <- spp_recs$image_url[image]
    spp_q <- str_locate(spp_url, "\\?")
    spp_clean <- str_sub(spp_url, 1, spp_q[1]-1)
    if(!is.na(spp_clean)){
      download.file(spp_clean,
                    destfile=paste0(image_folder, "/", spp_folder, "/spp_", image, ".jpg"),
                    method ="libcurl",
                    mode = "wb")
    }
  }
}


# Define geographical region (Great Britain)
gb_ll <- readRDS("gb_simple.RDS")

# Brimstone butterfly
spp_recs1 <- get_inat_obs(taxon_name  = "Gonepteryx rhamni",
                          bounds = gb_ll,
                          quality = "research",
                          # month=6,   # Month can be set.
                          # year=2018, # Year can be set.
                          maxresults = 1000)


# For testing, only download 50 images for some spp, then downlaod 1000
# Cinnabar moth; June records only
spp_recs1 <- get_inat_obs(taxon_name  = "Tyria jacobaeae",
                         bounds = gb_ll,
                         month=6,  # Month can be set.
                         maxresults = 1000)
# Silver Y
spp_recs2 <- get_inat_obs(taxon_name  = "Autographa gamma",
                         bounds = gb_ll,
                         maxresults = 1000)
# Large yellow underwing
spp_recs3 <- get_inat_obs(taxon_name  = "Noctua pronuba",
                          bounds = gb_ll,
                          maxresults = 1000)
# Elephant hawkmoth
spp_recs4 <- get_inat_obs(taxon_name  = "Deilephila elpenor",
                          bounds = gb_ll,
                          maxresults = 1500)
# Angle shades 
spp_recs5 <- get_inat_obs(taxon_name  = "Phlogophora meticulosa",
                          bounds = gb_ll,
                          maxresults = 1000)


download_images(spp_recs = spp_recs1,
                spp_folder = "species_01")
download_images(spp_recs = spp_recs2,
                spp_folder = "species_02")
download_images(spp_recs = spp_recs3,
                spp_folder = "species_03")
download_images(spp_recs = spp_recs4,
                spp_folder = "species_04")
download_images(spp_recs = spp_recs5,
                spp_folder = "species_05")

