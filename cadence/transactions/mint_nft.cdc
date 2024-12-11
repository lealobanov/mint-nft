import "NonFungibleToken"
import "Recipe"
import "ExampleNFT"

transaction {
    let minter: &ExampleNFT.NFTMinter
    let receiver: &{NonFungibleToken.CollectionPublic}

    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Borrow the ExampleNFT.NFTMinter reference
        self.minter = signer.storage.borrow<&ExampleNFT.NFTMinter>(
            from: Recipe.ExampleNFTMinterPath
        ) ?? panic("Could not borrow a reference to the ExampleNFT NFTMinter")

        // Borrow the signer's NFT collection reference
        self.receiver = signer.storage.borrow<&{NonFungibleToken.CollectionPublic}>(
            from: /storage/exampleNFTCollection
        ) ?? panic("Could not borrow a reference to the signer's NFT collection")
    }

    execute {
        // Call the mintNFT function from the ExampleNFT.NFTMinter
        let newNFT <- self.minter.mintNFT(
            name: "Hardcoded NFT Name",
            description: "This is a hardcoded description of the NFT.",
            thumbnail: "https://example.com/hardcoded-thumbnail.png",
            royalties: []
        )

        // Deposit the minted NFT into the recipient's collection
        self.receiver.deposit(token: <-newNFT)

        log("Minted and deposited an NFT into the signer's collection.")
    }
}