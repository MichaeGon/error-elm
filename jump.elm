module Jump exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)

main : Program Never
main = App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
    {}

type Msg = Msg

init : (Model, Cmd Msg)
init = (Model, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

view : Model -> Html Msg
view model = node "meta"
    [ httpEquiv "refresh"
    , content "0; URL=https://github.com/MichaeGon/some_scripts"
    ] []
