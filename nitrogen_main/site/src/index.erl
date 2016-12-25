%% -*- mode: nitrogen -*-
% This file is a part of quicksave project.
% Copyright (c) 2016 Aleksander Gajewski <adiog@brainfuck.pl>.

-module (index).
-author("Aleksander Gajewski <adiog@brainfuck.pl>").

%% API
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-import(wf_context, [url/0]).
-import(dependency_factory, [get_item_table/0]).
main() -> #template { file="./site/templates/bare.html" }.

title() -> "quicksave.io erlang edition".

body() ->
    #container_12 { body=[
        #grid_8 { alpha=true, prefix=2, suffix=2, omega=true, body=inner_body() }
    ]}.


inner_body() -> 
    [
        #h1 { text=url() },
        #p{},
        "
        If you can see this page, then your Nitrogen server is up and
        running. Click the button below to test postbacks.
        ",
        #p{}, 	
        #button { id=button, text="Click me!", postback=click },
		#p{},
        "
        Run <b>./bin/dev help</b> to see some useful developer commands.
        ",
		#p{},
		"
		<b>Want to see the ",#link{text="Sample Nitrogen jQuery Mobile Page",url="/mobile"},"?</b>
		"
    ].
	
event(click) ->
    wf:replace(button, #panel { 
        body="You clicked the button!", 
        actions=#effect { effect=highlight }
    }).

json_main() -> [abc, def].