#Declaring data Sources
zipName<-"DataZip.zip"
UnzipFolder<-"UCI HAR Dataset"
DURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#Downloading and unzipping (if not done already)
if(!file.exists(zipName))
  download.file(DURL,zipName)
if(!file.exists(UnzipFolder))
  unzip(zipName)

#Step 1 : Loading and Combining train and test sets

trainSet<-read.table("UCI HAR Dataset/train/X_train.txt")
trainSetLabels<-read.table("UCI HAR Dataset/train/y_train.txt")
trainsubjectLabels<-read.table("UCI HAR Dataset/train/subject_train.txt")
trainTable<-cbind(trainSet,trainSetLabels,trainsubjectLabels)

testSet<-read.table("UCI HAR Dataset/test/X_test.txt")
testSetLabels<-read.table("UCI HAR Dataset/test/y_test.txt")
testsubjectLabels<-read.table("UCI HAR Dataset/test/subject_test.txt")
testTable<-cbind(testSet,testSetLabels,testsubjectLabels)

combinedSet<-rbind(trainTable,testTable)

#Step 2 & 4 : Seperating only mean and stdev features. This is to be done by checking the feature names as 
#mentioned in feature_info.txt 
featureNames<-read.table("UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)
onlyMeanStd<-grepl(".*std.*|.*mean.*",featureNames[[2]])
wantedColumns<-c(onlyMeanStd,TRUE,TRUE)                          #To keep ylabels and subject labels when filtering
wantedNames<-c(featureNames[[2]],"activityLabel","subjectLabels")[wantedColumns]  #creating the names required to label the data

filteredSet<-combinedSet[wantedColumns]
names(filteredSet)<-wantedNames

#Step 3 : assigning activities as factors with names from activity_lables 
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)
filteredSet$activityLabel<-factor(filteredSet$activityLabel,levels=activityLabels[,1],labels=activityLabels[,2])
filteredSet$subjectLabels<-factor(filteredSet$subjectLabels)     #For easy melting later

#Step 5 ; averaging over subjects and activities by melting 
fluid<-melt(filteredSet)
AverageSet<-dcast(fluid,subjectLabels+activityLabel ~ variable,mean)

write.table(AverageSet, "tidy.txt", row.names = FALSE, quote = FALSE)
