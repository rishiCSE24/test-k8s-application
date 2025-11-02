.PHONY: docker_build git_push app_run app_run_force

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

app_run: docker_build
	@if docker ps \
		--filter "name=^test-k8s-app$$" \
		--filter "status=running" \
		--format '{{.Names}}' \
		| grep -qx test-k8s-app; \
	then \
		echo "application is already running"; \
	else \
		if docker ps -a \
			--filter "name=^test-k8s-app$$" \
			--format '{{.Names}}' \
			| grep -qx test-k8s-app; \
		then \
			echo "Removing old container..."; \
			docker rm -f test-k8s-app >/dev/null; \
		fi; \
		echo "Starting application..."; \
		docker run --rm -d \
			--name test-k8s-app \
			-p 8080:80 \
			rishicse24/test-k8s-app:latest; \
	fi


app_run_force: 
	docker stop test-k8s-app || true 
	docker rmi rishicse24/test-k8s-app:latest || true
	docker build -t rishicse24/test-k8s-app:latest .
	docker run --rm -d \
		--name test-k8s-app \
		--publish 8080:80 \
		rishicse24/test-k8s-app:latest

