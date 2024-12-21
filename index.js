// Pass the repo name
const recipe = "mint-nft";

export const mintNFT = {
  slug: recipe,
  title: "Mint NFT",
  featuredText: "Introduction to minting an NFT on Flow",
  createdAt: new Date(2022, 9, 14),
  author: "Flow Blockchain",
  playgroundLink:
    "https://play.onflow.org/22ef65e1-654d-4ab1-bd82-3712a6fb8877?type=account&id=27ecf409-b82d-43f7-9b94-5c9753bc7abf&storage=none",
  excerpt:
    "This is for minting NFTS. It includes the minting resource that you can use in your smart contract, as well as the transaction to mint from the deployed account. It can be included in your smart contract along with the NFT Standard.",
  filters: {
    difficulty: "beginner",
  },
};
