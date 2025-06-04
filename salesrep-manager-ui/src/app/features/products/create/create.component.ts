import { Component } from '@angular/core';
import { FormBuilder, Validators, ReactiveFormsModule, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { ProductsService } from '../service/products.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { CommonModule } from '@angular/common';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-product-create',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule
  ],
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.scss']
})
export class CreateComponent {
  form: FormGroup;
  constructor(
    private fb: FormBuilder,
    private productsService: ProductsService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {
    this.form = this.fb.group({
      name: ['', Validators.required],
      category: ['', Validators.required],
      price: [0, [Validators.required, Validators.min(0.01)]],
      stock: [0, [Validators.required, Validators.min(0)]]
    });
  }

  onSubmit() {
    if (this.form.invalid) return;

    this.productsService.create(this.form.value).subscribe({
      next: () => {
        this.snackBar.open('Product created successfully!', 'Close', { duration: 3000 });
        this.router.navigate(['/products']);
      },
      error: () => {
        this.snackBar.open('Failed to create product.', 'Close', { duration: 3000 });
      }
    });
  }
}