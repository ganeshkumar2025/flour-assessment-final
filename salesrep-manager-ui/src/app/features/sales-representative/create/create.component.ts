import { Component } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { SalesRepresentativeService } from '../../../core/services/sales-representative.service';
import { Router, RouterModule } from '@angular/router';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { ConfirmDialogComponent } from '../../../core/shared/confirm-dialog/confirm-dialog.component';
import { MatDialog } from '@angular/material/dialog';
import { CommonModule } from '@angular/common';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatIconModule } from '@angular/material/icon';
import { MatSelectModule } from '@angular/material/select';
import { MatOptionModule } from '@angular/material/core';
import { MatDatepickerModule } from '@angular/material/datepicker';
import { MatButtonModule } from '@angular/material/button';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';


@Component({
  selector: 'app-create', 
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.scss'],
  standalone:true,
  imports: [
    CommonModule,
    MatTableModule,
    MatPaginatorModule,
    MatSnackBarModule,
    MatIconModule, 
    MatSelectModule,
    MatOptionModule,
    MatDatepickerModule,
    MatButtonModule,
    MatInputModule,
    FormsModule,
    RouterModule,
    MatFormFieldModule,
    ReactiveFormsModule
  ]
})

export class CreateComponent {
  form: FormGroup;

  constructor(
    private fb: FormBuilder,
    private service: SalesRepresentativeService,
    private router: Router,
    private snackBar: MatSnackBar,
    private dialog: MatDialog
  ) {
    this.form = this.fb.group({
      firstName: ['', Validators.required],
      lastName: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      phoneNumber: ['', Validators.required],
      region: ['', Validators.required],
      hireDate: ['', Validators.required],
      status: ['Active', Validators.required]
    });
  }

  onSubmit(): void {
    if (this.form.invalid) return;

    this.service.create(this.form.value).subscribe(() => {
      this.snackBar.open('Sales rep created.', 'Close', { duration: 3000 });
      this.router.navigate(['/sales-representative']);
    });
  }
  onCancel(): void {
    if (this.form.dirty || this.form.touched) {
      const dialogRef = this.dialog.open(ConfirmDialogComponent, {
        data: {
          title: 'Discard Changes?',
          message: 'You have unsaved changes. Do you want to cancel?'
        }
      });

      dialogRef.afterClosed().subscribe(result => {
        if (result) {
          this.router.navigate(['/sales-representative']);
        }
      });
    } else {
      this.router.navigate(['/sales-representative']);
    }
  }
}