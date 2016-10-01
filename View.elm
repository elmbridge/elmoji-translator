module View exposing (..)

import Update
import Model
import Html
import Html.Events


view : Model.Model -> Html.Html Update.Msg
view model =
    Html.div
        [ Html.Events.onClick Update.ChangeText ]
        [ Html.text model.text ]
