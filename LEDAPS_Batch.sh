#
# Script to automate processing of Landsat Data after download from Glovis
# Calls LEDAPS and GDAL
#

# unzips downloaded tar files
for i in *.tar.gz; do
    name=${i//".tar.gz"}
    echo $name
    #mkdir working/$name                                                        
    cd working/$name
    cat ../../topscript > runjob
    echo " tar -xvzf ../../$i" >> runjob                                        
    echo " lndpm *_MTL.txt" >> runjob                                          
    echo " lndcal lndcal*txt" >> runjob                                        
    echo " lndcsm lndcsm*txt" >> runjob                                        
    echo " lndsr lndsr*txt" >> runjob
    echo " rm *$name*tif" >> runjob
    # Extract Bands to TIFF                                                     
    k=lndsr.$name.hdf
    echo " gdal_translate -co TFW=yes HDF4_EOS:EOS_GRID:\"$k\":Grid:band3 $name_b3.ti\
f" >> runjob
    echo " gdal_translate -co TFW=yes HDF4_EOS:EOS_GRID:\"$k\":Grid:band4 $name_b4.ti\
f" >> runjob
    echo " ./grass_cluster.sh" >> runjob
    echo " ./NDVI_calc.sh" >> runjob
    qsub runjob
    cd ../..
done

#Calculate NDVI

#Calculate MSAVI2

#Clip Data

#Remove Large NDVI

#Remove Large MSAVI2

#Remove tif files

#Remove HDF files

