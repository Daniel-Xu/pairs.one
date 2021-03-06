module Types.Card exposing (..)

import Json.Encode as JE
import Json.Decode as JD exposing ((:=))


type alias Card =
    { value : Int
    , flipped : Bool
    , cleared : Bool
    , seen : Bool
    }


type alias CardId =
    Int


cardEncoder : Card -> JE.Value
cardEncoder card =
    JE.object
        [ ( "flipped", card.flipped |> JE.bool )
        , ( "cleared", card.cleared |> JE.bool )
        , ( "value", card.value |> JE.int )
        , ( "seen", card.seen |> JE.bool )
        ]


cardDecoder : JD.Decoder Card
cardDecoder =
    JD.object4 Card
        ("value" := JD.int)
        ("flipped" := JD.bool)
        ("cleared" := JD.bool)
        ("seen" := JD.bool)


flippedIds : List Card -> List Int
flippedIds cards =
    List.indexedMap (,) cards |> List.filter (\( _, card ) -> card.flipped) |> List.map (\( id, _ ) -> id)


cardAt : Int -> List Card -> Maybe Card
cardAt index cards =
    cards |> List.drop index |> List.head


cardValueAt : List Card -> Int -> Int
cardValueAt cards index =
    cardAt index cards |> Maybe.map .value |> Maybe.withDefault -1
