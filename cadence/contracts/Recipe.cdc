import "ExampleNFT"
import "NonFungibleToken"

access(all) contract Recipe {
    access(all) let MinterStoragePath: StoragePath
    access(all) let CollectionPublicPath: PublicPath

    // Initialize the paths and the NFTMinter resource
    init() {
        self.MinterStoragePath = /storage/RecipeNFTMinter
        self.CollectionPublicPath = /public/RecipeNFTCollection

        // Create and store an NFTMinter resource in storage
        let minter <- create NFTMinter()
        self.account.storage.save(<-minter, to: self.MinterStoragePath)

        // Create a Collection and publish its capability
        let collection <- ExampleNFT.createEmptyCollection()
        self.account.storage.save(<-collection, to: /storage/RecipeNFTCollection)
        let cap = self.account.capabilities.storage.issue<&{NonFungibleToken.CollectionPublic}>(
            /storage/RecipeNFTCollection
        )
        self.account.capabilities.publish(cap, at: self.CollectionPublicPath)
    }

    access(all) resource NFTMinter {
        /// Mint and deposit a new NFT
        access(all)
        fun mintNFT(
            recipient: &{NonFungibleToken.CollectionPublic},
            name: String,
            description: String,
            thumbnail: String,
            power: String,
            will: String,
            determination: String
        ) {
            let newNFT <- ExampleNFT.mintNFT()
            let metadata: {String: String} = {
                "name": name,
                "description": description,
                "thumbnail": thumbnail,
                "power": power,
                "will": will,
                "determination": determination
            }

            log("Minted NFT with ID: \(newNFT.id) and metadata: \(metadata)")
            recipient.deposit(token: <-newNFT)
            log("Deposited NFT with ID: \(newNFT.id) into recipient's collection.")
        }
    }
}
