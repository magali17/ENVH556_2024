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

-   [Seattle mobile monitoring campaign](https://zenodo.org/records/14166411)
-   [California NOx Study](https://zenodo.org/records/13761282) (optional dataset)
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

--- 

## 7. Additional Topics

### How to Create and Add a GitHub Token for Push/Pull Access (e.g., needed on the SPH Server)

To interact with GitHub repositories from your machine (e.g., pushing changes or pulling updates), you need to authenticate using a Personal Access Token (PAT). Follow the steps below to create a token and set it up.

#### Step 1: Generate a GitHub Token 
1. Log in to your GitHub account at [github.com](https://github.com).
2. In the top-right corner, click on your profile picture and navigate to **Settings**.
3. Scroll down and select **Developer settings** in the sidebar.
4. Click on **Personal access tokens** → **Tokens (classic)** → **Generate new token**.
5. Enter a **note** (e.g., "Basic Token for Push/Pull").
6. Set an **expiration** date (choose based on your preference, e.g., 30 days).
7. Under **Select scopes**, check the following permissions:
   - `repo` (Full control of private repositories) 
8. Click **Generate token** and **copy** the token to a safe location, as you will not be able to view it again.

#### Step 2: Add the Token to Your Git Configuration 

Once the token is generated, you will need to configure Git to use the token for push/pull operations:

1. Open a terminal or command prompt on your machine.
2. Configure Git to store your credentials by running:

   ```bash
   git config --global credential.helper store  
   ```
   
This will store your credentials locally and reuse them for future Git commands.

#### Step 3: Test That This Works

1. Make a file change in your repository.
2. Use the command `git push`. You will be prompted for your GitHub username. Enter it.
3. When asked for your password, paste the token you copied earlier instead of your GitHub password.
4. After doing this once, Git will remember your token, so you won't need to re-enter it for future commands.

#### Troubleshooting

1. If your token expires, you will need to generate a new one by following the steps above.
2. To remove or update your stored credentials, use the following command:

    ```bash
    git credential-manager-core erase
    ```
    
