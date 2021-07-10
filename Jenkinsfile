podTemplate(label: 'docker-build', 
  containers: [
    containerTemplate(
      name: 'git',
      image: 'alpine/git',
      command: 'cat',
      ttyEnabled: true
    ),
    containerTemplate(
      name: 'docker',
      image: 'docker',
      command: 'cat',
      ttyEnabled: true
    ),
    containerTemplate(
        name: 'gradle',
        image: 'gradle:7.1.0-jdk11',
        command: 'cat',
        ttyEnabled: true
    )
  ],
  volumes: [ 
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'), 
  ]
) {
    node('docker-build') {
        def dockerHubCred = "dockerhub-jjm-id"
        def appImage
        
        stage('Checkout'){
            git (
                branch: 'master',
                credentialsId: 'JJongMani',
                url: 'https://github.com/JJongMani/todo.git'
            )
        }
        
        stage('Test'){
            container('gradle'){
                script {
                    sh 'chmod 755 ./gradlew'
                    sh 'java -version'
                    sh 'printenv|sort'
                    // sh './gradlew test'
                    sh './gradlew build -x test'
                }
            }
        }
        stage('Build'){
            container('docker'){
                script {
                    appImage = docker.build("whdals09/jenkins")
                }
            }
        }
        
        // stage('Build'){
        //     container('docker'){
        //         script {
        //             appImage = docker.build("jkk3366/jenkins")
        //         }
        //     }
        // }
        

        stage('Push'){
            container('docker'){
                script {
                    docker.withRegistry('https://registry.hub.docker.com', dockerHubCred){
                        appImage.push("${env.BUILD_NUMBER}")
                        appImage.push("latest")
                    }
                }
            }
        }
    }
    
}
