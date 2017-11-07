module Wizard.Requests exposing (submitWishlistMsg)

-- external modules

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import RemoteData.Http as Http


-- internal modules

import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (likedProducts, sortedByRank)


updateCallUrl : String -> String
updateCallUrl slug =
    "/calls/" ++ slug


callDecoder : Decoder String
callDecoder =
    Decode.field "status" Decode.string


callEncoder : Model -> Value
callEncoder model =
    Encode.object
        [ ( "preferences", Encode.list <| wishlistIds model ) ]


wishlistIds : Model -> List Value
wishlistIds model =
    model.products
        |> likedProducts
        |> sortedByRank
        |> List.map (\( p, e ) -> Encode.int p.id)


submitWishlistMsg : Model -> Cmd Msg
submitWishlistMsg model =
    Http.patch
        (updateCallUrl model.slug)
        HandleSubmitWishlistResponse
        callDecoder
        (callEncoder model)
