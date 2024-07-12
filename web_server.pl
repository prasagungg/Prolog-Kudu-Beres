:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).

% Define the server port
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

% Define the routes
:- http_handler(root(''), home_page, []).
:- http_handler(root('login'), login_page, []).

% Home page handler
home_page(_Request) :-
    serve_file('src/index.html').

% Login page handler
login_page(_Request) :-
    serve_file('src/login.html').

% Helper predicate to serve HTML files
serve_file(FilePath) :-
    read_file_to_string(FilePath, FileContent, []),
    format('Content-type: text/html~n~n'),
    format('~s', [FileContent]).

% Entry point to start the server
:- initialization(server(8080)).
