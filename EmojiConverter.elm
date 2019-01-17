module EmojiConverter exposing (emojiToText, supportedEmojis, textToEmoji)

import Char
import Dict
import List
import List.Extra
import Regex
import String


type alias Key =
    String


textToEmoji : Key -> String -> String
textToEmoji key text =
    convert supportedLetters (rotateEmojis key) splitEveryCharacter text


emojiToText : Key -> String -> String
emojiToText key emojis =
    convert (rotateEmojis key) supportedLetters splitEveryEmoji emojis


splitEveryCharacter : String -> List String
splitEveryCharacter =
    String.split ""


splitEveryEmoji : String -> List String
splitEveryEmoji str =
    -- due to JavaScript issues with splitting and unicode, we maually split the string.
    Regex.fromString "([\\uD800-\\uDBFF][\\uDC00-\\uDFFF])"
        |> Maybe.withDefault Regex.never
        |> Regex.find
        |> (\matcher ->
                matcher str
                    |> List.map .match
           )


convert : List String -> List String -> (String -> List String) -> String -> String
convert orderedKeys orderedValues splitter string =
    let
        lookupTable =
            List.Extra.zip orderedKeys orderedValues
                |> Dict.fromList

        getValueOrReturnKey key =
            lookupTable
                |> Dict.get key
                |> Maybe.withDefault key
    in
    string
        |> splitter
        |> List.map getValueOrReturnKey
        |> String.join ""


rotateEmojis : Key -> List String
rotateEmojis key =
    supportedEmojis
        |> List.Extra.elemIndex key
        -- if the key can't be found, default to the first emoji listed.
        |> Maybe.withDefault 0
        |> (\a -> List.Extra.splitAt a supportedEmojis)
        |> (\( head, tail ) -> [ tail, head ])
        |> List.concat


supportedLetters : List String
supportedLetters =
    [ -- lowercase letters
      List.range 97 122

    -- uppercase letters
    , List.range 65 90

    -- numbers
    , List.range 48 57
    ]
        |> List.concat
        |> List.map Char.fromCode
        |> List.map String.fromChar


supportedEmojis : List String
supportedEmojis =
    [ "😁"
    , "😂"
    , "😃"
    , "😄"
    , "😅"
    , "😆"
    , "😉"
    , "😊"
    , "😋"
    , "😌"
    , "😍"
    , "😏"
    , "😒"
    , "😓"
    , "😔"
    , "😖"
    , "😘"
    , "😚"
    , "😜"
    , "😝"
    , "😞"
    , "😠"
    , "😡"
    , "😢"
    , "😣"
    , "😤"
    , "😥"
    , "😨"
    , "😩"
    , "😪"
    , "😫"
    , "😭"
    , "😰"
    , "😱"
    , "😲"
    , "😳"
    , "😵"
    , "😷"
    , "😸"
    , "😹"
    , "😺"
    , "😻"
    , "😼"
    , "😽"
    , "😾"
    , "😿"
    , "🙀"
    , "🙅"
    , "🙆"
    , "🙇"
    , "🙈"
    , "🙉"
    , "🙊"
    , "🙋"
    , "🙌"
    , "🙍"
    , "🙎"
    , "🙏"
    , "🚑"
    , "🚒"
    , "🚓"
    , "🚕"
    ]
