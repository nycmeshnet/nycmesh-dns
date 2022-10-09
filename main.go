package main

import (
	"fmt"
	"golang.org/x/crypto/sha3"
	"log"
	"os"
)

func main() {
	fmt.Println("Hello, World!")
}

// Check if the file exists and return a bool.
func fileExists(filename string) bool {
	info, err := os.Stat(filename)
	if err != nil {
		return false
	}
	return !info.IsDir()
}

// Read a file and return the contents
func readAFileAsString(path string) string {
	content, err := os.ReadFile(path)
	if err != nil {
		log.Fatalln(err)
	}
	return string(content)
}

// Get the hash of a string using SHA3-512
func sha3Using512OfGivenByte(content []byte) string {
	return fmt.Sprintf("%x", sha3.Sum512(content))
}
