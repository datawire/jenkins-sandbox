# Jenkins Sandbox

Easy to use Jenkins test environment for use with Docker and Kubernetes.

## Getting Started

### 1. Run the Jenkins Server

```bash
minikube start
kubectl apply -f jenkins-ns.yaml
kubectl apply -f jenkins.yaml
```

### 2. Connect to the UI

The below command will get you the IP of the Jenkins UI:

`minikube service jenkins-ui --url --namespace jenkins`

### Share Jenkins with someone else

Sometimes it's useful to be able to to share your private jenkins or make it available on the public internet (e.g. for webhook testing). I recommend using [ngrok](https://ngrok.com/):

`ngrok http (minikube service jenkins-ui --url --namespace jenkins | sed 's~http[s]*://~~g')`

If you have a paid ngrok account you can setup a stable su bdomain for use this way:

`ngrok http -subdomain=<NAME> (minikube service jenkins-ui --url --namespace jenkins | sed 's~http[s]*://~~g')`

For example I usually use:

`ngrok http -subdomain=jenkins-$USER (minikube service jenkins-ui --url --namespace jenkins | sed 's~http[s]*://~~g')`

## License

Project is open-source software licensed under Apache 2.0. Please see [License](LICENSE) for further details.


