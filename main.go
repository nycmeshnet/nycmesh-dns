package main

import (
	"fmt"
	"log"
	"net"
	"os"

	"golang.org/x/crypto/sha3"
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

// Check if the given IP address is valid.
func isIPValid(providedIP string) bool {
	return net.ParseIP(providedIP) != nil
}

// Ensure that the CIDR block is valid.
func validateCIDR(ipWithCidr string) bool {
	_, _, err := net.ParseCIDR(ipWithCidr)
	return err == nil
}
