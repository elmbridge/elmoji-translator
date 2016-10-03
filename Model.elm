module Model exposing (..)


type Direction
    = TextToEmoji
    | EmojiToText


type alias Model =
    { currentText : String
    , direction : Direction
    , selectedKey : String
    }


init : Model
init =
    { currentText = ""
    , direction = TextToEmoji
    , selectedKey = defaultKey
    }


defaultKey : String
defaultKey =
    "😳"
