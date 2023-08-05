## Supermarket Sales Data Dashboard

# Shiny Dashboard

This is an attempt to develop enterprise dashboard for this supermarket to monitor the income performance.

It's from a data set I found on kaggle. It's a supermarket sale, income, price, payment, etc.

I had this idea to utilize some recent work that has been done in the R community.

The idea was use shiny, bs4dash, css, docker and cloud runner GCP.

So, about the app.

1.  The app, the supermarket data has a column call branch, customer type, product line. I decided to make a summaries about the total income, total quantity, gross income, products. The idea is to give it's users a high level overview of the data.

2.  We have the map and donut chart payment type, and maps with point of the store and the total quantity, and total income.

3.  We have a line plot that shows the increase in sales per income over time

4.  In the next tab, we have a data table and summaries

## The Data

The folder structure:

# Shiny App Docker Implementation

This repository provides a Dockerized implementation of a Shiny app using the Rocker Shiny image. The Docker container can be built and run to deploy the Shiny app.

## Docker Setup

Make sure you have Docker installed on your system. You can download and install Docker from <https://www.docker.com/get-started>.

## Build the Docker Image

Navigate to the directory containing the `Dockerfile` and your Shiny app files.

Run the following command to build the Docker image:

``` bash
docker build -t shinyapp:v01 .
```

This command builds the Docker image with the tag shinyapp:v01.

Run the Docker Container Once the image is built, you can run a Docker container to deploy the Shiny app.

Use the following command to run the Docker container:

```         
docker run -it --rm -p 3838:3838 shinyapp:v01
```

The options used in this command are explained as follows:

-   -it: This flag makes the container run in interactive mode and attaches to the terminal.
-   --rm: This flag removes the container once it's stopped.
-   -p 3838:3838: This flag maps port 3838 from the container to port 3838 on the host machine.
-   shinyapp:v01: This specifies the name and tag of the Docker image to run.

The Shiny app will be accessible in your web browser at <http://localhost:3838>.

Remember to replace shinyapp:v01 with the appropriate image name and tag if you used a different name or tag during the build step.
