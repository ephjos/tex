FROM archlinux

# Install packages
RUN \
  pacman -Sy --noconfirm \
    base-devel curl git htop man unzip vim wget \
    fontconfig texlive-most

WORKDIR /mounted

# Copy fonts into system fonts directory
COPY ./fonts/*.ttc /usr/share/fonts/opentype/

# Update font cache
RUN fc-cache -f -v

# Define default command.
CMD ["bash"]

