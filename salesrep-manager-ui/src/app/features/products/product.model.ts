export interface Product {
  id?: number;           // optional for create, required for update
  name: string;
  category: string;
  price: number;
  stock: number;
}