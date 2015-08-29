FROM alpine:3.1
MAINTAINER CenturyLink Labs <clt-labs-futuretech@centurylink.com>

RUN apk update && apk add ruby-dev ca-certificates
ADD badge-monitor.rb /usr/src/app/badge-monitor.rb

ENTRYPOINT ["/usr/src/app/badge-monitor.rb"]
