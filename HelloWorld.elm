module HelloWorld exposing (Model, Msg(..), init, main, update, view)

import Browser
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


view : Model -> Html.Html Msg
view model =
    Html.div
        [ Html.Attributes.class "skeleton-elm-project" ]
        [ Html.node "link"
            [ Html.Attributes.rel "stylesheet"
            , Html.Attributes.href "stylesheets/main.css"
            ]
            []
        , Html.div
            [ Html.Attributes.class "waves-effect waves-light btn-large"
            , Html.Events.onClick ChangeText
            ]
            [ Html.text model.buttonLabel ]
        ]
