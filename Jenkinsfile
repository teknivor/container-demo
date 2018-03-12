pipeline {
  agent {
    docker {
      image 'rhel7/rhel'
    }
    
  }
  stages {
    stage('Test') {
      parallel {
        stage('Test') {
          steps {
            sleep 5
          }
        }
        stage('Run') {
          steps {
            echo 'Hello World'
          }
        }
      }
    }
  }
}