node {
    def app

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

        app = docker.build("bsteverink/docker-demo")
    }

    stage('Test image') {
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
    withEnv(['RANCHER_URL=https://dutchrancher.in2systems.nl/v2-beta/projects/1a780']) {
        withCredentials([usernamePassword(credentialsId: 'rancher-server', usernameVariable: 'RANCHER_ACCESS_KEY', passwordVariable: 'RANCHER_SECRET_KEY')]) {
            stage('Deploy image to server') {
                sh '''
                    #!/bin/bash
                    rancher-compose -f rancher/docker-compose.yml -r rancher/rancher-compose.yml -p demo up -c -d webapp
                '''
            }
        }
    }
}
