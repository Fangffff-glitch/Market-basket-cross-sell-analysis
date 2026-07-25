# Market Basket and Cross-Sell Analysis Summary

## Objective

This project uses grocery transaction data to understand how customers build shopping baskets and how product affinity patterns can support cross-selling, bundling, promotion planning, and recommendation strategy.

The analysis focuses on one core business question:

> Which products and categories are frequently purchased together, and how can those relationships be translated into commercially useful cross-sell actions?

## Methodology

### Basket Construction

Transaction records were grouped by basket ID to reconstruct complete shopping baskets. Baskets with at least three items were treated as more meaningful for affinity analysis, reducing noise from very small purchases.

### Product Affinity Analysis

Product co-occurrence was measured using association-rule metrics:

- Support: how often a product pair appears in all baskets
- Confidence: how often product B appears when product A is purchased
- Lift: how much more likely two products are to be purchased together compared with random co-occurrence

Minimum thresholds were applied to avoid over-interpreting rare product combinations.

### Category-Level Analysis

SKU-level results were mapped to broader product categories to reveal more stable and interpretable shopping patterns. Category-level support, confidence, and lift were used to identify cross-category missions and potential anchor categories.

### Promotion Halo Analysis

Transaction data was merged with promotion indicators to estimate whether promoting an anchor product increased sales of its high-affinity partner products. This provided a practical way to distinguish natural co-purchase patterns from relationships that also produce measurable promotional value.

### Customer Segmentation

Household purchases were aggregated into broader category groups and standardised before applying K-Means clustering. The resulting segments were interpreted using category purchase profiles and cluster size distribution.

### Recommendation Prototype

A simple basket-based recommendation engine was built using association-rule scores. Candidate products were ranked by combining lift and confidence, allowing the model to recommend relevant cross-sell items based on products already present in a basket.

## Key Findings

### Hair Care Shows Strong Cross-Sell Potential

Hair care products appeared frequently among the strongest high-lift product pairs. This suggests a routine replenishment pattern where customers often buy complementary SKUs in the same trip, such as shampoo, conditioner, and treatment products.

Commercial implication:

- Build shampoo and conditioner bundles
- Place complementary hair care products together
- Use basket-level prompts to complete the product routine

### Pet Food Has Strong Intra-Category Affinity

Pet food pairs, especially cat food and dog food variants, showed consistent co-purchase behaviour. This indicates repeat purchase and stock-up behaviour, where customers buy multiple formats or flavours in the same visit.

Commercial implication:

- Offer mix-and-match pet food promotions
- Create wet and dry food bundle offers
- Test subscription-style or repeat-purchase offers

### Baby Food Purchases Are Predictable and Routine-Based

Baby food products also showed repeated intra-category co-purchase patterns. These purchases are likely planned and routine-driven, making the category suitable for staged bundles and targeted replenishment promotions.

Commercial implication:

- Bundle baby food stages or multipacks
- Design shelf adjacencies around baby feeding routines
- Use targeted offers for repeat household needs

### Category Affinities Reveal Mission-Based Shopping

Category-level analysis showed that many high-lift relationships reflected shopping missions rather than random SKU-level combinations. Examples include:

- Frozen with Baking: home cooking and dessert preparation
- Beverage with Frozen: party, movie-night, or social-occasion baskets
- Frozen with Refrigerated: household meal stock-up
- Infant Formula with Baby Foods: family-care replenishment
- Beverage with Cereal Breakfast: morning routine baskets

Commercial implication:

- Build occasion-based bundles, such as breakfast, family cooking, or pantry stock-up
- Use store layout and digital journeys to group products around missions
- Recommend complementary categories rather than only similar products

### Not All Promotions Create Meaningful Halo Effects

The halo analysis found that some high-affinity pairs generated stronger incremental partner-product revenue than others. Hair care, pet food, and baby food were the clearest candidates because they combined strong natural affinity with practical promotional potential.

Commercial implication:

- Prioritise promotions where affinity strength and halo revenue align
- Avoid assuming every high-lift pair should receive promotional budget
- Use promotional testing to validate cross-sell opportunities before scaling

## Recommended Actions

### Bundle High-Affinity Routine Categories

Prioritise categories where customers already show repeat and complementary purchase behaviour:

- Shampoo and conditioner sets
- Cat wet food and dry food bundles
- Baby puree and snack multipacks

### Build Mission-Based Promotions

Use category affinities to create commercially intuitive promotions:

- Breakfast bundles: cereal, refrigerated drinks, and hot cereal
- Family cooking bundles: refrigerated items, baking products, and frozen foods
- Social-occasion bundles: beverages, frozen snacks, and desserts

### Improve Product Placement and Digital Recommendations

Translate affinity rules into practical customer touchpoints:

- Place complementary products near each other in-store
- Add basket-completion prompts in digital shopping journeys
- Use "customers also bought" recommendations for high-confidence product pairs

### Segment Promotion Strategy by Customer Behaviour

Customer segmentation can support different promotion strategies:

- High-value omni-category shoppers: premium cross-category bundles and loyalty rewards
- Mid-range general shoppers: mission-based bundles and convenience prompts
- Low-volume full-basket shoppers: small bundles and price-friendly cross-sell offers
- Price-sensitive minimal shoppers: essential value packs and targeted coupons

## Recommendation Engine

The recommendation prototype uses lift and confidence to rank product suggestions from basket contents. The goal is not to build a production recommender system, but to demonstrate how association rules can be translated into a simple decision-support tool for cross-sell recommendations.

## Limitations

- Association rules identify co-purchase relationships, but they do not prove causality.
- Promotion halo estimates are directional and should be validated with controlled experiments where possible.
- Results depend on transaction history and may change with seasonality, pricing, or product availability.
- The recommendation prototype is intentionally simple and would need further validation before production use.

## Business Value

This analysis turns transaction-level data into a practical retail cross-sell playbook. It identifies high-affinity product pairs, interprets broader shopping missions, prioritises promotional opportunities, and demonstrates how basket-level rules can support recommendation logic.
