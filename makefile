.PHONY: docker_build git_push docker_run docker_run_force

git_push:
	@read -p "Enter the commit message: " COMMIT_MSG ; \
		git add . ; \
		git status ; \
		git commit -m "$$COMMIT_MSG" ; \
		git push 

docker_build:
	@if docker manifest inspect "rishicse24/test-k8s-app:latest" >/dev/null 2>&1; then \
  		echo "image exists"; \
	else \
		docker build -t rishicse24/test-k8s-app:latest .; \
	fi

docker_push: docker_build
	docker push rishicse24/test-k8s-app:latest

docker_run: docker_build
	docker run --rm -d \
		--name test-k8s-app \
		--publish 8080:80 \
		rishicse24/test-k8s-app:latest

docker_run_force: 
	docker stop test-k8s-app || true 
	docker rmi rishicse24/test-k8s-app:latest || true
	docker build -t rishicse24/test-k8s-app:latest .
	docker run --rm -d \
		--name test-k8s-app \
		--publish 8080:80 \
		rishicse24/test-k8s-app:latest

