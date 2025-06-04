// Used for Create/Edit operations
export interface Target {
  id?: number;
  salesRepId: number;
  productId: number;
  targetMonth: string; 
  targetAmount: number;
}

// Used for displaying in the list view
export interface TargetDto {
  id: number;
  salesRepName: string;
  productName: string;
  targetMonth: string;
  targetAmount: number;
}