SUBDIRS = tools libs loader server dlls programs include fonts documentation

EXTRA_DIST = goliath-launch.sh

# The 'wine' symlink to goliath binary in loader/
all-local:
	@echo "Goliath/Wine build complete."
	@echo "Run 'make install' to install."

# Create wine symlink for compatibility
install-exec-hook:
	cd $(DESTDIR)$(bindir) && $(LN_S) -f goliath wine || true

