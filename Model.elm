module Model exposing (..)


type Direction
    = TextToEmoji
    | EmojiToText


type alias Model =
    { currentText : String
    , direction : Direction
    }


init : Model
init =
    { currentText = ""
    , direction = TextToEmoji
    }


defaultKey : String
defaultKey =
    "😳"
