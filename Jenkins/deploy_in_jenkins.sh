echo ${Branches}
echo ${domain_name}
echo ${Rollback}

array=${domain_name}

#####################Ansible########################
if [ "${Rollback}" = "true" ];then
sshpass ssh -p 22 -o StrictHostKeyChecking=no -o ConnectTimeout=60 -o ServerAliveInterval=60  root@192.168.10.100  -T << EOF
hostname
whoami
rm -f /home/ansistrano/var/main_rollback.yml
echo "---" >> /home/ansistrano/var/main_rollback.yml
echo " " >> /home/ansistrano/var/main_rollback.yml
echo "ansistrano_rollback_to_release: ${Rollback_version}" >> /home/ansistrano/var/main_rollback.yml
echo "domain_name: ${domain_name}" >> /home/ansistrano/var/main_rollback.yml
ansible-playbook /home/ansistrano/playbook-rollback.yml
EOF
else
for Domain in ${array[@]};do
echo "########################(TASK STARTED: ${Domain}##########################)"
sshpass ssh -p 22 -o StrictHostKeyChecking=no -o ConnectTimeout=60 -o ServerAliveInterval=60  root@192.168.10.100  -T << EOF
hostname
whoami
rm -f /home/ansistrano/var/main_deploy.yml
echo "---" >> /home/ansistrano/var/main_deploy.yml
echo " " >> /home/ansistrano/var/main_deploy.yml
echo "git_repo: https://ecg.eclasscloud.hk/gordonkccheung/ipx.git" >> /home/ansistrano/var/main_deploy.yml
echo "git_branch: ${Branches}" >> /home/ansistrano/var/main_deploy.yml
echo "domain_name: ${domain_name}" >> /home/ansistrano/var/main_deploy.yml
ansible-playbook /home/ansistrano/playbook-deploy.yml
EOF
done
fi
