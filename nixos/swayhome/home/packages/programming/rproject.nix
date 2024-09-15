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
        packages = let
          list-packages = with rPackages; [
            DBI
            DT
            DataExplorer
            GGally
            Hmisc
            IRdisplay
            IRkernel
            KernSmooth
            RColorBrewer
            ROCR
            RSQLite
            Rcrawler
            SmartEDA
            askpass
            backports
            base64enc
            bit
            bit64
            blob
            boot
            brew
            brio
            broom
            broom
            bslib
            cachem
            callr
            caret
            caretEnsemble
            cellranger
            class
            cli
            clipr
            cluster
            codetools
            colorspace
            commonmark
            conflicted
            cpp11
            crayon
            credentials
            curl
            data_table
            dbplyr
            desc
            dplyr
            e1071
            esquisse
            forecast
            foreign
            ggmap
            ggplot2
            ggraph
            # glmnet
            haven
            janitor
            jsonlite
            keras
            kernlab
            knitr
            languageserver
            lattice
            # leaflet
            lubridate
            markdown
            mboost
            mlr3
            pbdZMQ
            plotly
            psych
            purrr
            quanteda
            quarto
            randomForest
            readr
            repr
            reticulate
            rmarkdown
            shiny
            sqldf
            stargazer
            stringr
            summarytools
            superml
            tableone
            tidymodels
            tidyquant
            tidyr
            tidyverse
            tinytex
            tm
            tseries
            xgboost
            xml2
            zip
          ];
          r-with-packages =
          (
            rWrapper.override {
              packages = list-packages;
            }
          );
          rstudio-with-packages =
          (
            rstudioWrapper.override {
              packages = list-packages;
            }
          );
        in [
          r-with-packages
          rstudio-with-packages
        ];
      };
    };
  };
}
