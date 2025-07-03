# Configurando Servidor Dedicado do The Forest em VPS Windows (HostM, etc)

Este tutorial explica como configurar e rodar o servidor dedicado do *The Forest* em uma VPS Windows (ex: HostM), especialmente em ambientes que usam NAT e múltiplos IPs internos, onde o arquivo `.cfg` pode não funcionar corretamente.

---

## Por que este método?

- Em VPS com IPs internos e NAT, o servidor pode não anunciar corretamente seu IP externo usando apenas o `.cfg`
- O arquivo `.cfg pode ser ignorado pelo executável em algumas versões/configurações
- Passar todos os parâmetros diretamente via linha de comando garante que o servidor use as configurações corretas

---

## Passo a passo

### 1. Baixe e instale o servidor dedicado

- Baixe o SteamCMD para Windows:  
  [https://developer.valvesoftware.com/wiki/SteamCMD#Windows](https://developer.valvesoftware.com/wiki/SteamCMD#Windows)
- Instale o servidor do The Forest usando SteamCMD, por exemplo:

```bat
steamcmd +login anonymous +force_install_dir "C:\theforest-server" +app_update 556450 validate +quit
```

### 2. Crie um arquivo `.bat` para iniciar o servidor

No diretório do servidor (ex: `C:\theforest-server`), crie um arquivo chamado `start-server.bat` com o conteúdo:

```bat
@echo off
cd /d "C:\theforest-server"
start TheForestDedicatedServer.exe -batchmode -nographics -serverip SEU_IP_EXTERNO -serversteamport 8766 -servergameport 27015 -serverqueryport 27016 -servername "NomeDoServidor" -serverplayers 15 -difficulty Normal -inittype Continue -slot 1 -serverpassword SUA_SENHA
```

> Substitua:  
> - `SEU_IP_EXTERNO` pelo IP público da sua VPS  
> - `"NomeDoServidor"` pelo nome desejado para seu servidor  
> - `SUA_SENHA` pela senha desejada (deixe vazio para público)

---

### 3. Abra as portas necessárias no firewall da VPS

Abra as portas UDP/TCP necessárias para o funcionamento e visibilidade do servidor na internet:

| Porta  | Protocolo | Uso                  |
|--------|-----------|----------------------|
| 27015  | UDP       | Porta principal do jogo |
| 27016  | UDP       | Steam Server Browser  |
| 8766   | UDP       | Steam P2P Networking |
| 27005  | UDP       | Steam Authentication |
| 27015  | TCP       | Conexões Steam (opcional) |

Exemplo para liberar no Windows Firewall via CMD (executar como Administrador):

```bat
netsh advfirewall firewall add rule name="The Forest 27015 UDP" dir=in action=allow protocol=UDP localport=27015
netsh advfirewall firewall add rule name="The Forest 27016 UDP" dir=in action=allow protocol=UDP localport=27016
netsh advfirewall firewall add rule name="The Forest 8766 UDP" dir=in action=allow protocol=UDP localport=8766
netsh advfirewall firewall add rule name="The Forest 27005 UDP" dir=in action=allow protocol=UDP localport=27005
netsh advfirewall firewall add rule name="The Forest 27015 TCP" dir=in action=allow protocol=TCP localport=27015
```

---

### 4. Inicie o servidor

Execute o arquivo `start-server.bat`. O servidor deverá iniciar em modo batch, sem interface gráfica, e anunciar seu IP externo corretamente.

---

### 5. Conecte-se ao servidor

No cliente do The Forest:

- Use a busca por nome do servidor na lista pública  
- Ou conecte direto via IP e porta:  
  ```
  SEU_IP_EXTERNO:27015
  ```

---

## Considerações finais

- Usar o parâmetro `-serverip` é crucial em VPS com NAT/múltiplos IPs, para que o servidor anuncie corretamente o IP público.
- O arquivo `.cfg` pode ser ignorado ou mal interpretado em alguns ambientes.
- Ajuste `-serverplayers` conforme o hardware da VPS (4 GB RAM aguenta até 4-6 jogadores confortavelmente; 15 é possível, mas com riscos de lag).
- Monitore o servidor para evitar travamentos e reinicie periodicamente.

---

## Referências

- [The Forest Dedicated Server Steam Page](https://store.steampowered.com/app/556450/The_Forest_Dedicated_Server/)
- [SteamCMD Documentation](https://developer.valvesoftware.com/wiki/SteamCMD)
- [HostM (HostMF) VPS](https://hostm.com.br) — exemplo de VPS usada

---

Se você gostou, considere deixar uma ⭐ no repositório!

---

**Licença:** MIT © Você
