def SHARE_BRANCH_NAME = ""
def SHARE_WORKSPACE = ""

pipeline {
    agent any
    stages {
        stage('Prepare') {
            steps {
                script {
					sh 'pip install -r requirements.txt'
					
                    // Delete existing log
                    try {
                        sh 'del /S *.xml'
                    } catch(Exception) {}
                    try {
                        sh 'del /S *.png'
                    } catch(Exception) {}
                    try {
                        sh 'del /S *.html'
                    } catch(Exception) {}

                    SHARE_WORKSPACE = env.WORKSPACE
                    SHARE_BRANCH_NAME = env.GIT_BRANCH
    	            SHARE_BRANCH_NAME = SHARE_BRANCH_NAME.replace('origin/', '')
                    echo "Share branch name is " + SHARE_BRANCH_NAME
                    echo "Share workspace is " + SHARE_WORKSPACE
                }
            }
        }
        stage('SMT-UAT') {
            parallel {
                stage('SMT-1') {
                    agent {
                        label "master"
                    }
                    steps {
                		git branch: SHARE_BRANCH_NAME, url: 'https://github.com/atthaboon/robotframework-puppeteer-jenkinspipeline-demo.git'
                    	sh 'robot -v ARGS_BROWSER:CHROME -v HEADLESS:True -v ARGS_ENV:DEV -v ARGS_DATA:DEV -v ARGS_SS_PATH:"'+SHARE_WORKSPACE+'/SMT-1" -i SMT-1 -e IGNOREORMANUAL -o output-1.xml -d "'+SHARE_WORKSPACE+'/SMT-1"  "Web_APP2_V2/Features/"'
                    }
                }
                stage('SMT-2') {
                    agent {
                        label "master"
                    }
                    steps {
                    	git branch: SHARE_BRANCH_NAME, url: 'https://github.com/atthaboon/robotframework-puppeteer-jenkinspipeline-demo.git'
                    	sh 'robot -v ARGS_BROWSER:CHROME -v HEADLESS:True -v ARGS_ENV:DEV -v ARGS_DATA:DEV -v ARGS_SS_PATH:"'+SHARE_WORKSPACE+'/SMT-2" -i SMT-2 -e IGNOREORMANUAL -o output-2.xml -d "'+SHARE_WORKSPACE+'/SMT-2" "Web_APP2_V2/Features/"'
                    }
                }
                stage('SMT-3') {
                    agent {
                        label "master"
                    }
                    steps {
                    	git branch: SHARE_BRANCH_NAME, url: 'https://github.com/atthaboon/robotframework-puppeteer-jenkinspipeline-demo.git'
                    	sh 'robot -v ARGS_BROWSER:CHROME -v HEADLESS:True -v ARGS_ENV:DEV -v ARGS_DATA:DEV -v ARGS_SS_PATH:"'+SHARE_WORKSPACE+'/SMT-3" -i SMT-3 -e IGNOREORMANUAL -o output-3.xml -d "'+SHARE_WORKSPACE+'/SMT-3" "Web_APP2_V2/Features/"'
                    }
                }
            }
            post { 
		        always {
					script {
						step([
							$class : 'RobotPublisher',
							outputPath : '.',
							outputFileName : "**/output-*.xml",
							reportFileName : '**/report.html',
							logFileName : '**/log.html',
							disableArchiveOutput : false,
							passThreshold : 100.0,
							unstableThreshold : 100.0,
							otherFiles : '**/*.png',
						])
					}
		        }
		    }
        }
    }
}