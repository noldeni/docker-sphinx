FROM ubuntu:16.04
MAINTAINER Jeremy Nicklas <jeremywnicklas@gmail.com>

# Install missing apt-utils first to avoid warnings
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update && apt-get install --yes --no-install-recommends \
    apt-utils
# Set up requirements
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get install --yes --no-install-recommends \
    default-jre \
    graphviz \
    python \
    ghostscript \
    pandoc\
    pandoc-citeproc\
    texlive \
    texlive-fonts-recommended \
    texlive-font-utils \
    texlive-lang* \
    texlive-latex-extra \
    texlive-latex-recommended \
    build-essential \
    wget \
    git \
  && apt-get autoremove -y \
  && rm -fr /var/cache/* \
  && rm -fr /var/lib/apt/lists/*

# Install PlantUML (old)
#RUN wget -O /opt/plantuml.jar "https://sourceforge.net/projects/plantuml/files/plantuml.jar" --no-check-certificate \
#  && printf '#!/bin/sh -e\njava -jar /opt/plantuml.jar "$@"' > /usr/local/bin/plantuml \
#  && chmod 755 /usr/local/bin/plantuml
# Install PlantUML
RUN wget -O /opt/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.1.2018.2.jar/download" --no-check-certificate \
  && printf '#!/bin/sh -e\njava -jar /opt/plantuml.jar "$@"' > /usr/local/bin/plantuml \
  && chmod 755 /usr/local/bin/plantuml

# Install Sphinx and extras
RUN wget -O /tmp/get-pip.py "https://bootstrap.pypa.io/get-pip.py" \
  && python /tmp/get-pip.py \
  && rm /tmp/get-pip.py \
  && pip install Sphinx \
    pyyaml \
    Pillow \
    alabaster \
    sphinx_bootstrap_theme \
    sphinx_rtd_theme \
    cloud_sptheme \
    t3SphinxThemeRtd \
    t3fieldlisttable \
    t3tablerows \
    t3targets \
    recommonmark \
    sphinx-autobuild \
    sphinx-prompt \
    sphinxcontrib-actdiag \
    sphinxcontrib-blockdiag \
    sphinxcontrib-nwdiag \
    sphinxcontrib-seqdiag \
    sphinxcontrib-plantuml \
    sphinxcontrib-exceltable \
    sphinxcontrib-googleanalytics \
    sphinxcontrib-googlechart \
    sphinxcontrib-googlemaps \
    sphinxcontrib-httpdomain \
    sphinxcontrib-fulltoc

# Stop Java from writing files in documentation source
ENV HOME /home
ENV _JAVA_OPTIONS -Duser.home=${HOME}

WORKDIR /doc
