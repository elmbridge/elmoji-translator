module Part6 exposing (Direction(..), Model, Msg(..), defaultKey, init, main, renderKey, renderKeys, translateText, update, view)

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


type Direction
    = TextToEmoji
    | EmojiToText


type alias Model =
    { currentText : String
    , direction : Direction
    }


init : Model
init =
    { currentText = ""
    , direction = TextToEmoji
    }


defaultKey : String
defaultKey =
    "😳"



-- UPDATE


type Msg
    = SetCurrentText String
    | ToggleDirection


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCurrentText newText ->
            { model | currentText = newText }

        ToggleDirection ->
            case model.direction of
                TextToEmoji ->
                    { model | direction = EmojiToText }

                EmojiToText ->
                    { model | direction = TextToEmoji }



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
            , div
                [ class "switch center" ]
                [ label
                    []
                    [ text "Translate Text"
                    , input
                        [ type_ "checkbox"
                        , onClick ToggleDirection
                        ]
                        []
                    , span
                        [ class "lever" ]
                        []
                    , text "Translate Emoji"
                    ]
                ]
            , p
                [ class "center output-text emoji-size" ]
                [ text (translateText model) ]
            ]
        , div
            [ class "divider" ]
            []
        , section
            [ class "container" ]
            [ h4
                [ class "center" ]
                [ text "Select Your Key" ]
            , renderKeys
            ]
        ]


translateText : Model -> String
translateText model =
    case model.direction of
        TextToEmoji ->
            EmojiConverter.textToEmoji defaultKey model.currentText

        EmojiToText ->
            EmojiConverter.emojiToText defaultKey model.currentText


renderKeys : Html Msg
renderKeys =
    div
        [ class "row" ]
        (List.map (\emoji -> renderKey emoji) EmojiConverter.supportedEmojis)


renderKey : String -> Html Msg
renderKey emoji =
    div
        [ class "col s2 m1 emoji-size" ]
        [ div
            [ classList
                [ ( "key-selector", True )
                , ( "is-selected", emoji == defaultKey )
                ]
            ]
            [ text emoji ]
        ]
