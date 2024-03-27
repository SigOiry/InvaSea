library(rstudioapi)
library(tidyverse)
library(readxl)


#### Make list of each spectra file .txt

filenames <- list.files(selectDirectory(), pattern = ".txt", full.names = T)


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

write_delim(output,"F:/Spectra_Gracilaria/CSV/all_spectra.csv")


df <- output %>% 
  pivot_longer(-Wavelength, values_to = "values", names_to = "name") %>% 
  mutate(names_station = gsub(".asd","",name) %>% 
           gsub('[[:digit:]]+',"",.))


df2 <- df %>% 
  filter(names_station == "GRA-BER") %>% 
  pivot_wider(values_from = "values",names_from = "name")

write.csv(df2, "F:/Spectra_Gracilaria/CSV/GRA_BER.csv")
