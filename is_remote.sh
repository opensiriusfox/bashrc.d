# Detect if the current session is running on a remote server by listing parent
# processes of this shell and checking for things like sshd/tailscaled. Runs
# first because multiple other things rely on this.


function __is_remote() {
	# names of daemon processes a remote shell might be a child process of
	remote_daemons=(
	    sshd
	)

	is_remote=()
	parent_procs="$(pstree -s $$)"
	for d in ${remote_daemons[@]}; do
		if [[ "$parent_procs" =~ "$d" ]]; then
			return 1
		fi
	done

	return 0
}
