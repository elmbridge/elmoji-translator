module Part3 exposing (Model, Msg(..), defaultKey, init, main, translateText, update, view)

import Browser
import EmojiConverter
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


defaultKey : String
defaultKey =
    "😳"



-- UPDATE


type Msg
    = SetCurrentText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCurrentText newText ->
            { model | currentText = newText }



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
            , p
                [ class "center output-text emoji-size" ]
                [ text (translateText model) ]
            ]
        ]


translateText : Model -> String
translateText model =
    EmojiConverter.textToEmoji defaultKey model.currentText
