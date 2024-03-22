FROM emscripten/emsdk:3.1.56

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        ragel \
        patch \
        libtool \
        itstool \
        pkg-config \
        python3 \
        python3-ply \
        gettext \
        autopoint \
        automake \
        autoconf \
        m4 \
        gperf \
        licensecheck \
        gawk \
    && apt-get clean autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# HACK: Update licensecheck (3.3.0+) to fix UTF-8 encoding errors
COPY docker/kinetic.pref /etc/apt/preferences.d/
COPY docker/kinetic.list /etc/apt/sources.list.d/
RUN apt update && apt install -y --no-install-recommends licensecheck \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /code
CMD ["make"]
