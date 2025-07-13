
#---------------------stage 1 (Builder)--------------------

# Base image (OS)
FROM maven:3.8.3-openjdk-17 AS builder

# Working Directory
WORKDIR /app

# Code Copy
COPY . /app

#LIBRARIES
RUN mvn clean install -DskipTests=true


#---------------------stage 2 (RUN)--------------------

# Base image (OS)
FROM openjdk:17-alpine

# Working Directory
WORKDIR /app
# Copy build from stage 1 (Builder)
COPY --from=builder /app/target/*.jar /app/target/bankapp.jar

# PORT
EXPOSE 8080

# RUN APP
ENTRYPOINT ["java", "-jar", "/app/target/bankapp.jar"]
