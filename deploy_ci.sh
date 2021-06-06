VERSION=$(git name-rev --tags --name-only $(git rev-parse HEAD))

./deploy.sh $VERSION