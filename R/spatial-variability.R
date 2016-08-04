## Create single (double?) panel to highlight chl hotspots in Barnes and saline lakes.

library(DataflowR)

grassmap(rnge = c(201502), mapextent = c(557217, 567415, 2786102, 2797996), params = "chlext", labelling = TRUE, label_string = "2015-02")

grassmap(rnge = 201507, params = "chlext")
grassmap(rnge = 201502, params = "chlext")