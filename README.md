# Market Basket and Cross-Sell Analysis

This project analyses grocery transaction data to identify product affinity patterns, promotional halo effects, customer purchase segments, and simple cross-sell recommendation opportunities.

The analysis was originally developed from an academic Python analytics project using the dunnhumby Complete Journey grocery retail dataset. It has been cleaned for portfolio use; assessment briefs, candidate details, raw data files, and course-specific submission information are not included.

## Business Question

Which products and categories are frequently purchased together, and how can those affinity patterns support product placement, bundling, promotion, and recommendation decisions?

## Analysis Overview

- Prepared transaction, product, and promotion data for basket-level analysis.
- Built basket-level product combinations using transaction IDs.
- Calculated product-pair affinity metrics: support, confidence, and lift.
- Identified high-lift product and category pairs with cross-selling potential.
- Analysed category-level affinity patterns and potential anchor categories.
- Estimated promotional halo effects by comparing partner-product sales when anchor products were promoted.
- Segmented households using K-Means based on category purchase behaviour.
- Built a simple recommendation prototype using lift and confidence scores.

For a portfolio-style write-up of the analysis, findings, and business recommendations, see [`docs/analysis_summary.md`](docs/analysis_summary.md).

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
├── docs/
│   └── analysis_summary.md
└── data/
    └── README.md
```

## Data Note

Raw data is not included in this repository because the files are large and were provided for academic use. To run the notebook locally, place the dunnhumby Complete Journey CSV files under:

```text
data/csv/
```

Core files used by the notebook:

- `transaction_data.csv`
- `product.csv`
- `causal_data.csv`

Optional files that can support further campaign, coupon, or household analysis:

- `hh_demographic.csv`
- `campaign_desc.csv`
- `campaign_table.csv`
- `coupon.csv`
- `coupon_redempt.csv`

The notebook can also be adapted to another grocery transaction dataset with similar basket, product, and promotion fields.

## How to Run

1. Create a local `data/csv/` folder.
2. Add the required CSV files listed above.
3. Install the Python packages in `requirements.txt`.
4. Open and run `market_basket_cross_sell_analysis.ipynb`.

The analysis is designed for local execution because the raw transaction and promotion files are not committed to GitHub.

## Portfolio Notes

This project demonstrates:

- Data cleaning and integration
- Exploratory data analysis
- Market basket analysis
- Affinity metrics and recommendation logic
- Promotion impact analysis
- Customer segmentation
- Business interpretation of analytical results
