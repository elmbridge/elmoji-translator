module EmojiConverter exposing (textToEmoji, emojiToText, supportedEmojis)

import List
import List.Extra
import String
import Char
import Dict
import Regex


type alias Key =
    String


textToEmoji : Key -> String -> String
textToEmoji key text =
    convert supportedLetters (rotateEmojis key) (Regex.regex "") text


emojiToText : Key -> String -> String
emojiToText key emojis =
    let
        splitter =
            -- due to JavaScript issues with splitting and unicode, we maually split the string.
            (Regex.regex "([\\uD800-\\uDBFF][\\uDC00-\\uDFFF])")
    in
        convert (rotateEmojis key) supportedLetters splitter emojis


convert : List String -> List String -> Regex.Regex -> String -> String
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
            |> Regex.split Regex.All splitter
            |> List.map (getValueOrReturnKey)
            |> String.join ""


rotateEmojis : Key -> List String
rotateEmojis key =
    supportedEmojis
        |> List.Extra.elemIndex key
        -- if the key can't be found, default to the first emoji listed.
        |>
            Maybe.withDefault 0
        |> (flip List.Extra.splitAt supportedEmojis)
        |> (\( head, tail ) -> [ tail, head ])
        |> List.concat


supportedLetters : List String
supportedLetters =
    [ -- lowercase letters
      [97..122]
      -- uppercase letters
    , [65..90]
      -- numbers
    , [48..57]
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
