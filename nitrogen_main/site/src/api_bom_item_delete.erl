%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module (api_bom_item_delete).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-import(wf_context, [url/0]).
-import(dependency_factory, [get_item_table/0]).

main() -> #template { file="./site/templates/bare.html" }.

title() -> "quicksave.io erlang edition".

body() -> "Use json API".

json_main() -> [item_delete_request].
