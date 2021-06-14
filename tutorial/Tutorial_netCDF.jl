"""
This is Tutorial_netCDF.jl. It contains all the necessary commands to import a netCDF file from a seismic tomography, 
to convert it to the GeoData format and to export it to a Paraview format. The following steps are performed:
1. Read data from this file.
2. Put the data in a GeoData format (this is the format that is used internally in the GMG).
3. Export that data to a format readable by Paraview.
"""

# 1. define where the file is located on your computer
filename = "/Users/mthiel/PROJECTS/CURRENT/SPP2017/GeophysicalModelGenerator/InputData/El-Sharkawy-etal-G3.2020-MeRE2020-Mediterranean-0.0.nc"

# 2. load desired data
using NetCDF # add the NetCDF package

# Now check with ncinfo(filename), what the variables are called exactly and what the contents of your netCDF file are 

lat = ncread(filename,"latitude")
lon = ncread(filename,"longitude")
depth = ncread(filename,"depth")
vs    = ncread(filename,"Vs")
depth = -1 .* depth # CAREFUL: MAKE SURE DEPTH IS NEGATIVE, AS THIS IS THE ASSUMTPION IN GeoData

# For netCDF data, 3D coordinates of a regular grid are only given as 1D vectors. As we need to compute Cartesian coordinates for
# Paraview, we need the full matrix of grid coordinates
Lon3D,Lat3D,Depth3D = LonLatDepthGrid(lon, lat, depth);

# Set up the Data structure
Data_set1       =   GeoData(Lat3D,Lon3D,Depth3D,(VS=vs,))

# Export the data structure to Paraview format
Write_Paraview(Data_set, "test_netcdf_3D")