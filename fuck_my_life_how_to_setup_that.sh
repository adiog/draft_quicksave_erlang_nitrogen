#!/bin/bash

find . -name "dynamic_route_handler.erl" -exec sed -e 's#SmartExtensions = wf:config_default(smart_extensions, \[\])#SmartExtensions = wf:config_default(smart_extensions, [{"json", json_main, {nitrogen_smart_extensions, json}}])#g' -i {} \;