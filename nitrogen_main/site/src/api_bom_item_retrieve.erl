%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module (api_bom_item_retrieve).
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

dispatch_item_retrieve_request() ->
    {ItemId, _} = string:to_integer(wf:q(item_id)),
    #item_retrieve_request{
        item_id=ItemId
    }.

json_main() ->
    Transaction = apply(dependency_factory:get_item_table(), get_table_name, []),
    User = wf:user(),
    ItemRetrieveRequest = dispatch_item_retrieve_request(),
    do_retrieve(engine_authorization_item:is_authorized_to_retrieve(Transaction, User, ItemRetrieveRequest), Transaction, User, ItemRetrieveRequest).

do_retrieve(false, _Transaction, _User, _ItemRetrieveRequest) -> [{status, failed}, {message, not_authorized}];
do_retrieve(true, Transaction, User, ItemRetrieveRequest) ->
    [{_,Item}] = engine_action_item:retrieve(Transaction, User, ItemRetrieveRequest),
    [{status, success}, {item, record_as_tuple_list(Item)}].

record_as_tuple_list(Item) -> [
    {item_id, Item#item.item_id},
    {user_id, Item#item.user_id},
    {item_type, Item#item.item_type},
    {title, Item#item.title},
    {url, Item#item.url},
    {freetext, Item#item.freetext},
    {author, Item#item.author},
    {source_title, Item#item.source_title},
    {source_url, Item#item.source_url},
    {timestamp, Item#item.timestamp}].