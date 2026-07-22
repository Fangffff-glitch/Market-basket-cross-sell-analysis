# Market Basket and Cross-Sell Analysis

This project analyses grocery transaction data to identify product affinity patterns, promotional halo effects, customer purchase segments, and simple cross-sell recommendation opportunities.

The analysis was originally developed from an academic Python analytics project and has been cleaned for portfolio use. Assessment briefs, candidate details, and course-specific submission information are not included.

## Business Question

Which products and categories are frequently purchased together, and how can those affinity patterns support product placement, bundling, promotion, and recommendation decisions?

## Analysis Overview

- Built basket-level product combinations from transaction data.
- Calculated product-pair affinity metrics: support, confidence, and lift.
- Identified high-lift product and category pairs with cross-selling potential.
- Analysed category-level affinity patterns and anchor categories.
- Estimated promotional halo effects when high-affinity products are promoted.
- Segmented households using K-Means based on category purchase behaviour.
- Built a simple recommendation prototype using lift and confidence scores.

## Tools

- Python
- pandas
- NumPy
- seaborn
- matplotlib
- scikit-learn
- Jupyter Notebook

## Repository Structure

```text
.
├── README.md
├── requirements.txt
├── market_basket_cross_sell_analysis.ipynb
├── clean_notebook.py
└── data/
    └── README.md
```

## Data Note

The original dataset was provided for academic use and is not included in this repository. To run the notebook, place compatible transaction, product, and promotion data under:

```text
data/csv/
```

Expected files:

- `transaction_data.csv`
- `product.csv`
- `causal_data.csv`

The notebook can also be adapted to a public grocery transaction dataset with similar fields.

## Portfolio Notes

This project demonstrates:

- Data cleaning and integration
- Exploratory data analysis
- Market basket analysis
- Affinity metrics and recommendation logic
- Customer segmentation
- Business interpretation of analytical results

