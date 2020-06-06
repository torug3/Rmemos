library(tidyverse)

file_list <- list.files("demodata", pattern = "\\.xlsx$")
datafinal <- tibble()

#By using "for loop"

for (tgtfile in file_list){
  #Show in processing
  print(str_c("Processing:", tgtfile))
  #Create path of taeget file
  tgtfile_path <- file.path("demodata",tgtfile)
  #Read excel
  data <- readxl::read_xlsx(tgtfile_path)
  #Copy the processed file to "done" folder
  file.copy(from = tgtfile_path,
            to = file.path("demodata/done", tgtfile))
  #Remove processed file
  file.remove(tgtfile_path)
  #Bind each file
  datafinal <- bind_rows(datafinal, data)
}


#By using "map"

file_list <- list.files("demodata", pattern = "\\.xlsx$")
datafinal <- tibble()

datafinal <- 
map_df(file_list[1:3], ~{
  tgtfile <-.
  print(str_c("Processing:", tgtfile))
  #Create path of taeget file
  tgtfile_path <- file.path("demodata",tgtfile)
  #Read excel
  data <- readxl::read_xlsx(tgtfile_path)
  # #Copy the processed file to "done" folder
  # file.copy(from = tgtfile_path,
  #           to = file.path("demodata/done", tgtfile))
  # #Remove processed file
  # file.remove(tgtfile_path)
  #Bind each file
  # datafinal <- bind_rows(datafinal, data)
})


#Measure processing time -start
start_time <- proc.time()

#Measure processing time -end
end_time <- proc.time() 

start_time - end_time



#for loop 
target <- "dog"
for (i in 1:10){
  target <- i
}
print(target)


#purrr map
#map returns list
target <- "dog"
map(1:10, ~{target <-.})
print(target)

map(1:3, print)
walk(1:3, print)
reduce(1:3, print)

reduce(1:10, ~{c(.x, .y)})

val <- list(c(1,2,3), c(100,200,300), c(123,456,789))
map(val, mean)
map_dbl(val, mean)


singlerow <- tibble(name="one", number=c(1,2,3))
map(1:5, ~{singlerow}) %>% bind_rows()
