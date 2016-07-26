#!/bin/sh
gotty -w /bin/sh &
nginx -g 'pid /tmp/nginx.pid; daemon off;'
