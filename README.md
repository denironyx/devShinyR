## Supermarket Sales Data Dashboard

This is an attempt to develop enterprise dashboard for this supermarket to monitor the income performance.

# To DO
- Design a dashboard wireframe
- Data wrangling
- Understanding of the data
- 


## Docker implementation
- Docker container
- Docker images


```
# build the docker image
docker build -t shinyapp:v01 .
```

Now run the docker container
```
docker run -it --rm -p 3838:3838 shinyapp:v01
```