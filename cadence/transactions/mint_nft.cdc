import "NonFungibleToken"
import "Recipe"

transaction {

    let minter: auth(Storage, Capabilities) &Recipe.NFTMinter
    let receiver: &{NonFungibleToken.CollectionPublic}

    prepare(signer: auth(Storage, Capabilities) &Account) {
        // Borrow the NFTMinter resource from the Recipe contract
        self.minter = signer.capabilities.storage.borrow<&Recipe.NFTMinter>(
            from: Recipe.MinterStoragePath
        ) ?? panic("Could not borrow a reference to the NFTMinter")

        // Borrow the signer's own NFT collection reference
        self.receiver = signer.capabilities.borrow<&{NonFungibleToken.CollectionPublic}>(
            Recipe.CollectionPublicPath
        ) ?? panic("Could not borrow the signer's NFT collection reference")
    }

    execute {
        // Mint and deposit the NFT into the signer's own collection
        self.minter.mintNFT(
            recipient: self.receiver,
            name: "Hardcoded NFT Name",
            description: "This is a hardcoded description of the NFT.",
            thumbnail: "https://example.com/hardcoded-thumbnail.png",
            power: "Unlimited Power",
            will: "Unyielding Will",
            determination: "Unstoppable Determination"
        )

        log(
            "Minted NFT with ID: ".concat(newNFT.id.toString())
            .concat(" and metadata: ")
            .concat("{name: Hardcoded NFT Name, description: This is a hardcoded description}")
        )

        log(
            "Deposited NFT with ID: ".concat(newNFT.id.toString())
            .concat(" into the signer's collection.")
        )
    }
}