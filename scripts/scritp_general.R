### 3. Configure git with Rstudio ############################################

## set your user name and email:
usethis::use_git_config(user.name = "Beth Nyboer", user.email = "b.a.nyboer@gmail.com")

## create a personal access token for authentication:
usethis::create_github_token() 
## in case usethis version < 2.0.0: usethis::browse_github_token() (or even better: update usethis!)

## set personal access token:
credentials::set_github_pat("YourPAT")

## or store it manually in '.Renviron':
usethis::edit_r_environ()
## store your personal access token with: GITHUB_PAT=xxxyyyzzz
## and make sure '.Renviron' ends with a newline




# # Packages --------------- ----------------------------------------------

##bringing in external data
install.packages('remotes') # for installing packages from sources that aren't CRAN
library(remotes) # load the package

install_github("allisonhorst/palmerpenguins") #installing development version of dataset
library(palmerpenguins) # loading the package which contains dataset we will use

install.packages('tidyverse')
library(tidyverse) # loading tidyverse package for ggplot etc.

install.packages ('ggplot2')
library(ggplot2)

# # session info ----------------------------------------------------------

sessionInfo()

#copy output in to script control alt and arrow down to add hashtags
# R version 4.0.3 (2020-10-10)
#Platform: x86_64-w64-mingw32/x64 (64-bit)
#Running under: Windows 10 x64 (build 22000)

#Matrix products: default

#locale:
 # [1] LC_COLLATE=English_Canada.1252  LC_CTYPE=English_Canada.1252   
#[3] LC_MONETARY=English_Canada.1252 LC_NUMERIC=C                   
#[5] LC_TIME=English_Canada.1252    

#attached base packages:
 # [1] stats     graphics  grDevices utils     datasets  methods   base     

#loaded via a namespace (and not attached):
 # [1] compiler_4.0.3   assertthat_0.2.1 cli_3.2.0        tools_4.0.3      glue_1.4.2      


# create data -------------------------------------------------------------

data(penguins, package = "palmerpenguins")

write.csv(penguins_raw, "raw_data_1/penguins_raw.csv", row.names = FALSE)

write.csv(penguins,"Data/penguins.csv",row.names = FALSE)


# load data ---------------------------------------------------------------

pen.data <- read.csv("Data/penguins.csv")

str(pen.data) # look at data types (e.g., factor, character)
colnames(pen.data) # look at the column names

# check for bullshit
head(pen.data) # first few rows of the start of the data
tail(pen.data) # last few rows at the end

# [row, column] and we want columns 3:6 and 8 which are the numeric variables
?pairs # will give you information about the function
pairs(pen.data[,c(3:6,8)]) # pairwise correlation plot of numeric columns

hist(pen.data$body_mass_g)  # make a histogram    
?hist # will give you information about the function

boxplot(pen.data$body_mass_g ~ pen.data$species) # boxplot of body mass x species
?boxplot # will give you information about the function


# save boxplot as pdf -----------------------------------------------------


pdf("outputs/wt_by_spp.pdf",
    width = 7,
    height = 5) # open a graphics device (everything you print to the screen while this is open will be saved to the file name that you give here), there are analogous functions for png and other image types


boxplot(pen.data$body_mass_g ~ pen.data$species,
        xlab="Species", ylab="Body Mass (g)") # print the boxplot to the pdf file


dev.off() #close the graphics device (very important to run this line or the pdf won’t save and will continue to add new plots that you run afterwards)

  

# ggplot figure -----------------------------------------------------------

pen_fig <- pen.data %>% # calling on the data
  drop_na() %>%  # dropping "NAs" from the plot
  ggplot(aes(y = body_mass_g, x = sex, # aesthetic: y = body mass, x = sex
             colour = sex)) + # colour violin plots by sex
  facet_wrap(~species) + # each species will have it's own plot
  geom_violin(trim = FALSE, # violin plot, turn off trim the edges
              lwd = 1) + # make the lines thick
  theme_bw() + # black and white background theme
  theme(text = element_text(size = 12), # change the text size
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 12),
        strip.text = element_text(size=12),
        legend.position = "none") + # remove the legend
  labs(y = "Body Mass (g)", # specify labels on axes
       x = " ") +
  scale_colour_manual(values = c("black", "darkgrey"))

pen_fig

  library(dplyr)
  library(ggplot)
library(tidyr)

##change
pdf("outputs/wt_by_spp.pdf",
    width = 7,
    height = 5) # open a graphics device (everything you print to the screen while this is open will be saved to the file name that you give here), there are analogous functions for png and other image types


boxplot(pen.data$body_mass_g ~ pen.data$species,
        xlab="Species", ylab="Body Mass (g)") # print the boxplot to the pdf file


dev.off() #close the graphics device (very important to run this line or the pdf won’t save and will continue to add new plots that you run afterwards)

