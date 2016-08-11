import Html exposing (..)
import Html.App as App
--import Html.Events exposing (..)
--import Random exposing (..)

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
init = (Model 200 "OK", Cmd.none)

-- view

view : Model -> Html Msg
view model = div []
    [ h1 [] [ text model.etitle ] ]
    
