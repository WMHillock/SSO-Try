pipeline {
    agent any

    environment {
        containerName = 'sso' //Измените на свое название сервиса
        containerPort = 16666 //Измените на порт
        imageName = "fpa/${containerName}:latest"
    }

    tools {
        maven 'MyMaven' // Укажите имя Maven установки, настроенной в Jenkins
    }

    stages {
        stage('Preparation') {
            steps {
                script {
                    echo "Stopping container: ${containerName}"
                    try {
                        sh "docker container stop ${containerName}"
                    } catch (Exception e) {
                        echo "Container ${containerName} is not running or does not exist."
                    }

                    echo "Removing container: ${containerName}"
                    try {
                        sh "docker rm ${containerName}"
                    } catch (Exception e) {
                        echo "Container ${containerName} does not exist."
                    }

                    echo "Removing image: ${imageName}"
                    try {
                        sh "docker rmi ${imageName}"
                    } catch (Exception e) {
                        echo "Image ${imageName} does not exist."
                    }
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        echo 'Starting Build stage'
                        sh 'mvn clean'
                        echo 'Maven clean completed'
                        sh "mvn package"
                        echo 'Maven build completed'
                    } catch (Exception e) {
                        echo "Build failed: ${e.getMessage()}"
                        throw e
                    }
                }
            }
        }

        stage('Dockerize') {
            steps {
                script {
                    echo 'Starting Dockerize stage'
                    docker.build("${imageName}", '.')
                    echo 'Docker image built'
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Starting Deploy stage for container: ${containerName}"
                    sh "docker run -d --name ${containerName} -p ${containerPort}:${containerPort} ${imageName}"
                    echo "Container '${containerName}' deployed"
                }
            }
        }

    }
}
