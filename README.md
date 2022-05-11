# ippnetworkprinting
Network Printer Scanning and Printing via IPP

[NO SUPPORT/Issues/Pull requests, consider this repository abandoned]

Idea from

https://www.reddit.com/r/selfhosted/comments/ug4e1d/what_is_a_selfhostable_service_you_wish_existed/i6zcif7/?context=3

Based on 

https://gitlab.com/aapjeisbaas/pdf-to-ipp

and

https://hub.docker.com/r/aapjeisbaas/pdf-to-ipp

Scanning Network Printer via Nmap every 10 Minutes via Cron

Docker Container must run on Host-Network

Environment-Variable NETWORKIPRANGE must be set (usually something like 192.168.x.1)

Device-Name by snmpget

http://deviceip:5000 to access the web-ui

I don't really know docker or python, so this is a really whacky solution. 

Does it work with multiple printers ? i don't know

Is it secure ? probably not

Currently only pdfs can be printed, because conversion would require something like a headless libreoffice-container or some kind of external api
