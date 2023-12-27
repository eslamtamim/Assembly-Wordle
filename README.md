# Assembly-Wordle
The well-known game Wordle but in Assembly x86 as a project in the Assembly Language Course by Dr. Sara El-Metwalli 


This simple assembly language program lets you play a word guessing game -Wordle- . The game randomly selects a word from a predefined list, and you have to guess the correct word within a limited number of attempts.

## Table of Contents
- [Assembly-Wordle](#assembly-wordle)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Getting Started](#getting-started)
  - [How to Play](#how-to-play)
  - [Gameplay](#gameplay)
  - [Acknowledgements](#acknowledgements)

## Introduction

This project is a Wordle Game written in x86 Assembly language. The game presents you with a list of words, and you need to choose one of them. After making your selection, you have a limited number of attempts to guess the correct word.

## Getting Started

To run the game, you'll need an x86 assembler and emulator. Assemble the code using an assembler like TASM (Turbo Assembler) and run the executable on an x86 emulator or DOS environment.

## How to Play

1. Run the executable.
2. The game will prompt you to choose a number from 1 to 5 to start.
3. Enter your choice.
4. You will be prompted to enter a 5-letter word in uppercase.
5. Continue guessing until you correctly identify the word or run out of attempts.

## Gameplay

- The game provides feedback after each guess, indicating correct letters in the correct positions (green) and correct letters in the wrong positions (yellow).
- You have a limited number of attempts (represented by 'G' in the code).
- If you correctly guess the word, the game will congratulate you. If you run out of attempts, it will reveal the correct word.

## Acknowledgements

This project was created for educational purposes to demonstrate simple game logic in x86 Assembly language. Feel free to explore and modify the code to enhance your understanding of assembly programming.
