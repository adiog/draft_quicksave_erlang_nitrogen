%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module(api_auth_logout).
-author("Aleksander Gajewski <adiog@brainfuck.pl>").

%% API
-compile(export_all).


-include_lib("nitrogen_core/include/wf.hrl").
-import(wf_context, [url/0]).
-import(dependency_factory, [get_item_table/0]).


json_main() ->
    wf:clear_user(),
    [{status, success}].
