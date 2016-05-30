module Random.Maybe exposing (..)

{-| List of Maybe Generators

# Generators
@docs maybe, withDefault, withDefaultGenerator

-}

import Random exposing (Generator, map)
import Random.Extra exposing (constant, choices, frequency, flatMap)
import Maybe


{-| Generate a Maybe from a generator. Will generate Nothings 50% of the time.
-}
maybe : Generator a -> Generator (Maybe a)
maybe generator =
    choices
        [ constant Nothing
        , map Just generator
        ]


{-| Generate values from a maybe generator or a default value.
-}
withDefault : a -> Generator (Maybe a) -> Generator a
withDefault value generator =
    map (Maybe.withDefault value) generator


{-| Generate values from a maybe generator or a default generator.
-}
withDefaultGenerator : Generator a -> Generator (Maybe a) -> Generator a
withDefaultGenerator default generator =
    flatMap (flip withDefault generator) default
