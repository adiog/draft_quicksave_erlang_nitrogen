%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module(api_bom_item_create).
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

dispatch_item_create_request() ->
    #item_create_request{
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
    ItemCreateRequest = dispatch_item_create_request(),
    User = wf:user(),
    do_create(Transaction, User, ItemCreateRequest).

do_create(_, undefined, _) -> [{status, failure}, {message, not_logged}];
do_create(Transaction, User, ItemCreateRequest) ->
    ItemId = engine_action_item:create(Transaction, User, ItemCreateRequest),
    [{status, success}, {item_id, ItemId}].
