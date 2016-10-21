module Main exposing (..)

import Html
import View
import Model
import Update


main : Program Never Model.Model Update.Msg
main =
    Html.beginnerProgram
        { model = Model.init
        , view = View.view
        , update = Update.update
        }
