pipeline {
	agent any

	stages {
		stage("build") { steps {
			sh 'cmake -S . -B build'
			sh 'cmake --build build -j16'
		}}
		
		stage("test") { steps {
			sh 'ctest --test-dir build --output-on-failure --output-junit junit.report'
		}}
	}
	
	post { always {
		junit 'build/junit.report'
	}}
}
