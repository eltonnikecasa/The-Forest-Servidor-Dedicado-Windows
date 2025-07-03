@echo off
cd /d "C:\theforest-server"
start TheForestDedicatedServer.exe -batchmode -nographics -serverip SEU_IP_EXTERNO -serversteamport 8766 -servergameport 27015 -serverqueryport 27016 -servername NomeDoServidor -serverplayers 15 -difficulty Normal -initType Continue -slot 1 -serverpassword SUA_SENHA -serverpassword_admin SUA_SENHA_ADMIN -savepath "C:\theforest-server\ds" -serverAutoSaveInterval 5 -allowCheats off -enableVAC on
