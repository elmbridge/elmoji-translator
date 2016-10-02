module Model exposing (..)


type alias Model =
    { currentText : String }


init : Model
init =
    { currentText = "" }


defaultKey : String
defaultKey =
    "😳"
