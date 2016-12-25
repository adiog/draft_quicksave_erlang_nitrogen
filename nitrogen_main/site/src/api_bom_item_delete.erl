%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module (api_bom_item_delete).
-author("Aleksander Gajewski <adiog@brainfuck.pl>").

%% API
-compile(export_all).


-include_lib("nitrogen_core/include/wf.hrl").
-include_lib("quicksave_erlang_engine/include/engine_bom_item.hrl").
-include_lib("quicksave_erlang_engine/include/engine_request_item.hrl").
-import(wf_context, [url/0]).


main() -> #template { file="./site/templates/bare.html" }.

title() -> "quicksave.io erlang edition".

body() -> "Use json API".

dispatch_item_delete_request() ->
    {ItemId, _} = string:to_integer(wf:q(item_id)),
    #item_delete_request{
        item_id=ItemId
    }.

json_main() ->
    Transaction = apply(dependency_factory:get_item_table(), get_table_name, []),
    User = wf:user(),
    ItemDeleteRequest = dispatch_item_delete_request(),
    do_delete(engine_authorization_item:is_authorized_to_delete(Transaction, User, ItemDeleteRequest), Transaction, User, ItemDeleteRequest).

do_delete(false, _Transaction, _User, _ItemDeleteRequest) -> [{status, failed}, {message, not_authorized}];
do_delete(true, Transaction, User, ItemDeleteRequest) ->
    engine_action_item:delete(Transaction, ItemDeleteRequest),
    [{status, success}].

