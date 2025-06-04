import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatSelectModule } from '@angular/material/select';
import { MatNativeDateModule } from '@angular/material/core';
import { MatButtonModule } from '@angular/material/button';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatInputModule } from '@angular/material/input';
import { MatSnackBar } from '@angular/material/snack-bar';
import { SalesRepresentativeService } from '../../../core/services/sales-representative.service';
import { SalesRepresentative } from '../../sales-representative/sales-representative.model';
import { TargetsService } from '../service/targets.service';

@Component({
  selector: 'app-targets-create',
  standalone: true,
  templateUrl: './create.component.html',
  imports: [
    ReactiveFormsModule, CommonModule, MatFormFieldModule, MatSelectModule,
    MatInputModule, MatButtonModule, MatDatepickerModule, MatNativeDateModule
  ]
})
export class TargetsCreateComponent implements OnInit {
  form: FormGroup;
  salesReps: SalesRepresentative[] = [];

  constructor(
    private fb: FormBuilder,
    private targetService: TargetsService,
    private salesRepService: SalesRepresentativeService,
    private router: Router,
    private snackBar: MatSnackBar
  ) {
    this.form = this.fb.group({
      salesRepId: [null, Validators.required],
      targetAmount: [0, [Validators.required, Validators.min(1)]],
      startDate: ['', Validators.required],
      endDate: ['', Validators.required]
    });
  }

  ngOnInit(): void {
    this.salesRepService.getAll().subscribe(data => this.salesReps = data);
  }

  onSubmit() {
    if (this.form.invalid) return;
    this.targetService.create(this.form.value).subscribe(() => {
      this.snackBar.open('Target created successfully.', 'Close', { duration: 3000 });
      this.router.navigate(['/targets']);
    });
  }
}
