
-module(flower_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, {{one_for_one, 5, 10}, [
								 ?CHILD(flower_event, worker),
								 ?CHILD(flower_dispatcher, worker),
								 ?CHILD(flower_mac_learning, worker),
								 ?CHILD(flower_component_sup, supervisor),
								 ?CHILD(flower_datapath_sup, supervisor),
								 ?CHILD(flower_tcp_socket, worker)
								]} }.

