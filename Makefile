IMAGE_NAME=versioning-checker
APP_VERSION=$(shell cat APP_VERSION)

build:
  docker build -t $(IMAGE_NAME):$(APP_VERSION) .

run:
  docker run -it $(IMAGE_NAME):$(APP_VERSION)