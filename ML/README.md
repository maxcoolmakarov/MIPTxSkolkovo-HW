Sberbank Russian Housing Market project

https://www.kaggle.com/c/sberbank-russian-housing-market/data


1. Adding structure to our project 
https://github.com/drivendata/cookiecutter-data-science


```

├── README.md          <- The top-level README for developers using this project.
├── data
│   ├── external       <- Data from third party sources.
│   ├── interim        <- Intermediate data that has been transformed.
│   ├── processed      <- The final, canonical data sets for modeling.
│   └── raw            <- The original, immutable data dump.
│
├── models             <- Trained and serialized models, model predictions, or model summaries
│
├── notebooks          <- Jupyter notebooks. Naming convention is a number (for ordering),
│                         the creator's initials, and a short `-` delimited description, e.g.
│                         `1.0-jqp-initial-data-exploration`.
│
├── references         <- Data dictionaries, manuals, and all other explanatory materials.
│
├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
│   └── figures        <- Generated graphics and figures to be used in reporting
│
├── requirements.txt   <- The requirements file for reproducing the analysis environment, e.g.
│                         generated with `pip freeze > requirements.txt`
│
└── src                <- Source code for use in this project.
   ├── __init__.py    <- Makes src a Python module
   │
   ├── data           <- Scripts to download or generate data
   │   └── make_dataset.py
   │
   ├── features       <- Scripts to turn raw data into features for modeling
   │   └── build_features.py
   │
   ├── models         <- Scripts to train models and then use trained models to make
   │   │                 predictions
   │   ├── predict_model.py
   │   └── train_model.py
   │
   └── visualization  <- Scripts to create exploratory and results oriented visualizations
       └── visualize.py

```


2. Virtual environment
```
$ python3 -m venv env 
$ source env/bin/activate 
$ deactivate 
```

which python
/Users/aleksandrzverkov/anaconda3/bin/python   - local base env
/Users/aleksandrzverkov/PycharmProjects/ml_2021/env/bin/python   our env

pip install numpy pandas matplotlib seaborn scikit-learn jupyter kaggle 

pip freeze > requirements.txt

pip install -r requirements.txt

3. Download data

pip install kaggle
# Kaggle API
https://github.com/Kaggle/kaggle-api

( cp ~/Downloads/kaggle.json ~/.kaggle/kaggle.json ) 

chmod 600 ~/.kaggle/kaggle.json



kaggle competitions download -c sberbank-russian-housing-market  -p ./data/raw

unzip './data/raw/ashrae-energy-prediction.zip' -d './data/raw'
rm  './data/raw/ashrae-energy-prediction.zip'

