pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout your Terraform module repository from GitHub
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/pavanteja2704/project.git']])
            }
        }
 
        stage('Setup Terraform') {
            steps {
                script {
                    // Initialize Terraform
                    sh 'terraform init'
                }
            }
        }
 
        stage('Terraform Plan') {
            steps {
                script {
                    // Run Terraform plan
                    sh 'terraform plan'
                }
            }
        }
 
        stage('Terraform Apply') {
            steps {
                script {
                    // Apply Terraform configuration
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    
}