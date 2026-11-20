export function validateFoodListing({ foodItem, category, quantityKg, expiresAt }) {
  const errors = {};

  if (!foodItem || foodItem.trim().length < 3) {
    errors.foodItem = "Food item name must be at least 3 characters.";
  }

  if (!category || !category.trim()) {
    errors.category = "Please select a food category.";
  }

  const qty = Number(quantityKg);
  if (!Number.isFinite(qty) || qty <= 0) {
    errors.quantityKg = "Quantity (kg) must be greater than 0.";
  }

  const expiryDate = new Date(expiresAt);
  if (!expiresAt || Number.isNaN(expiryDate.getTime()) || expiryDate <= new Date()) {
    errors.expiresAt = "Expiry time must be in the future.";
  }

  return {
    isValid: Object.keys(errors).length === 0,
    errors,
  };
}

export function getShelfLifeBadge(expiresAt, now = new Date()) {
  const diffMs = new Date(expiresAt).getTime() - now.getTime();
  if (Number.isNaN(diffMs) || diffMs <= 0) {
    return { label: "Expired", tone: "expired", hoursLeft: 0 };
  }

  const hoursLeft = Math.round((diffMs / (1000 * 60 * 60)) * 10) / 10;
  if (hoursLeft <= 2) {
    return { label: `Urgent (${hoursLeft}h left)`, tone: "urgent", hoursLeft };
  }

  return { label: `Fresh (${hoursLeft}h left)`, tone: "fresh", hoursLeft };
}
