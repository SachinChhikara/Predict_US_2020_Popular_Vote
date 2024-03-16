# Predicting US popular vote 2024

## Overview

The purpose of this study is to predict between whether Trump or Biden would win 
the popular vote in 2024 US election.

- America's Pulse Survey
  - In order to this survey data, visit https://polarization-research-lab.github.io/americas-pulse-dashboard/tabs/download.html. 
  You can choose download all the survey data or choose a certain week. For our study we choose 2024 - week 5.

- ACS Data from IPUMS USA.
    - In order to obtain the ACS data, visit https://usa.ipums.org/usa/index.shtml. First, you must create an account, you need to fill out information such as name, organization, email and why you plan to use the data. After creating an account, go back to the original link and click "Get Data" in the middle of the page. First, you must select a sample (year), we used the 2022 1 year ACS. After completing this step, you can choose a variety of variables inlcuding Age, Gender, Race to name a few. For our report we selected "age", "sex", "hispan", "educd", "races", and "stateicp" among other variables. After selecting your variables, click on "View Data Cart", then click "Create Data Extract". You will then see a page with information about your data, for your "Data Format" (3rd row), select STATA or .dta. Make sure to save usa_0001.dat and usa_0001.xml in `data/raw_data/` After completing this you can either cut down on your file size by choosing a smaller sample or describe your extract and click submit. For our report, we chose a sample size of 20,686 persons. After this is done, you will receive an email when the data is processed.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, clean data, and the creation of the model used.


## Statement on LLM usage

Aspects of the code were written with the help of the ChatGPT 3.5,the entire chat history is available in inputs/llms/usage.txt.
