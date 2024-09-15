{
  pkgs,
  ...
}:
with pkgs;
let
  name = "hervyqa";
in {
  home-manager = {
    users.${name} = {
      home = {
        packages = [
          (
            python3.withPackages ( ps:
              with ps; [
                beautifulsoup4
                bokeh
                catboost
                cython
                dash
                dask
                django
                falcon
                fastai
                flask
                gensim
                ipython
                jupyter
                jupyterlab
                kaggle
                matplotlib
                mutagen
                nltk
                numpy
                opencv4
                optuna
                orange3
                pandas
                plotly
                pydot
                pytorch
                scikit-learn
                scipy
                scrapy
                seaborn
                selenium
                spacy
                sphinx
                spyder
                statsmodels
                sympy
                torch
                uv
                virtualenv
                xgboost
                # keras # collision grpcio from keras
                # lightgbm # unfree need cudatoolkit
                # tensorflow # collision grpcio from keras
              ]
            )
          )
        ];
      };
    };
  };
}
