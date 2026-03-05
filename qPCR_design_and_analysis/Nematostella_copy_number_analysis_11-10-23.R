## Nematostella copy number stats and plots 11-10-23

#this script is using the qPCR data I generated looking at 8 individuals across 6 populations 
# we want to do statistics on the data and make figures for this 
  
  #We have 2 factors individuals (8/pop, 6 pops) and protien(3), response vairaiale is copy number
    #we want to see if there is a statistical difference between individuals in a population across the protiens 
    #and if there is a location difference across the protiens 


#Set working directory
setwd("/Users/Sydney/Library/CloudStorage/GoogleDrive-sbirch1@uncc.edu/My Drive/Postdoc_work/Immunity_gene_Project/qPCR/Immunity_Runs_Plate_setups/R")

#read in data
copy_num_dat <- read.csv("~/Library/CloudStorage/GoogleDrive-sbirch1@uncc.edu/My Drive/Postdoc_work/Immunity_gene_Project/qPCR/Immunity_Runs_Plate_setups/R/copy_number_dat_11-10-23.csv")
str(copy_num_dat)

#restructure data to factors
copy_num_dat$location<-as.factor(copy_num_dat$location) 
copy_num_dat$sample<-as.factor(copy_num_dat$sample) 
copy_num_dat$protien<-as.factor(copy_num_dat$protien) 
copy_num_dat$individual<-as.factor(copy_num_dat$individual) 
copy_num_dat$Individual_prot<-as.factor(copy_num_dat$Individual_prot) 
str(copy_num_dat)

#two way anova loc * protien
copy_num_mod<-lm(copy_number ~ location*protien, copy_num_dat) 
anova(copy_num_mod)

#Analysis of Variance Table

#Response: copy_number
                  #Df  Sum Sq Mean Sq F value    Pr(>F)    
#location           5 1942.84  388.57 160.474 < 2.2e-16 ***
#protien            2  240.23  120.12  49.606 < 2.2e-16 ***
#location:protien  10 1495.76  149.58  61.773 < 2.2e-16 ***
#Residuals        126  305.09    2.42                      
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


#plot data to see whats going on
boxplot(copy_number ~ location*protien, copy_num_dat, main = "Copy number of pops across coast",
        xlab="location", ylab= "copy_number")


#tukey
library(agricolae)
location_comparison<-HSD.test(copy_num_mod, "location")
#results:
#FL   12.156333      a
#NC    4.515833      b
#ME    2.202333      c
#NH    2.195333      c
#NS    2.116917      c
#MA    1.919292      c

prot_comparison<-HSD.test(copy_num_mod, "protien")
#results:
#TRIM     5.974188      a
#cGAS     3.605229      b
#STING    2.973604      b



#### Making Plots ####

##Making box-plot for each individual prot 

#TRIM subset data
sub_TRIM<- subset(copy_num_dat, copy_num_dat$protien  == "TRIM")

##Fancy boxplot 
library(ggplot2)
#this works - just for fill and out of order
#ggplot(sub_TRIM, aes(x=location, y=copy_number, fill=location)) + geom_boxplot() + geom_jitter(shape=16, position = position_jitter(0.2)) +
#  theme_classic() + 
#  labs(x="Location", y = "copy number") +
#  guides(fill=guide_legend(title="Location Key")) + 
#  theme(axis.text=element_text(size=rel(2)), plot.margin=margin(1.5,1.5,1.5,1.5,"cm"), legend.key.size=unit(1.5,"cm"),
#        axis.title=element_text(size=20),axis.text.x = element_text(angle = 45, hjust=1), legend.text=element_text(size=15), legend.title=element_text(size=17)) +
#  scale_fill_manual(values=c("#FFC125","#FF6A6A","#00CD66","#BFEFFF","#4F94CD","#6959CD"))
str(sub_TRIM)


library(dplyr)
library(ggsignif)
#This works - fancy plot
sub_TRIM %>%
  arrange(copy_number) %>%
  mutate(location=factor(location, levels=c("NS","ME","NH","MA","NC","FL"))) %>%
  ggplot( aes(x=location, y=copy_number, color=location)) + geom_boxplot() + 
  geom_jitter(shape=16, size= 3, position = position_jitter(0.2)) + lims(y = c(0,35)) +
  theme_classic()  + geom_signif(color="black", y_position = c(3,3,3,3,13,26), xmin = c(0.75,1.75,2.75,3.75,4.75,5.75), xmax = c(1.25,2.25,3.25,4.25,5.25,6.25), annotation = c("C","C","C","C","B","A"), tip_length=0) +
  labs(x="Location", y = "copy number", title="TRIM copy number variation" ) +
  guides(fill=guide_legend(title="Location Key")) + 
  theme(plot.title = element_text(size=22),axis.text=element_text(size=rel(2)), legend.key.size=unit(1.5,"cm"),
        axis.title=element_text(size=20),axis.text.x = element_text(angle = 45, hjust=1), 
        legend.text=element_text(size=15), legend.title=element_text(size=17)) +
  scale_color_manual(values=c("#6959CD","#4F94CD","#BFEFFF","#00CD66","#FF6A6A","#FFC125"))

                          
             
#regular box plot
boxplot(copy_number ~ location, sub_TRIM, main = "Copy number of pops across coast - TRIM",
        xlab="location", ylab= "copy_number")

#tukey - TRIM
T_mod<-lm(copy_number ~ location,sub_TRIM)
anova(T_mod)

library(agricolae)
location_comparison_T<-HSD.test(T_mod, "location")
#RESULTS:
#FL   22.499250      a
#NC    8.655375      b
#NH    1.345875      c
#NS    1.208125      c
#ME    1.070125      c
#MA    1.066375      c


#STING subset data
sub_STING<- subset(copy_num_dat, copy_num_dat$protien  == "STING")

#fancy boxplot
library(dplyr)

sub_STING %>%
  arrange(copy_number) %>%
  mutate(location=factor(location, levels=c("NS","ME","NH","MA","NC","FL"))) %>%
  ggplot( aes(x=location, y=copy_number, color=location)) + geom_boxplot() + 
  geom_jitter(shape=16, size= 3, position = position_jitter(0.2)) + lims(y = c(0,35)) +
  theme_classic() + geom_signif(color="black", y_position = c(5,5,5,5,5,6), xmin = c(0.75,1.75,2.75,3.75,4.75,5.75), xmax = c(1.25,2.25,3.25,4.25,5.25,6.25), annotation = c("AB","AB","AB","AB","B","A"), tip_length=0) +
  labs(x="Location", y = "copy number", title="STING copy number variation" ) +
  guides(fill=guide_legend(title="Location Key")) + 
  theme(plot.title = element_text(size=22),axis.text=element_text(size=rel(2)), legend.key.size=unit(1.5,"cm"),
        axis.title=element_text(size=20),axis.text.x = element_text(angle = 45, hjust=1), 
        legend.text=element_text(size=15), legend.title=element_text(size=17)) +
  scale_color_manual(values=c("#6959CD","#4F94CD","#BFEFFF","#00CD66","#FF6A6A","#FFC125"))


#regular boxplot
boxplot(copy_number ~ location, sub_STING, main = "Copy number of pops across coast - STING",
        xlab="location", ylab= "copy_number")

#tukey - STING
S_mod<-lm(copy_number ~ location,sub_STING)
anova(S_mod)

library(agricolae)
location_comparison_S<-HSD.test(S_mod, "location")
#RESULTS:
#FL    3.494500      a
#ME    3.184375     ab
#NH    2.903875     ab
#MA    2.814500     ab
#NS    2.806250     ab
#NC    2.638125      b



#cGAS subset data
sub_cGAS<- subset(copy_num_dat, copy_num_dat$protien  == "cGAS")

#fancy boxplot
library(dplyr)

sub_cGAS %>%
  arrange(copy_number) %>%
  mutate(location=factor(location, levels=c("NS","ME","NH","MA","NC","FL"))) %>%
  ggplot( aes(x=location, y=copy_number, color=location)) + geom_boxplot() + 
  geom_jitter(shape=16, size= 3, position = position_jitter(0.2)) + lims(y = c(0,35)) +
  theme_classic() + geom_signif(color="black", y_position = c(4,4,4,4,6,13), xmin = c(0.75,1.75,2.75,3.75,4.75,5.75), xmax = c(1.25,2.25,3.25,4.25,5.25,6.25), annotation = c("B","B","B","B","B","A"), tip_length=0) +
  labs(x="Location", y = "copy number", title="cGAS copy number variation" ) +
  guides(fill=guide_legend(title="Location Key")) + 
  theme(plot.title = element_text(size=22),axis.text=element_text(size=rel(2)), legend.key.size=unit(1.5,"cm"),
        axis.title=element_text(size=20),axis.text.x = element_text(angle = 45, hjust=1), 
        legend.text=element_text(size=15), legend.title=element_text(size=17)) +
  scale_color_manual(values=c("#6959CD","#4F94CD","#BFEFFF","#00CD66","#FF6A6A","#FFC125"))

#regular boxplot
boxplot(copy_number ~ location, sub_cGAS, main = "Copy number of pops across coast - cGAS",
        xlab="location", ylab= "copy_number")

#tukey - cGAS
cG_mod<-lm(copy_number ~ location,sub_cGAS)
anova(cG_mod)

library(agricolae)
location_comparison_cG<-HSD.test(cG_mod, "location")
#RESULTS:
#FL   10.475250      a
#ME    2.352500      b
#NS    2.336375      b
#NH    2.336250      b
#NC    2.254000      b
#MA    1.877000      b




## combining box plots together ##

#set scales
copy_num_dat %>%
  arrange(copy_number) %>%
  mutate(location=factor(location, levels=c("NS","ME","NH","MA","NC","FL"))) %>%
  ggplot( aes(x=location, y=copy_number, color=location)) + geom_boxplot() + lims(y = c(0,36)) +
  geom_jitter(shape=16, size= 3, position = position_jitter(0.2)) + facet_wrap(~protien, scale="free")+
  labs(x="Location", y = "Copy Number", title="Copy Number Variation for TRIM, STING, and cGAS" ) +
  guides(fill=guide_legend(title="Location Key")) + 
  theme(plot.title = element_text(size=22),axis.text=element_text(size=rel(2)), legend.key.size=unit(1.5,"cm"),
        axis.title=element_text(size=20),axis.text.x = element_text(angle = 45, hjust=1), 
        legend.text=element_text(size=15), legend.title=element_text(size=17)) +
  scale_color_manual(values=c("#6959CD","#4F94CD","#BFEFFF","#00CD66","#FF6A6A","#FFC125"))

#normal - individual scales
copy_num_dat %>%
  arrange(copy_number) %>%
  mutate(location=factor(location, levels=c("NS","ME","NH","MA","NC","FL"))) %>%
  ggplot( aes(x=location, y=copy_number, color=location)) + geom_boxplot()  +
  geom_jitter(shape=16, size= 3, position = position_jitter(0.2)) + facet_wrap(~protien, scale="free")+
  labs(x="Location", y = "Copy Number", title="Copy Number Variation for TRIM, STING, and cGAS" ) +
  guides(fill=guide_legend(title="Location Key")) + 
  theme(plot.title = element_text(size=22),axis.text=element_text(size=rel(2)), legend.key.size=unit(1.5,"cm"),
        axis.title=element_text(size=20),axis.text.x = element_text(angle = 45, hjust=1), 
        legend.text=element_text(size=15), legend.title=element_text(size=17)) +
  scale_color_manual(values=c("#6959CD","#4F94CD","#BFEFFF","#00CD66","#FF6A6A","#FFC125"))

#start y axis at 0, continous for each fig 
copy_num_dat %>%
  arrange(copy_number) %>%
  mutate(location=factor(location, levels=c("NS","ME","NH","MA","NC","FL"))) %>%
  ggplot( aes(x=location, y=copy_number, color=location)) + geom_boxplot() + expand_limits(y=0) +
  geom_jitter(shape=16, size= 3, position = position_jitter(0.2)) + facet_wrap(~protien, scale="free")+
  labs(x="Location", y = "Copy Number", title="Copy Number Variation for TRIM, STING, and cGAS" ) +
  guides(fill=guide_legend(title="Location Key")) + 
  theme(plot.title = element_text(size=22),axis.text=element_text(size=rel(2)), legend.key.size=unit(1.5,"cm"),
        axis.title=element_text(size=20),axis.text.x = element_text(angle = 45, hjust=1), 
        legend.text=element_text(size=15), legend.title=element_text(size=17)) +
  scale_color_manual(values=c("#6959CD","#4F94CD","#BFEFFF","#00CD66","#FF6A6A","#FFC125"))


#tried adding sig annotation to boxplots - it adds all in each protein (all 12 in cGAS, STING, TRIM)
#geom_signif(color="black", y_position = c(4,4,4,4,6,13,5,5,5,5,5,6,3,3,3,3,13,26), 
#            xmin = c(0.5,1.5,2.5,3.5,4.5,5.5,6.5,7.5,8.5,9.5,10.5,11.5,12.5,12.5,12.5,12.5,12.5,12.5), 
#            xmax = c(0.75,1.75,2.75,3.75,4.75,5.75,6.75,7.75,8.75,9.75,10.75,11.75,12.75,12.75,12.75,12.75,12.75,12.75), 
#            annotation = c("B","B","B","B","B","A","AB","AB","AB","AB","B","A","C","C","C","C","B","A"), tip_length=0) +


## Bubble Plots

#first import buble plot data sheet
bubble_dat <- read.csv("~/Library/CloudStorage/GoogleDrive-sbirch1@uncc.edu/My Drive/Postdoc_work/Immunity_gene_Project/qPCR/Immunity_Runs_Plate_setups/R/copy_number-bubble_dat_11-10-23.csv")

#check structure
str(bubble_dat)

#convert data frame from a "wide" format to a "long" format
library(reshape2)
bubble_dat_m = melt(bubble_dat, id ="Individual_prot")
str(bubble_dat_m)

#pick colors
#6959CD (slateblue3 NS 
#4F94CD (steelblue3) ME
#BFEFFF (lightblue1) NH
#00CD66 (springgreen3) MA
#FF6A6A (indianred1) NC
#FFC125 (goldenrod1) FL

colours=c("#6959CD","#4F94CD","#BFEFFF","#00CD66","#FF6A6A","#FFC125")

#keep the order of samples from excel sheet
#bubble_dat_m<- factor(bubble_dat_m$Individual_prot, levels=unique(bubble_dat_m$Individual_prot))
#str(bubble_dat_m)

#plot
library(ggplot2)
xx = ggplot(bubble_dat_m, aes(x = Individual_prot, y = variable)) + 
  geom_point(aes(size = value, fill = variable), alpha = 0.75, shape = 21) + 
  scale_size_continuous(limits = c(NULL), range = c(1,40), breaks = c(1,5,10,20,35)) + 
  labs( x= "Individual_Protien", y = "Location", size = "Relative Abundance (%)", fill = "Location")  + 
  theme(legend.key=element_blank(), 
        axis.text.x = element_text(colour = "black", size = 12, face = "bold", angle = 90, vjust = 0.3, hjust = 1), 
        axis.text.y = element_text(colour = "black", face = "bold", size = 11), 
        legend.text = element_text(size = 10, face ="bold", colour ="black"), 
        legend.title = element_text(size = 12, face = "bold"), 
        panel.background = element_blank(), panel.border = element_rect(colour = "black", fill = NA, size = 1.2), 
        legend.position = "right") +  
  scale_fill_manual(values = colours, guide = FALSE) + 
  scale_y_discrete(limits = rev(levels(bubble_dat_m$variable))) 

xx
