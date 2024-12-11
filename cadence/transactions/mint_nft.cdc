import "NonFungibleToken"
import "Recipe"

transaction {
    let minter: &Recipe
    let receiver: &{NonFungibleToken.CollectionPublic}

    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Borrow the Recipe contract as a reference
        self.minter = signer.capabilities.storage.borrow<&Recipe>(
            from: Recipe.ExampleNFTMinterPath
        ) ?? panic("Could not borrow a reference to the Recipe contract")

        // Borrow the signer's NFT collection reference
        self.receiver = signer.capabilities.storage.borrow<&{NonFungibleToken.CollectionPublic}>(
            from: Recipe.CollectionPublicPath
        ) ?? panic("Could not borrow a reference to the signer's NFT collection")
    }

    execute {
        // Call mintNFT from the Recipe contract
        self.minter.mintNFT(
            recipient: self.receiver,
            name: "Hardcoded NFT Name",
            description: "This is a hardcoded description of the NFT.",
            thumbnail: "https://example.com/hardcoded-thumbnail.png"
        )

        log("Minted and deposited an NFT into the signer's collection.")
    }
}