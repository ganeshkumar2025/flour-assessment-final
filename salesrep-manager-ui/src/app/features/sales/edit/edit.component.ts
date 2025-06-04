import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSelectModule } from '@angular/material/select';
import { MatSnackBar } from '@angular/material/snack-bar';
import { SalesService } from '../service/sales.service';
import { ProductsService } from '../../products/service/products.service';
import { SalesRepresentativeService } from '../../../core/services/sales-representative.service';


@Component({
  selector: 'app-sales-edit',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatSelectModule
  ],
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss']
})
export class EditComponent implements OnInit {
  form!: ReturnType<FormBuilder['group']>;
  salesReps: any[] = [];
  products: any[] = [];
  id!: number;

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private salesService: SalesService,
    private salesRepService: SalesRepresentativeService,
    private productService: ProductsService,
    private snackBar: MatSnackBar
  ) {}

  ngOnInit(): void {
    this.id = +this.route.snapshot.paramMap.get('id')!;

    
    this.form = this.fb.group({
      salesRepId: [null, Validators.required],
      productId: [null, Validators.required],
      quantity: [1, [Validators.required, Validators.min(1)]],
      saleDate: [null, Validators.required],
      amount: [0, [Validators.required, Validators.min(0.01)]]
    });

    this.salesRepService.getAll().subscribe(data => this.salesReps = data);
    this.productService.getAll().subscribe(data => this.products = data);

    this.salesService.getById(this.id).subscribe({
      next: sale => this.form.patchValue(sale),
      error: () => this.snackBar.open('Failed to load sale.', 'Close', { duration: 3000 })
    });
  }

  onSubmit(): void {
    if (this.form.invalid) return;

    this.salesService.update(this.id, this.form.value).subscribe({
      next: () => {
        this.snackBar.open('Sale updated successfully!', 'Close', { duration: 3000 });
        this.router.navigate(['/sales']);
      },
      error: () => {
        this.snackBar.open('Update failed.', 'Close', { duration: 3000 });
      }
    });
  }
}
