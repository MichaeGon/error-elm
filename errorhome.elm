module Error exposing (..)

import Array
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
--import Html.Events exposing (..)
import Http exposing (..)
import Random
import String exposing (..)

main : Program Never
main = App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- model

type alias Model =
    { ecode : Int
    , etitle : String
    , emessage : String
    , rands : List Int
    , apache : String
    , os : String
    , portNum : Int
    }


-- update

type Msg
    = SetCode Int
    | Select
    | Set (List Int)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        SetCode n ->
            case Array.get n codes of
                Just (c, t, m) ->
                    ({model | ecode = c, etitle = t, emessage = m}, Cmd.none)
                _ ->
                    (model, Cmd.none)
        Select ->
            let
                l = length model.etitle
                intgen = Random.int Random.minInt Random.maxInt
                intsgen = Random.list l intgen
            in
                (model, Random.generate Set intsgen)
        Set xs ->
            ({model | rands = xs}, Cmd.none)

-- cmd setcode
setcode : Cmd Msg
setcode =
    let
        l = Array.length codes - 1
        g = Random.int 0 l
    in
        Random.generate SetCode g

-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- init

init : (Model, Cmd Msg)
init = (Model 0 "" "" [] "" "" 0, setcode)

-- view

view : Model -> Html Msg
view model =
    if model.ecode == 0 then
        div [] [ ]
    else
        div []
        [ h1 [] <| mkTitle model.etitle
        , br [] []
        , text model.emessage
        , br [] []
        , hr [] []
        , bodySecond
        ]

mkTitle : String -> List (Html Msg)
mkTitle s =
    case uncons s of
        Just (x, xs) ->
            a
            [ tytleStyle
            , target "_blank"
            , href "http://michaegon.jp/cgi/jump.cgi?index=3810954172703717506"
            ]
            [ text <| fromChar x ] :: mkTitle xs
        _ ->
            []

bodySecond : Html Msg
bodySecond = div [footerStyle]
    [ text "Apache/"]


-- styles

tytleStyle : Attribute Msg
tytleStyle = style
    [ ("text-decoration", "none")
    , ("color", "black")
    ]

footerStyle : Attribute Msg
footerStyle = style
    [ ("text-align", "left")
    , ("font-style", "italic")
    ]


---- BETABARI ----
codes : Array.Array (Int, String, String)
codes = Array.fromList
    [ (100, "Continue", "")
    , (101, "Switching Protocols", "")
    , (200, "OK", "")
    , (201, "Created", "")
    , (202, "Accepted", "")
    , (203, "Non-Authoritative Information", "")
    , (204, "No Content", "")
    , (205, "Reset Content", "")
    , (206, "Partial Content", "")
    , (300, "Multiple Choices", "")
    , (301, "Moved Permanently", "")
    , (302, "Found", "")
    , (303, "See Other", "")
    , (304, "Not Modified", "")
    , (305, "Use Proxy", "")
    , (306, "Unused", "")
    , (307, "Temporary Redirect", "")
    , (400, "Bad Request", "Your browser (or proxy) sent a request that this server could not understand.")
    , (401, "Unauthorized", "This server could not verify that you are authorized to access the URL. You either supplied the wrong credentials (e.g., bad password), or your browser doesn't understand how to supply the credentials required.")
    , (402, "Payment Required", "You must give me money.")
    , (403, "Forbidden", "You don't have permission to access index.html on this server.")
    , (404, "Not Found", "The requested URL index.html not found on this server.")
    , (405, "Method Not Allowed", "The method is not allowed for the requested URL.")
    , (406, "Not Acceptable", "")
    , (407, "Proxy Authentication Required", "")
    , (408, "Request Timeout", "Ther server closed the network connection because the browser didn't finish the request within the specified time.")
    , (409, "Conflict", "")
    , (410, "Gone", "The requested URL is no longer available on this server and there is no forwarding address.")
    , (411, "Length Required", "A request with the method requires a valid Content-Length header.")
    , (412, "Precondition Failed", "The precondition on the request for the URL failed positive evaluation.")
    , (413, "Request Entity Too Large", "The method does not allow the data transmitted, or the data volume exceeds the capacity limit.")
    , (414, "Request-URI Too Large", "The length of the requested URL exceeds the capacity limit for this server. Ther request cannot be processed.")
    , (415, "Unsupported Media Type", "The server does not support the media type transmitted in the request.")
    , (416, "Requested Range Not Satisfiable", "")
    , (417, "Expectation Failed", "")
    , (500, "Internal Server Error", "The server encountered an internal error and was unable to complete your request.")
    , (501, "Not Implemented", "The server does not support the action requested by the browser.")
    , (502, "Bad Gateway", "Proxy server received an invalid response from an upstream server.")
    , (503, "Service Unavailable", "The service is temporarily unable to service tour request due to maintenance downtime or capacity problems. Please try again later.")
    , (504, "Gateway Timeout", "")
    , (505, "HTTP Version Not Supported", "")
    , (506, "Variant Also Varies", "A variant for the requested entity is itself a negotiable resource. Access not possible.")
    ]
