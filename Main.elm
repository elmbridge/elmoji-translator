module Main exposing (..)

import Html.App
import View
import Model
import Update


main : Program Never
main =
    Html.App.beginnerProgram
        { model = Model.init
        , view = View.view
        , update = Update.update
        }
