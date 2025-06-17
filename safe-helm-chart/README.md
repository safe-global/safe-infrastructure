This is a first attempt in deploying the Safe infrastructure in Kubernetes [specifically EKS] using Helm.

### Notes

- The k8s resources are set up in two groups basically. The common ones and the chain-specific ones.
The common ones are the common for all chains.  
The chain-specific, are gathered in the `templates/chain-specific` folder. In order to set up the chains that you wanna use, go to 
the `values.yaml` file.  


- The custom storage class has been created in order to give the choice to preserve the volumes created by specific components. You can enable/disable it on demand in the `values.yaml` file.


- You can deploy the hem chart using 
```commandline
helm upgrade --install mysafe ./safe-helm-chart --values values_for_alb_ingress.yaml
```


- This is an early under heavy development version! Be kind :]