#Ssimsort


*Requires* : RMagick

*Install ssimsort* :

~~~
gem install ssimsort
~~~

*Use ssim as an executable* :

~~~
#(Sort) Compares all images from the input folder and creates new folders
#containing every images within the tolerance range

$ ssimsort -s  <INPUT>, <OUTPUT>, <TOLERANCE>

#(Sort-Compare) Compares all images from the input folder with the base_image
#and sort them by their similarity ratio (ssim)

$ ssimsort -sc  <BASE_IMAGE>, <INPUT>, <OUTPUT>

#(Compare) Compares two images and displays their similarity ratio (ssim)

$ ssimsort -c <FILE_1>,<FILE_2>

#(Directory comparison) Compares all the images from a folder 

$ ssimsort -dc  <INPUT_DIR>

#(Mean) Calculates the average similarity ratio (A low mean means that the 
#folder content is very heterogeneous)

$ ssimsort -m  <INPUT_DIR>


~~~

*(Tolerance is a number between 0.0 and 1.0 that defines how similar the images you want to sort will be, 1.0 being the exact same image.)*
