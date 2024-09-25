# ENVH 556 Quantitative Exposure Assessment (2024)

## 1. Course Overview

This repository contains the code scripts for the ENVH 556 Quantitative Exposure Assessment (AUT 2024) lectures and labs. This course develops quantitative skills for analyzing occupational and environmental exposure data.

## 2. Repository Structure

-   **.qmd**: Files include individual lab and lecture code scripts
-   **.html**: Files include rendered scripts with include analytic output
-   **.R**: Files include additional R scripts 
-   **/Datasets**: Where data files should be placed (not included in the repository)

## 3. Getting Started

### 3.1. Download the Code Scripts

We will be using the [School of Public Health Server](https://rstudio.sph.washington.edu) for this course. Please verify that you can log in, and create a course directory here. For example: Documents/Courses/2024/ENVH556.

#### 3.1.1. Option 1: Clone the Repository

1.  Open your terminal or command prompt.
2.  Navigate to the directory where you want to store the project.
3.  Run the following command: 
    ```bash     
    git clone https://github.com/magali17/ENVH556_2024.git
    ```
4.  Use your GitHub credentials when prompted.
5.  Open the cloned directory as an R Project in RStudio:
    -   In RStudio, go to File \> New Project \> Existing Directory.
    -   Navigate to the cloned ENVH556_2024 directory and click "Create Project."

#### 3.1.2. Option 2: Create a New R Project and Copy Files

1.  Create a new R Project:
    -   Open RStudio.
    -   Go to File \> New Project \> New Directory.
    -   Choose "New Project."
    -   Enter a name for your project (e.g., "ENVH556_2024").
    -   Choose a location for your project.
    -   Click "Create Project."
2.  Download the course files and place these in your new project:
    -   Go to the GitHub repository page: <https://github.com/magali17/ENVH556_2024>
    -   Click the green "Code" button and select "Download ZIP."
    -   Extract the zipped files.
    -   Paste these files into your newly created R project directory.
3.  Set up the project:
    -   In RStudio, you should now see the project files in the "Files" pane.
    -   Create a new folder called "Datasets" in your project directory.
    -   Download the datasets from the links provided in the Datasets section.
    -   Place the downloaded datasets in the "Datasets" folder.

### 3.2. Download the Data

The corresponding datasets can be found at the following locations. The scripts will automatically download these datasets. Alternatively, you can manually download them and place them in the appropriate directories.

-   [Seattle mobile monitoring campaign](https://zenodo.org/records/13761282)
-   [Other datasets](https://faculty.washington.edu/sheppard/envh556/Datasets/)

### 3.3. Install Dependencies

Run the `install_packages.R` script to install required dependencies following one of the two options:

1. **Using R or RStudio:**
   - Open your R or RStudio environment.
   - Run the `install_packages.R` script by entering the following command in your R console:
     ```r
     source("install_packages.R")
     ```

2. **Using the Terminal:**
   - Navigate to the directory containing the `install_packages.R` script.
   - Run the script by executing the following command:
     ```bash
     Rscript install_packages.R
     ```
You may need to install additional packages during this process. 


## 4. Familiarize Yourself With R and RStudio

You will need to understand the basics of R and RStudio for this course. If you need help, here are a few resources:

1. [Swirl Tutorial Program](https://swirlstats.com/students.html): Swirl provides a step-by-step guide to downloading and setting up R and RStudio. The initial lessons cover the "Basics of R Programming" to help beginners get started.

2. [R for Data Science (R4DS)](https://r4ds.had.co.nz/) by Hadley Wickham and Garrett Grolemund: A comprehensive book for learning R and data science.

3. [R Onramp](https://github.com/deohs/r_onramp/blob/master/README.md) by the DEOHS [Coders Group](https://github.com/deohs/coders): A beginner-friendly resource that includes a [Resources and Getting Help](https://github.com/deohs/r_onramp/blob/master/r_resources_and_getting_help.md) section with additional tutorials, courses, and books.


## 5. Contributing

If you find any issues or have suggestions for improvements, please open an issue.


## 6. Version Control

It's a good practice to check for updates regularly to ensure you have the latest scripts for the course. If updates are made to any scripts in the repository, you can retrieve the latest versions with little GitHub knowledge, by following these steps:

1. If you have made changes to your local copy of any scripts, **rename your copy** or save it in a different location to avoid losing your work.
2. Download individual scripts directly from the GitHub repository:
     - Navigate to the specific file you want to update.
     - Click on the file to open it, then select the "Download Raw File" button to download the script.
3. Replace the existing file in their project directory with the new one.

