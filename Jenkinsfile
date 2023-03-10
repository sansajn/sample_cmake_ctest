pipeline {
	agent any

	stages {
		stage("build") { steps {
			sh 'make -C docker build'
		}}
		
		stage("test") { steps {
			sh 'make -C docker test'
		}}
	}
	
	post { always {
		sh 'make -C docker rm'
		junit 'build/junit.report'
		emailext body: '${JELLY_SCRIPT, template="text"}', subject: '$DEFAULT_SUBJECT', recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']]
	}}
}
