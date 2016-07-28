IMAGE_FOLDER = /home/jose/Documents/Science/JournalSubmissions/DataflowChl/figures

.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z0-9\./\_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

compile-figs: ## compile-figs
	Rscript R/discrete-approach.R

move-images: ## move images
	rsync -av \
	$(IMAGE_FOLDER)/chltimeseries.png \
	$(IMAGE_FOLDER)/multipanel.png \
	$(IMAGE_FOLDER)/landsat20120901.png .

compile-tex: move-images ## compile tex
	xelatex 2016_ESA_stach_dflow-chl.tex

all: move-images images compile-tex ## all
	@echo "built presentation"

images/scipy_border.png: ## images/scipy_border.png
	convert images/scipy_1-lg.jpg -gravity East -crop 85x100%+0+0 images/scipy_crop.png
	convert images/scipy_crop.png -bordercolor black \
	-border 2x2 -draw "fill white text 0,12 'http\://www.esri.com/\~/media/Images/Content/news/arcuser/0115/scipy\_1\-lg.jpg'" \
	images/scipy_border.png
	
	
images/pointsource_border.png: ## images/pointsource_border.png
	convert images/pol03a_700.jpg -bordercolor black \
	-border 2x2 -draw "fill white text 0,12 'http\://oceanservice.noaa.gov/education/kits/pollution/media/supp\_pol03a.html'" \
	images/pointsource_border.png

images/dflow_border.jpg: ## images/dflow_border.jpg
	convert images/20150212_110309.jpg -bordercolor black -border 5x5 images/dflow_border.jpg

images/landsat_border.jpg: ## images/landsat_border.jpg
	convert images/landsat20120901.png -bordercolor black -border 5x5 images/landsat_border.jpg
	
images: images/scipy_border.png images/pointsource_border.png images/dflow_border.jpg ## images

figures/chlcor_heatmap.png: ## figures/chlcor_heatmap.png
	Rscript R/chlcor_heatmap.R
	
figures/modelparam_hist.png: ## figures/modelparam_hist.png
	Rscript R/modelparam_hist.R
	
figures/modelparam_counts.png: ## figures/modelparam_counts.png
	Rscript R/modelparam_hist.R

clean: ## clean
	-rm *.snm *.nav *.log *.toc *.aux *.out
	
