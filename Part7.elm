module Part7 exposing (Direction(..), Model, Msg(..), defaultKey, init, main, renderKey, renderKeys, translateText, update, view)

import Browser
import EmojiConverter
import Html
import Html.Attributes
import Html.Events



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
    , selectedKey : String
    }


init : Model
init =
    { currentText = ""
    , direction = TextToEmoji
    , selectedKey = defaultKey
    }


defaultKey : String
defaultKey =
    "😳"



-- UPDATE


type Msg
    = SetCurrentText String
    | SetSelectedKey String
    | ToggleDirection


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCurrentText newText ->
            { model | currentText = newText }

        SetSelectedKey newKey ->
            { model | selectedKey = newKey }

        ToggleDirection ->
            case model.direction of
                TextToEmoji ->
                    { model | direction = EmojiToText }

                EmojiToText ->
                    { model | direction = TextToEmoji }



-- VIEW


view : Model -> Html.Html Msg
view model =
    Html.div
        []
        [ Html.node "link"
            [ Html.Attributes.rel "stylesheet"
            , Html.Attributes.href "stylesheets/main.css"
            ]
            []
        , Html.nav
            []
            [ Html.div
                [ Html.Attributes.class "nav-wrapper light-blue lighten-2" ]
                [ Html.div
                    [ Html.Attributes.class "brand-logo center" ]
                    [ Html.text "Elmoji Translator" ]
                ]
            ]
        , Html.section
            [ Html.Attributes.class "container" ]
            [ Html.div
                [ Html.Attributes.class "input-field" ]
                [ Html.input
                    [ Html.Attributes.type_ "text"
                    , Html.Attributes.class "center"
                    , Html.Attributes.placeholder "Let's Translate!"
                    , Html.Events.onInput SetCurrentText
                    ]
                    []
                ]
            , Html.div
                [ Html.Attributes.class "switch center" ]
                [ Html.label
                    []
                    [ Html.text "Translate Text"
                    , Html.input
                        [ Html.Attributes.type_ "checkbox"
                        , Html.Events.onClick ToggleDirection
                        ]
                        []
                    , Html.span
                        [ Html.Attributes.class "lever" ]
                        []
                    , Html.text "Translate Emoji"
                    ]
                ]
            , Html.p
                [ Html.Attributes.class "center output-text emoji-size" ]
                [ Html.text (translateText model) ]
            ]
        , Html.div
            [ Html.Attributes.class "divider" ]
            []
        , Html.section
            [ Html.Attributes.class "container" ]
            [ Html.h4
                [ Html.Attributes.class "center" ]
                [ Html.text "Select Your Key" ]
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


renderKeys : Html.Html Msg
renderKeys =
    Html.div
        [ Html.Attributes.class "row" ]
        (List.map (\emoji -> renderKey emoji) EmojiConverter.supportedEmojis)


renderKey : String -> Html.Html Msg
renderKey emoji =
    Html.div
        [ Html.Attributes.class "col s2 m1 emoji-size" ]
        [ Html.div
            [ Html.Attributes.classList
                [ ( "key-selector", True )
                , ( "is-selected", emoji == defaultKey )
                ]
            , Html.Events.onClick (SetSelectedKey emoji)
            ]
            [ Html.text emoji ]
        ]
