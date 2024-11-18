access(all)
resource NFTMinter {

    // mintNFT mints a new NFT with a new ID
    // and deposits it in the recipient's collection using their collection reference
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
        // Create a new NFT
        let newNFT <- create NFT(
            id: NewExampleNFT.totalSupply,
            name: name,
            description: description,
            thumbnail: thumbnail,
            power: power,
            will: will,
            determination: determination
        )

        // Deposit it in the recipient's account using their reference
        recipient.deposit(token: <-newNFT)

        // Increment the total supply of NFTs
        NewExampleNFT.totalSupply = NewExampleNFT.totalSupply + (1 as UInt64)
    }
}
