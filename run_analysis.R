#=================================================================================
#The function below builds the data frame for all the files needed
# and lumps the data frame into a list
# it takes three parameters(path for feature file,directory for train or test
# and indicator to specify whether training or test set is going to be read)
#================================================================================

setup_DF<-function(feature_path,infile_data,dataset_type="train"){
  if (!file.exists(feature_path)){
    stop("Invalid path for the feature file")
  }
  else {
   feature<-read.table(feature_path,header=F,stringsAsFactors=F)
  }
  if (!file.exists(infile_data)){
    stop("Invalid path for data path")
  }
  setwd(infile_data)
  getfiles<-list.files()[grep(dataset_type,list.files())]
  cat("Data frames are going to be created from these files", getfiles,"\n" )
  if(dataset_type=="train")
    {
    subject_train<-read.table("subject_train.txt",header=F,stringsAsFactors=F)
    X_train<-read.table("X_train.txt",header=F,stringsAsFactors=F)
    y_train<-read.table("y_train.txt",header=F,stringsAsFactors=F)
    return(alltrain<-list(subject_train,y_train, X_train,feature))
  } 
  else{
    subject_test<-read.table("subject_test.txt",header=F,stringsAsFactors=F)
    X_test<-read.table("X_test.txt",header=F,stringsAsFactors=F)
    y_test<-read.table("y_test.txt",header=F,stringsAsFactors=F)
    return(alltest<-list( subject_test,y_test, X_test,feature))
  }

}
#============================================================
#create a list to store data frames for both test & train
#make change the parameters for the function call below
#That is all you need for this code to run.
#============================================================
list.train<-setup_DF("your path/features.txt",
             "C:/your path/train")
list.test<-setup_DF("your path/features.txt",
                    "your path/test",
                    dataset_type="test")
  
prep_data<-function(list.data){
  #Prep the columns for all the dataset
  list.data[[4]]<-list.data[[4]][,2]
  names(list.data[[3]])[1:length(list.data[[4]])]<-list.data[[4]]
  list.data[[3]]<-list.data[[3]][,c(grep("\\-mean\\(|\\-std\\(",list.data[[4]]))]
  names(list.data[[1]])<-"SUB_ID"
  names(list.data[[2]])<-"ACTIVITY"
  return(do.call("cbind",list.data[1:3]))
}

#Create data frame for train
alltrain<-prep_data(list.train)
#remove tain list to conserve memory
rm(list.train)
#Create data frame for train
alltest<-prep_data(list.test)
#remove tain list to conserve memory
rm(list.test)
#combine datasets train and test
detail.Data<-rbind(alltrain,alltest)
#remove all dataframes to free memory
rm(alltrain,alltest)

#=======================================
#Build a list and create averages 
#for each activity as a data frame
#=======================================
temp.data<-list()
for(i in 1:6){
  temp.data[[i]]<-ddply(detail.Data,.(SUB_ID),function(x){tmp<-sapply(x[x$ACTIVITY==i,],mean)})
}

#Combind data frames
Summary.data<-do.call("rbind",temp.data)
rm(temp.data,detail.Data)

#Add the labels of the activities
Summary.data$label<-ifelse(Summary.data$ACTIVITY==1,"WALKING",
                             ifelse(Summary.data$ACTIVITY==2,"WALKING_UPSTAIRS",
                             ifelse(Summary.data$ACTIVITY==3,"WALKING_DOWNSTAIRS",
                             ifelse(Summary.data$ACTIVITY==4,"SITTING",
                             ifelse(Summary.data$ACTIVITY==5,"STANDING","LAYING")))))

write.table(Summary.data,"C:/Users/Administrator/Desktop/Sample Data/UCI HAR Dataset/summary.txt",
            ,col.names=T)
