import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSelectModule } from '@angular/material/select';
import { MatSnackBar } from '@angular/material/snack-bar';
import { TargetsService } from '../service/targets.service';
import { ProductsService } from '../../products/service/products.service';
import { SalesRepresentativeService } from '../../../core/services/sales-representative.service';
import { MatDatepicker } from '@angular/material/datepicker';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatNativeDateModule } from '@angular/material/core';

@Component({
  selector: 'app-target-edit',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatSelectModule,
    MatDatepicker,
    MatDatepickerModule,
    MatNativeDateModule
  ],
  templateUrl: './edit.component.html',
  styleUrls: ['./edit.component.scss']
})
export class EditComponent implements OnInit {
  form: FormGroup;
  salesReps: any[] = [];
  products: any[] = [];
  id!: number;

  constructor(
    private fb: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private targetService: TargetsService,
    private salesRepService: SalesRepresentativeService,
    private productService: ProductsService,
    private snackBar: MatSnackBar
  ) {
    this.form = this.fb.group({
      salesRepId: [null, Validators.required],
      productId: [null, Validators.required],
      targetAmount: [0, [Validators.required, Validators.min(0.01)]],
      targetDate: [null, Validators.required]
    });
  }

  ngOnInit(): void {
    this.id = +this.route.snapshot.paramMap.get('id')!;

    this.salesRepService.getAll().subscribe(data => this.salesReps = data);
    this.productService.getAll().subscribe(data => this.products = data);

    this.targetService.getById(this.id).subscribe({
      next: target => this.form.patchValue(target),
      error: () => this.snackBar.open('Failed to load target.', 'Close', { duration: 3000 })
    });
  }

  onSubmit(): void {
    if (this.form.invalid) return;

    this.targetService.update(this.id, this.form.value).subscribe({
      next: () => {
        this.snackBar.open('Target updated successfully!', 'Close', { duration: 3000 });
        this.router.navigate(['/targets']);
      },
      error: () => {
        this.snackBar.open('Update failed.', 'Close', { duration: 3000 });
      }
    });
  }
}
