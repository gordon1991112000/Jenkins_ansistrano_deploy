##################Update ecg repo from mis-git######################
cd /tmp
rm -rf ipx
git clone git@git2.broadlearning.com:IPX/ipx.git
cd ipx
git remote rename origin upstream
git remote add origin git@ecg.eclasscloud.hk:gordonkccheung/ipx.git
git push -f origin develop:main              #######push to specific branch: git push origin localBranchName:remoteBranchName

echo ${domain_name}
if [ "${Batches}" = "true" ];then
  array=${batch_domain_name}
else
  array=${domain_name}
fi

##################Terminate php artisan domain########################
for Domains in ${array[@]};do
sed -i "s/domain=.*/domain=$Domains'/" /home/script/update_ipx/terminate_domain.sh
scp -p /home/script/update_ipx/terminate_domain.sh 192.168.10.100:/home/ansistrano/script/
sshpass ssh -p 22 -o StrictHostKeyChecking=no -o ConnectTimeout=60 -o ServerAliveInterval=60  root@192.168.10.100  -T << EOF
/home/ansistrano/script/terminate_domain.sh
EOF
done

##################Update composer##################
#sshpass ssh -p 22 -o StrictHostKeyChecking=no -o ConnectTimeout=60 -o ServerAliveInterval=60  root@192.168.10.100  -T << EOF
#/home/ansistrano/script/Laravel_Composer_Npm_Install.sh
#EOF

##################Update IPX#######################
for Domain in ${array[@]};do
echo "########################(TASK STARTED: ${Domain}##########################)"
sshpass ssh -p 22 -o StrictHostKeyChecking=no -o ConnectTimeout=60 -o ServerAliveInterval=60  root@192.168.10.100  -T << EOF
hostname
whoami
rm -f /home/ansistrano/var/main_update.yml
echo "git_repo: https://ecg.eclasscloud.hk/gordonkccheung/ipx.git" >> /home/ansistrano/var/main_update.yml
echo "git_branch: ${Branches}" >> /home/ansistrano/var/main_update.yml
echo "domain_name: ${Domain}" >> /home/ansistrano/var/main_update.yml
sed -i "/laravel/s|laravel.*|laravel\_update\.sh ${Domain}\"|" /root/.ansible/roles/ansistrano.deploy/tasks/playbook-after-update.yml
ansible-playbook /home/ansistrano/playbook-update.yml
EOF
done

##################Update shared/storage/app#######################
cd /tmp/ipx/storage/app
scp -pr public 192.168.10.100:/tmp
sshpass ssh -p 22 -o StrictHostKeyChecking=no -o ConnectTimeout=60 -o ServerAliveInterval=60  root@192.168.10.100  -T << EOF
hostname
whoami
cd /tmp
chmod 777 -R public/
scp -pr public 10.0.80.81:/home/nfs/ipx/shared/storage/app
EOF
