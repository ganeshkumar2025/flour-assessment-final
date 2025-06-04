import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { FormBuilder, Validators, ReactiveFormsModule, FormGroup } from '@angular/forms';
import { ProductsService } from '../service/products.service';
import { MatSnackBar } from '@angular/material/snack-bar';
import { CommonModule } from '@angular/common';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-product-edit',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule
  ],
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss']
})
export class EditComponent implements OnInit {
  form: FormGroup;
  id!: number;

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private productsService: ProductsService,
    private snackBar: MatSnackBar
  ) {
    this.form = this.fb.group({
      name: ['', Validators.required],
      category: ['', Validators.required],
      price: [0, [Validators.required, Validators.min(0.01)]],
      stock: [0, [Validators.required, Validators.min(0)]]
    });
  }

  ngOnInit(): void {
    this.id = +this.route.snapshot.paramMap.get('id')!;
    this.productsService.getById(this.id).subscribe({
      next: product => this.form.patchValue(product),
      error: () => this.snackBar.open('Failed to load product', 'Close', { duration: 3000 })
    });
  }

  

  onSubmit() {
  if (this.form.invalid) return;

  const payload = {
    id: this.id, // ✅ ensure 'id' is present in the payload
    ...this.form.value
  };

  console.log('Updating product ID:', this.id);
  console.log('Payload:', payload);

  this.productsService.update(this.id, payload).subscribe({
    next: () => {
      this.snackBar.open('Product updated!', 'Close', { duration: 3000 });
      this.router.navigate(['/products']);
    },
    error: () => {
      this.snackBar.open('Update failed.', 'Close', { duration: 3000 });
    }
  });
}
}
