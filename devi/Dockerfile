FROM debian
RUN apt-get update && apt-get install -y sudo g++ vim git

ARG hostgid
ARG hostgrp
RUN groupdel `cat /etc/group | grep $hostgid | cut -d: -f1`
RUN groupdel $hostgrp
RUN groupadd -g $hostgid $hostgrp

ARG hostuser
ARG hostuid
RUN useradd -u $hostuid -g $hostgid $hostuser

CMD ["/bin/bash"]

