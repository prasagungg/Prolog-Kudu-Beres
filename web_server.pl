:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).

% Define the server port
server(Port) :-
    http_server(http_dispatch, [port(Port)]).

% Define the routes
:- http_handler('/js/', serve_js, [prefix]).
:- http_handler(root(''), home_page, []).
:- http_handler(root('login'), login_page, []).
:- http_handler(root('add-budget'), add_budget_page, []).
:- http_handler(root('budget'), budget_page, []).
:- http_handler(root('report'), report_page, []).

% Home page handler
home_page(_Request) :-
    serve_file('src/index.html').

% Login page handler
login_page(_Request) :-
    serve_file('src/login.html').

% budget page handler
budget_page(_Request) :-
    serve_file('src/budget.html').

% budget page handler
add_budget_page(_Request) :-
    serve_file('src/add_budget.html').

% Report page handler
report_page(_Request) :-
    serve_file('src/report.html').

% Helper predicate to serve HTML files
serve_file(FilePath) :-
    read_file_to_string(FilePath, FileContent, []),
    format('Content-type: text/html~n~n'),
    format('~s', [FileContent]).

serve_js(Request) :-
    http_reply_from_files('public/js', [], Request).

% Entry point to start the server
:- initialization(server(8080)).
