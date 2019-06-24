pipeline {
  agent any
  tools {
        maven 'MAVEN_HOME'
        jdk 'JAVA_HOME'
  }
  stages {
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace... */
      steps {
        checkout scm
      }
    }
    //stage('Build') {
     // steps {
      //  sh 'mvn -B -DskipTests clean package'
       // sh 'echo $USER'
        //sh 'echo whoami'
      //}
    //}
    stage('Create Packer AMI') {
        steps {
            sh 'packer build 2tor4me-ami.json'
      }
    }
    stage('EC2 APP Deployment') {
      steps {
            sh '''
               terraform init
	       terraform plan -out plan.out
               terraform apply -auto-approve plan.out
            '''
      }
    }
  }
  environment {
    npm_config_cache = 'npm-cache'
  }
}
