# swLDA (Stepwise Linear Discriminant Analysis)

## Input 
### Two datasets, one for training and one for testing
Example training dataset: 

|id|S01|S02|S03|S04|S05|S06|S07|S08|S09|S10|S11|S12|S13|S14|S15|S16|S17|S18|S19|S20|S21|S22|S23|S24|S25|S26|S27|S28|S29|S30|S31|S32|S33|S34|S35|S36|S37|S38|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|class|Type_L|Type_L|Type_L|Type_L|Type_CL|Type_L|Type_L|Type_L|Type_L|Type_B|Type_CL|Type_L|Type_L|Type_B|Type_B|Type_B|Type_B|Type_L|Type_B|Type_B|Type_B|Type_L|Type_N|Type_N|Type_N|Type_L|Type_L|Type_L|Type_CL|Type_L|Type_L|Type_B|Type_L|Type_CL|Type_B|Type_L|Type_B|Type_L|
|ENSG00000000419|5.32|5.3|6.64|5.6|6.61|5.24|6.66|6.62|6.41|5.19|6.16|7.29|4.78|6.14|5.66|5.8|6.2|4.69|6.5|5.49|7.29|5.23|5.63|4.82|5.64|6.07|4.79|6.25|5.19|5.8|4.63|5.98|6.19|4.97|4.15|5.82|6.4|4.67|
|ENSG00000001036|6.11|4.8|4.47|4.99|6.94|5|5.11|5.42|4.58|4.74|6.03|5.47|4.32|6.16|5.89|5.37|6.01|4.72|5.17|5.96|6.35|5.02|5.31|6.37|5.24|6.29|5.81|4.16|6.56|5.91|5.19|4|5.48|4.14|5.9|5.51|5.14|6.22|
|ENSG00000001084|5.78|4.01|5.14|5.11|3.63|5.93|4.11|3.68|3.23|5.01|5.81|4.5|5.17|5.61|6.19|5.02|6.79|5.97|4.77|5.85|4.78|4.27|6.8|6.25|4.5|5.08|5.21|4.24|4.12|6|4.16|3.19|4.29|3.95|5.26|6.63|4.38|6.38|
|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|

Example testing dataset: 

|id|T01|T02|T03|T04|T05|T06|T07|T08|T09|T10|T11|T12|T13|T14|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|ENSG00000000419|6.06|5.25|5.15|5.36|5.22|5.75|4.79|6.01|6.39|7.71|5.7|5.85|5.34|5.07|
|ENSG00000001036|4.47|5.39|5.28|5.82|5.75|6.96|6.09|5.07|5.3|5.76|5.4|4.27|5.03|5.68|
|ENSG00000001084|4.47|6|5.77|5.76|5.76|4.64|4.07|4.52|4.16|3.24|4.35|2.49|5.89|4.37|
|ENSG00000001497|5.27|4.27|6.58|5.54|5.57|6.4|4.91|4.79|4.95|5.83|4.89|5.33|4.23|6.03|
|...|...|...|...|...|...|...|...|...|...|...|...|...|...|...|

## Code  

[R Code to run swLDA](https://github.com/vanngocthuyla/Data_Analysis/tree/main/scripts/sequencing/swLDA_codee.R)  

## Output

### LDA_prediction_train

|Sample|TrueClass|PredictedClass|
|:----:|:----:|:---------------:|
|S01|Type_L|Type_L|
|S02|Type_L|Type_L|
|S03|Type_L|Type_L|
|S04|Type_L|Type_L|
|S05|Type_CL|Type_CL|
|S06|Type_L|Type_L|
|S07|Type_L|Type_L|
|S08|Type_L|Type_L|
|S09|Type_L|Type_L|
|S10|Type_B|Type_B|
|S11|Type_CL|Type_CL|
|S12|Type_L|Type_L|
|S13|Type_L|Type_L|
|S14|Type_B|Type_B|
|S15|Type_B|Type_B|
|S16|Type_B|Type_B|
|S17|Type_B|Type_B|
|S18|Type_L|Type_L|
|S19|Type_B|Type_B|
|S20|Type_B|Type_B|
|S21|Type_B|Type_B|
|S22|Type_L|Type_L|
|S23|Type_N|Type_N|
|S24|Type_N|Type_N|
|S25|Type_N|Type_N|
|S26|Type_L|Type_L|
|S27|Type_L|Type_L|
|S28|Type_L|Type_L|
|S29|Type_CL|Type_CL|
|S30|Type_L|Type_L|
|S31|Type_L|Type_L|
|S32|Type_B|Type_B|
|S33|Type_L|Type_L|
|S34|Type_CL|Type_CL|
|S35|Type_B|Type_B|
|S36|Type_L|Type_L|
|S37|Type_B|Type_B|
|S38|Type_L|Type_L|

### LDA_prediction_test

|Sample|Class|
|:----:|:---:|
|T01|Type_N|
|T02|Type_B|
|T03|Type_B|
|T04|Type_B|
|T05|Type_B|
|T06|Type_CL|
|T07|Type_CL|
|T08|Type_L|
|T09|Type_L|
|T10|Type_L|
|T11|Type_L|
|T12|Type_L|
|T13|Type_L|
|T14|Type_L|

### swLDA_Features_means

|Class|Mean.ENSG00000116299|Mean.ENSG00000166145|Mean.ENSG00000243509|Mean.ENSG00000119888|Mean.ENSG00000168918|Mean.ENSG00000261040|Mean.ENSG00000049283|
|:---:|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|:------------------:|
|Type_B|1.06545454545455|7.21|0.394545454545455|6.94090909090909|0.143636363636364|1.97909090909091|4.68727272727273|
|Type_CL|0.65|0.775|1.36|0.745|0.205|3.855|0.1925|
|Type_L|6.489|7.6215|0.436|6.9545|1.0955|0.451|6.4195|
|Type_N|0.51|6.6|5.79333333333333|3.88333333333333|3.42333333333333|4.21333333333333|1.11|

### swLDA_Features_coeffs
|scaling.LD1|scaling.LD2|scaling.LD3| |
|:---------:|:---------:|:---------:|:---------:|
|ENSG00000116299|0.761082179330159|-1.10926474400401|0.500452033399354|
|ENSG00000166145|1.04261131564328|1.01300646262874|0.0527673697586225|
|ENSG00000243509|0.0440286580504465|0.436103939833443|1.58889405335683|
|ENSG00000119888|0.950755280416352|1.25267057366866|-0.256855086103996|
|ENSG00000168918|0.425979306477355|0.565426970987082|0.95357000513638|
|ENSG00000261040|-0.232960568966649|0.310222368504156|-0.818841643861012|
|ENSG00000049283|0.503948130636801|-0.552477742195569|-0.432827793777006|

### Predict_stat

Overall accuracy for the training set: 1.0
Confusion matrix:

|True predicted|Type_B|Type_CL|Type_L|Type_N|
|:------------:|:----:|:-----:|:----:|:----:|
|Type_B|11|0|0|0|
|Type_CL|0|4|0|0|
|Type_L|0|0|20|0|
|Type_N|0|0|0|3|

### swLDA plot
<img src='https://vanngocthuyla.github.io/Data_Analysis/images/omics/swLDA_plot.jpg' width="800">
