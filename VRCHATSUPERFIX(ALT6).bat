@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
call service.bat status_zapret
call service.bat check_updates
call service.bat load_game_filter
echo:

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

rem === ВСЕ IP и ВСЕ ПОРТЫ (без hostlist/ipset) ===
start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=1-65535 --wf-udp=1-65535 --filter-udp=443 --hostlist="%LISTS%list-meta-domains.txt" --dpi-desync=fake --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --dpi-desync-repeats=6 --dpi-desync-cutoff=n2 --new --filter-tcp=80 --hostlist="%LISTS%list-meta-domains.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-cutoff=n2 --new --filter-tcp=443 --hostlist="%LISTS%list-meta-domains.txt" --dpi-desync=fake,split2 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-cutoff=n2 --new --filter-udp=1-65535 --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --dpi-desync-repeats=6 --dpi-desync-cutoff=n2 --new --filter-tcp=1-65535 --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-cutoff=n2
