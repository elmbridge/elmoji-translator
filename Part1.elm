module Part1 exposing (Model, Msg(..), init, main, update, view)

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
    { currentText : String }


init : Model
init =
    { currentText = "" }



-- UPDATE


type Msg
    = SetCurrentText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCurrentText newText ->
            -- currently, this does nothing!
            model



-- VIEW


view : Model -> Html Msg
view model =
    div
        []
        [ node "link"
            [ rel "stylesheet"
            , href "stylesheets/main.css"
            ]
            []
        , nav
            []
            [ div
                [ class "nav-wrapper light-blue lighten-2" ]
                [ div
                    [ class "brand-logo center" ]
                    [ text "Elmoji Translator" ]
                ]
            ]
        , section
            [ class "container" ]
            [ div
                [ class "input-field" ]
                [ input
                    [ type_ "text"
                    , class "center"
                    , placeholder "Let's Translate!"
                    , onInput SetCurrentText
                    ]
                    []
                ]
            ]
        ]
