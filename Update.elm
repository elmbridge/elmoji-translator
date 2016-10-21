module Update exposing (..)

import Model


type Msg
    = ChangeText


update : Msg -> Model.Model -> Model.Model
update msg model =
    case msg of
        ChangeText ->
            if model.buttonLabel == "hello world!" then
                { model | buttonLabel = "goodbye world!" }
            else
                { model | buttonLabel = "hello world!" }
