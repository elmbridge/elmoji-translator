module HelloWorld exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { buttonLabel : String }


init : Model
init =
    { buttonLabel = "hello world!" }



-- UPDATE


type Msg
    = ChangeText


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeText ->
            if model.buttonLabel == "hello world!" then
                { model | buttonLabel = "goodbye world!" }

            else
                { model | buttonLabel = "hello world!" }



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ class "skeleton-elm-project" ]
        [ node "link"
            [ rel "stylesheet"
            , href "stylesheets/main.css"
            ]
            []
        , div
            [ class "waves-effect waves-light btn-large"
            , onClick ChangeText
            ]
            [ text model.buttonLabel ]
        ]
