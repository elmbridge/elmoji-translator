module Update exposing (..)

import Model


type Msg
    = SetCurrentText String
    | ToggleDirection


update : Msg -> Model.Model -> Model.Model
update msg model =
    case msg of
        SetCurrentText newText ->
            { model | currentText = newText }

        ToggleDirection ->
            case model.direction of
                Model.TextToEmoji ->
                    { model | direction = Model.EmojiToText }

                Model.EmojiToText ->
                    { model | direction = Model.TextToEmoji }
