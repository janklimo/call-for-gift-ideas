module Wizard.Utils exposing (..)

import Html exposing (Html)
import Svg exposing (use, svg)
import Svg.Attributes as SvgAttrs
import Wizard.Msgs exposing (Msg)
import Wizard.Models exposing (..)


icon : String -> Html Msg
icon name =
    svg [ SvgAttrs.class ("icon icon-" ++ name) ]
        [ use [ SvgAttrs.xlinkHref ("#icon-" ++ name) ] [] ]


undecidedProducts : Products -> List ( Product, Extensions )
undecidedProducts products =
    List.filter (\( p, e ) -> e.seen == False) products


likedProducts : Products -> List ( Product, Extensions )
likedProducts products =
    List.filter (\( p, e ) -> e.liked == True) products


likedProductsCount : Products -> Int
likedProductsCount products =
    products
        |> likedProducts
        |> List.length


sortedByRank : Products -> Products
sortedByRank products =
    List.sortBy (\( p, e ) -> e.rank) products


upvote : ( Product, Extensions ) -> ( Product, Extensions )
upvote ( product, extensions ) =
    ( product, { extensions | rank = extensions.rank - 1 } )


downvote : ( Product, Extensions ) -> ( Product, Extensions )
downvote ( product, extensions ) =
    ( product, { extensions | rank = extensions.rank + 1 } )


minimumLikedCount : Int
minimumLikedCount =
    2
