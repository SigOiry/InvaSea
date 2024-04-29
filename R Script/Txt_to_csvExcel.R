library(tidyverse)
library(readxl)


#### Make list of each spectra file .txt

filenames <- list.files("Data/TXT", pattern = ".txt", full.names = T)


for(i in 1:length(filenames)){
  
  print(paste0(i,"/",length(filenames)))
  
  sp <- read_delim(filenames[i], 
                   delim = "\t", escape_double = FALSE, 
                   locale = locale(decimal_mark = ","), 
                   trim_ws = TRUE)
  
  if(i == 1){
    
    output <- sp
    
  }else{
    
    output <- output %>% 
      left_join(sp, by = "Wavelength")
  }
}

write_delim(output,"Data/CSV/all_spectra.csv")
