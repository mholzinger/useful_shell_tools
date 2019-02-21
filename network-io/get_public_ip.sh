#!/bin/bash

purple_drank=$(curl -s icanhazip.com);
echo ipv4=\($purple_drank\)

purple_drankz=$(curl -s icanhazip.com -6);
echo ipv6=\($purple_drankz\)
