### disable password prompt for poweroff ###
echo "[Allow all users to shutdown]
Identity=unix-user:*
Action=org.freedesktop.login1.power-off-multiple-sessions
ResultAny=yes
ResultActive=yes
[Allow all users to reboot]
Identity=unix-user:*
Action=org.freedesktop.login1.reboot-multiple-sessions
ResultAny=yes
ResultActive=yes
[Allow all users to suspend]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend-multiple-sessions
ResultAny=yes
ResultActive=yes
[Allow all users to ignore inhibit of shutdown]
Identity=unix-user:*
Action=org.freedesktop.login1.power-off-ignore-inhibit
ResultAny=yes
ResultActive=yes
[Allow all users to ignore inhibit of reboot]
Identity=unix-user:*
Action=org.freedesktop.login1.reboot-ignore-inhibit
ResultAny=yes
ResultActive=yes
[Allow all users to ignore inhibit of suspend]
Identity=unix-user:*
Action=org.freedesktop.login1.suspend-ignore-inhibit
ResultAny=yes
ResultActive=yes
" | sudo tee /etc/polkit-1/localauthority/50-local.d/nofurtherlogin.pkla
