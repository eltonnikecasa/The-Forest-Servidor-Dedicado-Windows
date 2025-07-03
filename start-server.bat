@echo off
cd /d "C:\theforest-server"
start TheForestDedicatedServer.exe -batchmode -nographics -serverip SEU_IP_EXTERNO -serversteamport 8766 -servergameport 27015 -serverqueryport 27016 -servername NomeDoServidor -serverplayers 15 -difficulty Normal -inittype Continue -slot 1 -serverpassword SUA_SENHA
