FROM ubuntu:22.04

ENV ARCHI_VERSION=5.3.0
ENV COARCHI_VERSION=0.9.2

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends dbus-x11 at-spi2-core \
	libswt-gtk-4-jni \
	xvfb wget openssh-client rsync ca-certificates tar xzip gzip bzip2 zip unzip make && \
		rm -rf /var/lib/apt/lists && \
		mkdir -p /usr/share/desktop-directories 

# Install Archi https://www.archimatetool.com/downloads/archi/
RUN  wget --post-data="dl=${ARCHI_VERSION}/Archi-Linux64-${ARCHI_VERSION}.tgz" "https://www.archimatetool.com/downloads/archi/archive/${ARCHI_VERSION}/Archi-Linux64-${ARCHI_VERSION}.tgz" && \
		tar zxvf "Archi-Linux64-${ARCHI_VERSION}.tgz" -C /opt/ && \
		rm "Archi-Linux64-${ARCHI_VERSION}.tgz" && \
		chmod +x /opt/Archi/Archi && \
		mkdir -p /root/.archi4/dropins

# Install CoArchi plugin 
# RUN wget "https://www.archimatetool.com/downloads/coarchi/coArchi_${COARCHI_VERSION}.archiplugin" && \
#     unzip "coArchi_${COARCHI_VERSION}.archiplugin" -d /root/.archi4/dropins && \
# 	rm "coArchi_${COARCHI_VERSION}.archiplugin" /root/.archi4/dropins/archi-plugin

# User space by default
VOLUME [ /data ]		

# Entrypoint and prepare settings overwrite
COPY entrypoint.sh /entrypoint.sh
COPY archi-wrapper.sh /opt/Archi/archi-wrapper.sh
RUN chmod +x /entrypoint.sh && \
	chmod +x /opt/Archi/archi-wrapper.sh && \
	ln -s /opt/Archi/archi-wrapper.sh /usr/local/bin/archiapp

# ARG UID=1000
# RUN set -eux; \
#     # mv /root/.archi /archi/; \
#     groupadd --gid "$UID" archi; \
#     useradd --uid "$UID" --gid archi --shell /bin/bash \
#       --home-dir /archi --create-home archi; \
#     mkdir -p /archi/app; \
#     chown -R "$UID:0" /archi; \
#     chmod -R g+rw /archi;
# USER archi

WORKDIR /data

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "archi", "--help" ]

