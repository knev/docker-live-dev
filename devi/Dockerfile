FROM debian
RUN apt-get update && apt-get install -y sudo g++ vim git

ARG hostgid
ARG hostgrp
RUN getent group $hostgid >/dev/null && groupdel `getent group $hostgid | cut -d: -f1`
RUN getent group $hostgrp >/dev/null && groupdel $hostgrp
RUN groupadd -g $hostgid $hostgrp

ARG hostuser
ARG hostuid
RUN useradd -u $hostuid -g $hostgid $hostuser

CMD ["/bin/bash"]

