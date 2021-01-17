# Docker AWS Elastic Beanstalk CLI
Automatically updated Docker image for running tasks using the latest version of AWS CLI and AWS Elastic Beanstalk CLI.

No longer the `An update to the EB CLI is available. Run "pip install --upgrade awsebcli" to get the latest version.` alert.

For use in e.g.:
- CI (Gitlab, Travis, Jenkins, CircleCI)
- Local development

[![DockerHub Badge](http://dockeri.co/image/chabter/aws-eb-cli)](https://hub.docker.com/r/chabter/aws-eb-cli/)

## Build

```
docker build -t chabter/aws-eb-cli .
```

## Usage

### CLI

Running the container is quite simple and only requires two steps, mount a directory and provide AWS CLI credentials.
The following examples should be sufficient for simple usage using a CLI on Linux. For Windows Command Line use `%cd%` and for PowerShell use `${PWD}` instead of `$(pwd)`.

Example using environment variables:

```shell
docker run -i -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN chabter/aws-eb-cli aws --version
```

```shell
docker run -i -w /work -v $(pwd):/work -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e         AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN chabter/aws-eb-cli eb --version
```

Example mounting AWS CLI configuration files:

```shell
docker run -i -w /work -v $(pwd):/work -v ~/.aws:/home/root/.aws chabter/aws-eb-cli aws --version
```

```shell
docker run -i -w /work -v $(pwd):/work -v ~/.aws:/home/root/.aws chabter/aws-eb-cli eb --version
```

### Gitlab CI

Example usage in Gitlab CI:

```yaml
production:
  stage: deploy
  environment:
    name: production
    url: $PRODUCTION_ENV_URL
  image: chabter/aws-eb-cli:latest
  before_script:
    - touch ~/.aws/config
    - printf "[profile eb-cli]\nregion=$AWS_DEFAULT_REGION\noutput=json" >> ~/.aws/config
    - touch ~/.aws/credentials
    - printf "[eb-cli]\naws_access_key_id = $AWS_ACCESS_KEY_ID\naws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> ~/.aws/credentials
  script:
    - echo "Deploying to production..."
    - eb init --region=$AWS_DEFAULT_REGION --platform=$PLATFORM $EB_APP_NAME
    - eb use $EB_PRODUCTION_ENVIRONMENT
    - eb deploy $EB_PRODUCTION_ENVIRONMENT --label=$CI_COMMIT_SHA
  only:
    - master
  when: manual
```

### Jenkins

Example usage in Jenkins:

```
docker.image('chabter/aws-eb-cli').inside('-u root:root') {
    sh 'aws --version'
}
```

```
docker.image('chabter/aws-eb-cli').inside('-u root:root') {
    sh 'eb --version'
}
```

*Don't forget to use the Docker workflow plugin.*

## Postcardware

This Docker image is completely free to use. If it makes it to your production environment we would highly appreciate you sending us a postcard from your hometown! 👏🏼

Our address is: Chabter, Kanaalstraat 12B, 5347KM Oss, Netherlands.

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.