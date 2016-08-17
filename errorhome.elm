module Error exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
--import Html.Events exposing (..)
--import Random exposing (..)
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
    }


-- update

type Msg = Dummy

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Dummy ->
            (model, Cmd.none)

-- subscriptions

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none

-- init

init : (Model, Cmd Msg)
init = (Model 200 "OK" "", Cmd.none)

-- view

view : Model -> Html Msg
view model = div []
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
            , href "cgi/jump.cgi?index=3810954172703717506"
            ]
            [ text <| fromChar x ] :: mkTitle xs
        _ ->
            []

bodySecond : Html Msg
bodySecond = div [footerStyle]
    [ text "Apache/"]

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
