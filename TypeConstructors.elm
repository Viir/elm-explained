module TypeConstructors where

{- A type constructor defines a new type, and gives us protection
   against misuse.

   In this example we'll define a Ship and a Person, which both have
   a name, but we won't be able to substitute one for the other
   in a function which requires a specific one.

   The symbols Ship and Person are also called tags - they are tagging
   the String to indentify intended use.
-}

type Ship = Ship String
type Person = Person String

-- We'll create a Ship and a Person, and they will be of distinct types.

vessel : Ship
vessel = Ship "HMS Splendid"

captain : Person
captain = Person "Captain Robert Q. Peabody"

-- Here are two functions which take a Ship and a Person as arguments.
-- To extract the data embedded in the type we use pattern matching.

launch : Ship -> String
launch s
  = case s of
          Ship name -> "I name this ship " ++ name

greet : Person -> String
greet p
  = case p of
          Person name -> "Hello there, " ++ name

-- Here we launch a ship and greet a person. As you'd expect, both
-- functions compile fine and give the expected output.

launchShip = launch vessel
greetPerson = greet captain

{- We can execute this in the Elm REPL to check

   > import TypeConstructors exposing (..)
   > launchShip
   "I name this ship HMS Splendid" : String
   > greetPerson
   "Hello there, Captain Robert Q. Peabody" : String
   >
   
-}

-- But these next two functions won't compile.
-- If we uncomment them and try to import this module we'll get
-- a type error.

-- launchPerson = launch captain
-- greetShip = greet vessel

{- Here's what it looks like in the REPL

   > import TypeConstructors exposing (..)
   -- TYPE MISMATCH --------------------------------- .\.\TypeConstructors.elm
   
   The argument to function `launch` is causing a mismatch.
   
   57|                launch captain
                             ^^^^^^^
                             Function `launch` is expecting the argument to be:
   
       Ship
   
   But it is:
   
       Person
   
   
   >
-}

-- We can of course also define a type with more than one argument.
-- Here is how we define and use a number with a name

type NamedInt = NamedInt String Int

describe : NamedInt -> String
describe ni
  = case ni of
      NamedInt name num -> "Number " ++ name ++ " looks like " ++ (toString num)

n1 = NamedInt "one" 1
n2 = NamedInt "two" 2
n37 = NamedInt "thirty seven" 37

{- We can used that like this on the Elm REPL:

   > import TypeConstructors exposing (..)
   > describe n37
   "Number thirty seven looks like 37" : String
   >

-}
