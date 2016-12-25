%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module(api_auth_status).
-author("Aleksander Gajewski <adiog@brainfuck.pl>").

%% API
-compile(export_all).


-include_lib("nitrogen_core/include/wf.hrl").
-include_lib("quicksave_erlang_engine/include/engine_authentication_user.hrl").
-import(wf_context, [url/0]).
-import(dependency_factory, [get_item_table/0]).


json_main() ->
    user_status(wf:user()).

user_status(undefined) -> [{status, failure}];
user_status(User) -> [{status, success}, {username, list_to_atom(User#user.username)}].