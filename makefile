.PHONY: docker_build

git_push:
	@echo "Enter the commit message: \c"
	@read COMMIT_MSG
	@git add .
	@git status 
	@git commit -m $COMMIT_MSG
	@git push 

docker_build:
	docker build -t rishicse24/test-k8s-app:latest . 

docker_push: docker_build
	docker push rishicse24/test-k8s-app:latest

