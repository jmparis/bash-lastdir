#
# Makefile bash-lastdir
# (c) 2017  Jean-Michel PARIS
#

# Variables
ECHO_CMD	=	$(shell which echo)
TEST_CMD	=	$(shell which test)
CAT_CMD		=	$(shell which cat)
CP_CMD		=	$(shell which cp)
MV_CMD		=	$(shell which mv)
RM_CMD		=	$(shell which rm)
AWK_CMD		=	$(shell which awk)
DIFF_CMD	=	$(shell which diff)

BASH_LOGOUT	=	.bash_logout
BASH_PROFILE=	.bash_profile

help:
	@$(ECHO_CMD) ""
	@$(ECHO_CMD) "Targets available"
	@$(ECHO_CMD) ""
	@$(ECHO_CMD) "make help		This help."
	@$(ECHO_CMD) ""
	@$(ECHO_CMD) "make install		Install the lastdir functionnality in your Bash environment."
	@$(ECHO_CMD) "make uninstall		Remove the lastdir functionnality from your Bash configuration files"
	@$(ECHO_CMD) ""

install:
	@$(ECHO_CMD) ""
	@if $(TEST_CMD) -f ~/$(BASH_LOGOUT) ; \
	then \
		# search lastdir functionnality ; \
		grep --quiet "BEGIN lastdir" ~/$(BASH_LOGOUT) ; \
		if $(TEST_CMD) $$? -eq 0 ; \
		then \
			# lastdir already installed \
			$(ECHO_CMD) "lastdir is already installed in $(BASH_LOGOUT)!" ; \
		else \
			# append lastdir to .bash_logout \
			$(ECHO_CMD) "lastdir added to $(BASH_LOGOUT)" ; \
			$(CAT_CMD) ./$(BASH_LOGOUT).append >> ~/$(BASH_LOGOUT) ; \
		fi ; \
	else \
		# copy a new .bash_logout \
		$(ECHO_CMD) "$(BASH_LOGOUT) copy" ; \
		$(CP_CMD)  ./$(BASH_LOGOUT).append ~/$(BASH_LOGOUT) ; \
	fi ;
	@if $(TEST_CMD) -f ~/$(BASH_PROFILE) ; \
	then \
		# search lastdir functionnality \
		grep --quiet "BEGIN lastdir" ~/$(BASH_PROFILE) ; \
		if $(TEST_CMD) $$? -eq 0 ; \
		then \
			# lastdir already installed \
			$(ECHO_CMD) "lastdir is already installed in $(BASH_PROFILE)!" ; \
		else \
			# append lastdir to .bash_profile \
			$(ECHO_CMD) "lastdir added to $(BASH_PROFILE)" ; \
			$(CAT_CMD) ./$(BASH_PROFILE).append >> ~/$(BASH_PROFILE) ; \
		fi ; \
	else \
		# copy a new .bash_profile \
		$(ECHO_CMD) "$(BASH_PROFILE) copy" ; \
		$(CP_CMD)  ./$(BASH_PROFILE).append ~/$(BASH_PROFILE) ; \
	fi ;

uninstall:
	@$(ECHO_CMD) ""
	@$(AWK_CMD) 'BEGIN{found=0; lastdir=0;} /BEGIN lastdir/{found=1; lastdir=1;} {if(!found) print} /END lastdir/{found=0;} END{ exit !lastdir; }' ~/$(BASH_PROFILE) > ~/$(BASH_PROFILE).filtered ; \
	if $(TEST_CMD) $$? -eq 1 ; \
	then \
		$(RM_CMD) -f ~/$(BASH_PROFILE).filtered ; \
		$(ECHO_CMD) "lastdir is not installed in $(BASH_PROFILE)" ; \
	else \
		$(MV_CMD) ~/$(BASH_PROFILE).filtered ~/$(BASH_PROFILE) ; \
		$(ECHO_CMD) "lastdir removed from $(BASH_PROFILE)" ; \
	fi ;
	@$(AWK_CMD) 'BEGIN{found=0; lastdir=0;} /BEGIN lastdir/{found=1; lastdir=1;} {if(!found) print} /END lastdir/{found=0;} END{ exit !lastdir; }' ~/$(BASH_LOGOUT)  > ~/$(BASH_LOGOUT).filtered ; \
	if $(TEST_CMD) $$? -eq 1 ; \
	then \
		$(RM_CMD) -f ~/$(BASH_LOGOUT).filtered ; \
		$(ECHO_CMD) "lastdir is not installed in $(BASH_LOGOUT)" ; \
	else \
		$(MV_CMD) ~/$(BASH_LOGOUT).filtered ~/$(BASH_LOGOUT) ; \
		$(ECHO_CMD) "lastdir removed from $(BASH_LOGOUT)" ; \
	fi ;