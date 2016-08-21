module Error exposing (..)

import Array
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)
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
    , apache : String
    , os : String
    , portNum : Int
    }


-- update

type Msg
    = Reset
    | Set (Int, Int, Int, Int)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Reset ->
            (model, setcode)

        Set (l, m, v, p) ->
            let
                (c, t, s) = get' l codes
                name = get' m oss
                ver = v |> toString
                        |> toList
                        |> List.intersperse '.'
                        |> fromList
            in
                ({model
                    | ecode = c
                    , etitle = t
                    , emessage = s
                    , apache = ver
                    , os = name
                    , portNum = p }, Cmd.none)

get' : Int -> Array.Array a -> a
get' n arr =
    case Array.get n arr of
        Just x ->
            x
        _ ->
            Debug.crash "error at get'"

-- cmd setcode
setcode : Cmd Msg
setcode =
    let
        l = int 0 <| Array.length codes - 1
        m = int 0 <| Array.length oss - 1
        v = int 100 999
        p = int 0 9999
        g = map4 (,,,) l m v p
    in
        generate Set g

-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- init

init : (Model, Cmd Msg)
init = (Model 0 "" "" "" "" 0, setcode)

-- view

view : Model -> Html Msg
view model = div []
    [ h1 [] <| mkTitle model
    , br [] []
    , text model.emessage
    , br [] []
    , hr [] []
    , bodySecond model
    ]

mkTitle : Model -> List (Html Msg)
mkTitle model = model.etitle
    |> toList
    |> List.map (\x ->
        a
        [ tytleStyle
        , target "_blank"
        , href "jump.html"
        , onClick Reset
        ]
        [ text <| fromChar x]
        )

bodySecond : Model -> Html Msg
bodySecond model = footer [footerStyle]
    [ text <| "Apache/" ++ model.apache ++ " (" ++ model.os ++ ") Server at michaegon.jp Port " ++ toString model.portNum]


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

oss : Array.Array String
oss = Array.fromList
    [ "ARMA aka Omoikane GNU/Linux"
    , "aptosid"
    , "Kali Linux"
    , "KANOTIX"
    , "KNOPPIX"
    , "MEPIS"
    , "SteamOS"
    , "Ubuntu"
    , "Corel Linux"
    , "Linspire"
    , "Progeny Debian"
    , "UserLinux"
    , "Damn Small Linux"
    , "gOS"
    , "Regret"
    , "Xenoppix"
    , "BackTrack"
    , "Fluxbuntu"
    , "Fedora"
    , "Red Hat Enterprise Linux"
    , "Asianux"
    , "Haansoft Linux"
    , "MIRACLE LINUX"
    , "Red Flag Linux"
    , "CentOS"
    , "Scientific Linux"
    , "StartCom Linux"
    , "Yellow Dog Linux"
    , "Berry Linux"
    , "Red Star OS"
    , "Mandriva Linux"
    , "PCLinuxOS"
    , "Momonga Linux"
    , "Vine Linux"
    , "RedHawk Linux"
    , "Caldera OpenLinux"
    , "HOLON Linux"
    , "Kondara MNU/Linux"
    , "LASER5 Linux"
    , "Lycoris Desktop/LX"
    , "PS2 Linux"
    , "Red Hat Linux"
    , "White Box EnterPrise Linux"
    , "Slackware"
    , "Plamo Linux"
    , "Puppy Linux"
    , "Slamd64"
    , "SLAX"
    , "openSUSE"
    , "United Linux"
    , "Wolvix"
    , "Arch Linux"
    , "Manjaro Linux"
    , "Foresight Linux"
    , "Gentoo Linux"
    , "Google Chrome OS"
    , "Sabayon Linux"
    , "IPnuts"
    , "Nature's Linux"
    , "Omaemona 2ch/Linux"
    , "Turbolinux"
    , "iPodLinux"
    , "SliTaz"
    , "Tiny Core Linux"
    , "MkLinux"
    , "SLS"
    , "Stataboware"
    , "Splashtop"
    , "Mac OS X Server"
    , "Darwin"
    , "iOS"
    , "MS-DOS"
    , "Windows Server 2012"
    ]
