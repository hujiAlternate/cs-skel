#!/bin/csh -f

#don't use csh, bash rules!
if ( -x /bin/bash ) then
   /bin/bash
   #when bash finished, exit.
   kill -9 $$
endif

#
# Personal C shell customizations
# Read at start of execution of each C shell
#
echo $0 >> ~/cshlog
# No core dumps
limit coredumpsize 0

# default permissions of newly created files and directories
# - deny all others directory-access and write permissions
umask 077

# Site-wide C shell customizations  -- DO NOT DELETE!
if ( -e /cs/share/skel/cshrc.site ) source /cs/share/skel/cshrc.site

# Environment variables
setenv	PAGER		less		# use 'less' rather then 'more'
setenv	EDITOR		pluma      
setenv	PRINTER 	st
setenv	BLOCKSIZE	1k

if (-e ~/.classpath) source ~/.classpath # sets java's CLASSPATH 

# If non-interactive, exit
if (! $?prompt) exit 0

# If interactive, switch over to Enhanced C shell

if (! $?tcsh) then
	foreach dir ($path)
		if ($dir =~ .*) continue
		if (-x $dir/tcsh) then
			set tcshpath = $dir/tcsh
			break
		endif
	end
	if ($?tcshpath) then
		setenv SHELL $tcshpath
		exec tcsh $argv
	endif
endif

# -------------------------------------------------
# Interactive C shell customizations

# Fancy aliases
if (-e ~/.aliases) source ~/.aliases

# Shell variables
#set savehist=200	# on logout, save last 200 commands in ~/.history 
set history=500		# remember last 500 commands
set inputmode=insert	# or '=overwrite'
set notify		# notify at once when a background job terminates
set noclobber		# to overwrite a file, must use '>!', not '>'
set ignoreeof		# to logout, must use 'exit', not Ctl-D
#set correct=cmd		# or '=all'. Try to correct typing errors
set autoexpand
set autolist		# so <tab> lists possible completions (like Ctl-D)
set listmax=500		# so autolistings don't clutter screen
set pushdtohome		# pushd without arguments does 'pushd ~'

# shell checks mail every 60 secs
set mail = (60 /cs/mail/$user /cs/spam/$user)

# Show a fortune cookie
if ( -x /usr/games/fortune ) then
   /usr/games/fortune
endif
