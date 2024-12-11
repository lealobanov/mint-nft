import "ExampleNFT"
import "NonFungibleToken"

access(all) contract Recipe {
    access(all) let ExampleNFTMinterPath: StoragePath

    init() {
        // Reference the storage path where ExampleNFT stores its NFTMinter
        self.ExampleNFTMinterPath = /storage/exampleNFTMinter
    }

    access(all) fun mintNFT(
        recipient: &{NonFungibleToken.CollectionPublic},
        name: String,
        description: String,
        thumbnail: String
    ) {
        // Borrow the ExampleNFT.NFTMinter resource
        let minterRef = self.account.storage.borrow<&ExampleNFT.NFTMinter>(from: self.ExampleNFTMinterPath)
            ?? panic("Could not borrow reference to the ExampleNFT NFTMinter")

        // Call the ExampleNFT.NFTMinter's mintNFT function
        let newNFT <- minterRef.mintNFT(
            name: name,
            description: description,
            thumbnail: thumbnail,
            royalties: []
        )

        // Deposit the minted NFT into the recipient's collection
        recipient.deposit(token: <-newNFT)
    }
}
