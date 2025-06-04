import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { Product } from '../../products/product.model';
import { SalesRepresentative } from '../../sales-representative/sales-representative.model';
import { ProductsService } from '../../products/service/products.service';
import { SalesService } from '../service/sales.service';
import { SalesRepresentativeService } from '../../../core/services/sales-representative.service';
import { MatSnackBar } from '@angular/material/snack-bar';

@Component({
  selector: 'app-sales-create',
  standalone: true,
  templateUrl: './create.component.html',
  imports: [
    ReactiveFormsModule, CommonModule, MatFormFieldModule, MatSelectModule,
    MatInputModule, MatButtonModule
  ]
})
export class SalesCreateComponent implements OnInit {
  form: FormGroup;
  products: Product[] = [];
  salesReps: SalesRepresentative[] = [];

  constructor(
    private fb: FormBuilder,
    private salesService: SalesService,
    private productService: ProductsService,
    private salesRepService: SalesRepresentativeService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {
    this.form = this.fb.group({
      productId: [null, Validators.required],
      salesRepId: [null, Validators.required],
      quantity: [0, [Validators.required, Validators.min(1)]],
      saleDate: ['', Validators.required]
    });
  }

  ngOnInit(): void {
    this.productService.getAll().subscribe(data => this.products = data);
    this.salesRepService.getAll().subscribe(data => this.salesReps = data);
  }

  onSubmit() {
    if (this.form.invalid) return;
    this.salesService.create(this.form.value).subscribe(() => {
      this.snackBar.open('Sale recorded successfully.', 'Close', { duration: 3000 });
      this.router.navigate(['/sales']);
    });
  }
}