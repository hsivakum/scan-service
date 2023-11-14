package main

import (
	"context"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/security/keyvault/azkeys"
	"log"
	"os"
	"scan-service/constants"
)

func main() {

	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		panic(err)
	}

	azkeysClient, err := azkeys.NewClient("https://gola.vault.azure.net/", cred, nil)
	if err != nil {
		panic(err)
	}

	version := ""
	algorithmRSAOAEP := azkeys.EncryptionAlgorithmRSAOAEP
	encrypted, err := azkeysClient.Encrypt(context.TODO(), constants.TokenKey, version, azkeys.KeyOperationParameters{
		Algorithm: &algorithmRSAOAEP,
		Value:     []byte("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"),
	}, nil)
	if err != nil {
		log.Fatalln(err)
	}
	err = os.WriteFile("encrypted.txt", encrypted.Result, os.ModePerm)
}
