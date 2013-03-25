#
# Script to automate processing of Landsat Data after download from Glovis
# Calls LEDAPS and GDAL
#

# unzips downloaded tar files
for i in *.tar.gz;
	echo $i
	do tar -xvzf  $i;
done;

# executes LEDAPS processes
for j in *_MTL.txt;
	do do_LEDAPS.csh $j
done;

# Extract Bands to TIFF
for k in lndsr*hdf; 
	do gdal_translate HDF4_EOS:EOS_GRID:\"$k\":Grid:band3 $i\b3.tif; done
	do gdal_translate HDF4_EOS:EOS_GRID:\"$k\":Grid:band4 $i\b4.tif; done
done;

#Calculate NDVI

#Calculate MSAVI2

#Clip Data

#Remove Large NDVI

#Remove Large MSAVI2

#Remove tif files

#Remove HDF files

