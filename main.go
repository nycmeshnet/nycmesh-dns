package main

import (
	"fmt"
	"log"
	"net"
	"os"

	"golang.org/x/crypto/sha3"
)

var (
	knotConfigPath = "assets/knot.conf"
	kresdConfigPath = "assets/kresd.conf"
)

func init() {
	// Check all the required files are present.
	if !fileExists(knotConfigPath) {
		log.Fatalln("The file does not exist.")
	}
	if !fileExists(kresdConfigPath) {
		log.Fatalln("The file does not exist.")
	}
}

func main() {
	// Time to process the provided data.
	
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

// Save all the errors in a single given path.
func saveAllErrors(errors error, path string) {
	filePath, err := os.OpenFile(path, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatalln(err)
	}
	log.SetOutput(filePath)
	log.Println(errors)
	err = filePath.Close()
	if err != nil {
		log.Fatalln(err)
	}
}
