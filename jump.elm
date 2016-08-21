module Jump exposing (..)

import Array
import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Random exposing (..)

main : Program Never
main = App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model =
    { path : Maybe String
    }

type Msg = Select Int

-- Cmd Select
select : Cmd Msg
select = generate Select <| int 0 <| Array.length urls - 1

init : (Model, Cmd Msg)
init = (Model Nothing, select)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Select n ->
            let
                s = get' n urls
            in
                ({model | path = Just s}, Cmd.none)

get' : Int -> Array.Array a -> a
get' n arr =
    case Array.get n arr of
        Just x ->
            x
        _ ->
            Debug.crash "error at get'"

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

view : Model -> Html Msg
view model =
    case model.path of
        Just s ->
            node "meta"
            [ httpEquiv "refresh"
            , content <| "0; URL=" ++ s
            ] []

        _ ->
            div [] []


---- BETABARI ----

urls : Array.Array String
urls = Array.fromList
    [ "http://michaegon.jp/files/"
    , "http://ippei-kun.com"
    , "http://youtu.be/OxXzOA784X8?autoplay=1"
    , "https://www.haskell.org/"
    , "http://youtu.be/80_SkcqbaGk?autoplay=1"
    , "http://youtu.be/_GXak5MSSLg?autoplay=1"
    , "http://youtu.be/W5hpWjZ_HpU?autoplay=1"
    , "http://youtu.be/IJwuSJlnTNA?autoplay=1"
    , "http://youtu.be/W5hpWjZ_HpU?autoplay=1"
    , "http://youtu.be/cokDlOUWtyU?autoplay=1"
    , "http://youtu.be/ICD9PSeweMk?autoplay=1"
    , "http://youtu.be/gZlnahqfN2o?autoplay=1"
    , "https://youtu.be/bp2ZOX-3F_I?autoplay=1"
    , "http://elm-lang.org"
    , "https://www.rust-lang.org/en-US/"
    ]
