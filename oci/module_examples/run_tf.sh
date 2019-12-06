#!/bin/bash 

action=${1}


[ $# -eq 0 ] && { 
  echo "Usage: $0 [action: plan/apply/destroy] "; exit 1; 
}

# workspace list with trim
tf_workspaces=$(terraform workspace list | tr -d ' ')

# string to array with space delimiter
tfvar_files=(${tf_workspaces// / })

for workspace in "${tfvar_files[@]}"; do
    if [ -f "env/${workspace/\*/}.tfvars" ]; then
    
        terraform workspace select ${workspace/\*/}
        
        if [ "plan" != "${action}" ]; then
            terraform $action -var-file=env/$(terraform workspace show).tfvars --auto-approve
        else
            terraform $action -var-file=env/$(terraform workspace show).tfvars
        fi
    else
        echo "Omg! There was an error during ${action}"
    fi
done
