# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source local definitions
# (Place all new stuff here!)
if [ -d ${HOME}/.bashrc.d ]; then
	for file in ${HOME}/.bashrc.d/*; do
		source "${file}"
	done
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
