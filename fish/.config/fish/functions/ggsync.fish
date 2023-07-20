function ggsync --description 'Run gpr then ggp to sync Gerrit with patches.'
gsw patches \
&& gpr \
&& ggp
end
