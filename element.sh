#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t --no-align --tuples-only -c"

MAIN_MENU() {
   if [[ -z $1 ]]
    then
    echo "Please provide an element as an argument."
    exit
  fi
  VALID_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
  VALID_SYMBOL=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
if [[ "$1" =~ ^[0-9]+$ ]]
  then
  VALID=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$1'")
  fi
  if [[ $VALID ]]
        then
        SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$1'")
        NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$1'")
        ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$1'")
        MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$1'")
        BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$1'")
        TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = '$1'")
        TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
        echo "The element with atomic number $1 is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
   elif [[ $VALID_NAME ]]
      then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
      echo "The element with atomic number $ATOMIC_NUMBER is $1 ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $1 has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    elif [[ $VALID_SYMBOL ]]
    then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID")
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($1). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  else
  echo "I could not find that element in the database."
fi
}
MAIN_MENU $1
