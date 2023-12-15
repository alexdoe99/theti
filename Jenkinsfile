pipeline {
    agent any

    environment {
        DOCKER_COMPOSE_FILE = '/var/lib/jenkins/workspace/CICD3/docker-compose.yml'
        APP_ENV = 'prod'
        DOCKER_HUB_SECRET = credentials('Idcredetial')
        DOCKER_IMAGE_NAME = 'samircasanova117145/cicd3_app'
    
    }

    stages {
        stage('Change Ownership') {
            steps {
                echo 'Changing ownership of Jenkins workspace...'
                script {
                    sh 'sudo chown -R jenkins:jenkins /var/lib/jenkins/workspace/CICD3/'
                }
            }
        }
        
        stage('Get Repo') {
            steps {
                echo 'Changing ownership of Jenkins workspace...'
                script {
                    sh 'sudo chown -R jenkins:jenkins /var/lib/jenkins/workspace/CICD/'
                }
            }
        }

        stage('Clean Docker') {
            steps {
                echo 'Stopping and removing containers...'
                script {
                    sh "docker-compose -f $DOCKER_COMPOSE_FILE -p $APP_ENV down --volumes"
                }
            }
        }

        stage('Build UP') {
            steps {
                echo 'Building and starting new containers...'
                script {
                    sh "docker-compose -f $DOCKER_COMPOSE_FILE up -d"
                }
               
            }
        }

       
        stage('Test') {
            steps {
                echo 'Running tests...'
                script {
                    sh 'cd /var/lib/jenkins/workspace/CICD3 && phpunit --log-junit result.xml UnitTestFiles/Test/'
                }
            }
        }
         
         //stage('Push to Docker Hub') {
         //   steps {
         //           withCredentials([string(credentialsId: DOCKER_HUB_SECRET, variable: 'DOCKER_PASSWORD')]) {
          //              sh "docker login --username samircasanova117145 --password $DOCKER_PASSWORD"
          //              sh "docker tag cicd3_app samircasanova117145/cicd3_app"
          //              sh "docker push samircasanova117145/cicd3_app"
         //           }
         //   }
         //}
}
}
