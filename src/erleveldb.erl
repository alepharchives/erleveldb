-module(erleveldb).
-on_load(init/0).
-define(NOT_LOADED, not_loaded(?LINE)).
-define(i2b(B), iolist_to_binary(B)).

-export([open_db/1, open_db/2]).
-export([put/3, put/4, get/2, get/3, del/2, del/3]).
-export([iter/1, iter/2, seek/2, next/1, prev/1]).
-export([batch/1, wb_put/3, wb_del/2, wb_clear/1, wb_write/1, wb_write/2]).

open_db(_Name) ->
    ?NOT_LOADED.

open_db(_Name, _Opts) ->
    ?NOT_LOADED.

put(_Db, _Key, _Value) ->
    ?NOT_LOADED.

put(_Db, _Key, _Value, _Opts) ->
    ?NOT_LOADED.

get(_Db, _Key) ->
    ?NOT_LOADED.

get(_Db, _Key, _Opts) ->
    ?NOT_LOADED.

del(_Db, _Key) ->
    ?NOT_LOADED.
    
del(_Db, _Key, _Opts) ->
    ?NOT_LOADED.


iter(_Db) ->
    ?NOT_LOADED.

iter(_Db, _Opts) ->
    ?NOT_LOADED.

seek(_Iter, _Key) ->
    ?NOT_LOADED.

next(_Iter) ->
    ?NOT_LOADED.
    
prev(_Iter) ->
    ?NOT_LOADED.


batch(_Db) ->
    ?NOT_LOADED.

wb_put(Wb, Key, Val) when is_binary(Key) andalso is_binary(Val) ->
    wb_put0(Wb, Key, Val);
wb_put(Wb, Key, Val) ->
    wb_put0(Wb, ?i2b(Key), ?i2b(Val)).

wb_del(Wb, Key) when is_binary(Key) ->
    wb_del0(Wb, Key);
wb_del(Wb, Key) ->
    wb_del0(Wb, ?i2b(Key)).

wb_clear(_Wb) ->
    ?NOT_LOADED.

wb_write(_Wb) ->
    ?NOT_LOADED.

wb_write(_Wb, _Opts) ->
    ?NOT_LOADED.

wb_put0(_Wb, _Key, _Val) ->
    ?NOT_LOADED.

wb_del0(_Wb, _Key) ->
    ?NOT_LOADED.


init() ->
    SoName = case code:priv_dir(?MODULE) of
        {error, bad_name} ->
            case filelib:is_dir(filename:join(["..", priv])) of
                true ->
                    filename:join(["..", priv, ?MODULE]);
                _ ->
                    filename:join([priv, ?MODULE])
            end;
        Dir ->
            filename:join(Dir, ?MODULE)
    end,
    erlang:load_nif(SoName, 0).

not_loaded(Line) ->
    exit({not_loaded, [{module, ?MODULE}, {line, Line}]}).
