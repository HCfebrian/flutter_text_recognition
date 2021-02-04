Pizza Cashback feature using ML-kit text recognition

# Project idea:
- user buy pizza offline
- user got receipt
- user install the app and scan the receipt
- user will get a cashback if the receipt is confirmed in database. 
- app download count goes stonks

# Project structure :
Clean Architecture.

there are 3 main layers
- data
- domain
- presentation

### data layer
data source from 3rd party library or the internet. 
this layer also handle conversion to entity.

### domain layer
the business layer, manipulating pure entities through usecases.

### presentation layer
containing only UI logic. don't add Bussines logic although there is BLoC in this layer. 
all the bussines logic will be handle in domain layer. BLoC on this layer works only for state management.


# Main Technology:

### ML Kit -  text recognition
use mlkit for extracting data from camera. for now we use offline text recognition. 

pelase use this image for testing.
<img src="https://github.com/HCfebrian/flutter_text_recognition/blob/master/doc/Screen%20Shot%202021-01-28%20at%2010.34.22.png" width="200"/>

### Simple Text Mining
since the text that we got from ML kit is still all over the place(a lot of noice and unnececery text), we should mining the text and trun it into something useful.
this app contain simple text normalization and simple Text similarity using Jaccard algoritm.
main challange in text mining on this app is to get Purchase ID and make comparable data with our online database.

### Firestore database
we store receipt data in firestore. data from firestore will be called and than we compare it with comparable data from text mining 


