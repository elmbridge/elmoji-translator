module View exposing (..)

import Update
import Model
import Html
import Html.Events
import Html.Attributes


view : Model.Model -> Html.Html Update.Msg
view model =
    Html.div
        [ Html.Attributes.class "skeleton-elm-project" ]
        [ Html.div
            [ Html.Attributes.class "waves-effect waves-light btn-large"
            , Html.Events.onClick Update.ChangeText
            ]
            [ Html.text model.text ]
        ]
