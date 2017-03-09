#
# Makefile bash-lastdir
# (c) 2017  Jean-Michel PARIS
#

# Variables
ECHO_CMD	=	$(shell which echo)
TEST_CMD	=	$(shell which test)
CAT_CMD		=	$(shell which cat)
CP_CMD		=	$(shell which cp)

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
			$(ECHO_CMD) "lastdir already installed in $(BASH_LOGOUT)!" ; \
		else \
			# append lastdir to .bash_logout \
			$(ECHO_CMD) "$(BASH_LOGOUT) append" ; \
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
			$(ECHO_CMD) "lastdir already installed in $(BASH_PROFILE)!" ; \
		else \
			# append lastdir to .bash_profile \
			$(ECHO_CMD) "$(BASH_PROFILE) append" ; \
			$(CAT_CMD) ./$(BASH_PROFILE).append >> ~/$(BASH_PROFILE) ; \
		fi ; \
	else \
		# copy a new .bash_profile \
		$(ECHO_CMD) "$(BASH_PROFILE) copy" ; \
		$(CP_CMD)  ./$(BASH_PROFILE).append ~/$(BASH_PROFILE) ; \
	fi ;

uninstall:
	@$(ECHO_CMD) "uninstall lastdir functionnality"