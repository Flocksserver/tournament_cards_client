build-app:
	flutter build web --no-sound-null-safety

push:
	aws s3 sync build/web/ s3://ttc-match-generator --acl public-read --profile flocksserver