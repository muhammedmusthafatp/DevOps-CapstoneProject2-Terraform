pipeline {
    agent none

    environment {
        AWS_REGION = 'ap-south-2'
        TF_DIR     = 'environments/dev'
    }

    stages {

        stage('Checkout (Controller)') {
            agent { label 'built-in' }
            steps {
                checkout scm
            }
        }

        stage('Terraform Init & Plan') {
            agent { label 'built-in' }
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform init'
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Manual Approval') {
            steps {
                input message: 'Review the Terraform plan above. Apply these changes?', ok: 'Apply'
            }
        }

        stage('Terraform Apply') {
            agent { label 'built-in' }
            steps {
                dir(env.TF_DIR) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage('Checkout (Agent)') {
            agent { label 'capstone2' }
            steps {
                checkout scm
            }
        }

        stage('Run Ansible Playbooks') {
            agent { label 'capstone2' }
            steps {
                dir('ansible') {
                    sh 'ansible-playbook playbooks/site.yml'
                }
            }
        }

        stage('Verify Infrastructure') {
            agent { label 'capstone2' }
            steps {
                echo 'Checking EC2 reachability...'
                sh 'ansible all -m ping'

                echo 'Checking application health endpoint...'
                sh 'curl -f http://10.0.101.173/health'

                echo 'Checking NGINX service status on app server...'
                sh 'ansible tag_Role_app -m command -a "systemctl is-active nginx"'

                echo 'Checking Docker service status on all hosts...'
                sh 'ansible all -m command -a "systemctl is-active docker"'

                echo 'Checking app container is running...'
                sh 'ansible tag_Role_app -m command -a "docker ps --filter name=capstone2-app --format {{.Status}}"'
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully - infrastructure provisioned, configured, and verified.'
        }
        failure {
            echo 'Pipeline failed - check the stage logs above for details.'
        }
    }
}
