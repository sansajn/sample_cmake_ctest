pipeline {
	agent any

	stages {
		stage("docker image") { steps {
			sh 'make image'
		}}

		stage("build") { steps {
			sh 'make build'
		}}
		
		stage("test") { steps {
			sh 'make test'
		}}
	}
	
	post { always {
		sh 'make rm'
		junit 'report/junit.report'
		emailext body: '${JELLY_SCRIPT, template="text"}', subject: '$DEFAULT_SUBJECT', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']]
	}}
}
