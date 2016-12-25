%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module(api_auth_login).
-author("Aleksander Gajewski <adiog@brainfuck.pl>").

%% API
-compile(export_all).


-include_lib("nitrogen_core/include/wf.hrl").
-include_lib("quicksave_erlang_engine/include/engine_authentication_user.hrl").
-import(wf_context, [url/0]).
-import(dependency_factory, [get_item_table/0]).


main() -> #template { file="./site/templates/bare.html" }.

title() -> "quicksave.io erlang edition".

body() -> "Use json API (add .json suffix to URL).".

json_main() ->
    authenticate(wf:q(username), wf:q(password)).

authenticate("testuser", "testpass") ->
    User = #user{user_id=7, username="testuser"},
    wf:user(User),
    [{status, success}, {username, list_to_atom(User#user.username)}];
authenticate(Username, Password) ->
    wf:clear_user(),
    [{status, failed}].