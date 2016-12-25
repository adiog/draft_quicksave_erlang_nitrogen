%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module (api_bom_item_update).
-author("Aleksander Gajewski <adiog@brainfuck.pl>").

%% API
-compile(export_all).


-include_lib("nitrogen_core/include/wf.hrl").
-include_lib("quicksave_erlang_engine/include/engine_bom_item.hrl").
-include_lib("quicksave_erlang_engine/include/engine_request_item.hrl").
-import(wf_context, [url/0]).
-import(dependency_factory, [get_item_table/0]).
-import(engine_authorization_item, [is_authorized_to_update/3]).


main() -> #template { file="./site/templates/bare.html" }.

title() -> "quicksave.io erlang edition".

body() -> "Use json API".

dispatch_item_update_request() ->
    {ItemId, _} = string:to_integer(wf:q(item_id)),
    #item_update_request{
        item_id=ItemId,
        item=#item{
            item_type=wf:q(item_type),
            title=wf:q(title),
            url=wf:q(url),
            freetext=list_to_atom(wf:q(freetext)),
            author=wf:q(author),
            source_title=wf:q(source_title),
            source_url=wf:q(source_url)
        }}.

json_main() ->
    Transaction = apply(dependency_factory:get_item_table(), get_table_name, []),
    User = wf:user(),
    ItemUpdateRequest = dispatch_item_update_request(),
    do_update(is_authorized_to_update(Transaction, User, ItemUpdateRequest), Transaction, User, ItemUpdateRequest).

do_update(false, _Transaction, _User, _ItemUpdateRequest) -> [{status, failed}, {message, not_authorized}];
do_update(true, Transaction, User, ItemUpdateRequest) ->
    ItemId = engine_action_item:update(Transaction, User, ItemUpdateRequest),
    [{status, success}, {item_id, ItemId}].

