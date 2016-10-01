module Update exposing (..)

import Model


type Msg
    = ChangeText


update : Msg -> Model.Model -> Model.Model
update msg model =
    case msg of
        ChangeText ->
            if model.text == "hello world!" then
                { model | text = "goodbye world!" }
            else
                { model | text = "hello world!" }
