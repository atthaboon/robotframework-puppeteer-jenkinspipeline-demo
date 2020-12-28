def SHARE_BRANCH_NAME = ""
def SHARE_WORKSPACE = ""

pipeline {
    agent {
        label "master"
    }
    stages {
        stage('Prepare') {
            steps {
                script {
					bat 'pip install -r requirements.txt'
					
                    // Delete existing log
                    try {
                        bat 'del /S *.xml'
                    } catch(Exception) {}
                    try {
                        bat 'del /S *.png'
                    } catch(Exception) {}
                    try {
                        bat 'del /S *.html'
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
                    	bat 'robot -v ARGS_BROWSER:CHROME -v HEADLESS:True -v ARGS_ENV:DEV -v ARGS_DATA:DEV -v ARGS_SS_PATH:"SMT-1" -i SMT-1 -o output-1.xml .'
                    }
                    post { 
				        always {
							script {
								bat 'echo f | xcopy output-1.xml "'+SHARE_WORKSPACE+'" /Y /I'
								bat 'echo f | xcopy SMT-1 "'+SHARE_WORKSPACE+'/SMT-1" /Y /I'
							}
						}
					}
							
                }
                stage('SMT-2') {
                    agent {
                        label "master"
                    }
                    steps {
                    	git branch: SHARE_BRANCH_NAME, url: 'https://github.com/atthaboon/robotframework-puppeteer-jenkinspipeline-demo.git'
                    	bat 'robot -v ARGS_BROWSER:CHROME -v HEADLESS:True -v ARGS_ENV:DEV -v ARGS_DATA:DEV -v ARGS_SS_PATH:SMT-2 -i SMT-2 -o output-2.xml .'
                    }
                }
                post { 
			        always {
						script {
							bat 'echo f | xcopy output-2.xml "'+SHARE_WORKSPACE+'" /Y /I'
							bat 'echo f | xcopy SMT-2 "'+SHARE_WORKSPACE+'/SMT-2" /Y /I'
						}
					}
				}
                
            }
            post { 
		        always {
					script {
						bat 'rebot output-*.xml'
						step([
							$class : 'RobotPublisher',
							outputPath : '.',
							// outputFileName : "output.xml",
							reportFileName : 'report.html',
							logFileName : 'log.html',
							disableArchiveOutput : false,
							passThreshold : 100.0,
							unstableThreshold : 100.0,
							otherFiles : 'SMT-*/*.png',
						])
					}
		        }
		    }
        }
    }
}