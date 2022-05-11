# ippnetworkprinting
Network Printer Scanning and Printing via IPP

Based on 

https://gitlab.com/aapjeisbaas/pdf-to-ipp
https://hub.docker.com/r/aapjeisbaas/pdf-to-ipp

Scanning Network Printer via Nmap every 10 Minutes via Cron
Docker Container must run on Host-Network
Environment-Variable NETWORKIPRANGE must be set (usually something like 192.168.x.1)
Device-Name by snmpget

I don't really know docker or python, so this is a really whacky solution. 

Does it work with multiple printers ? i don't know
Is it secure ? probably not

Currently only pdfs can be printed, because conversion would require something like a headless libreoffice-container or some kind of external api
