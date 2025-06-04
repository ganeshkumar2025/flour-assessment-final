import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatSnackBar } from '@angular/material/snack-bar';
import { MatFormFieldControl, MatFormFieldModule } from '@angular/material/form-field';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatSortModule } from '@angular/material/sort';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ConfirmDialogComponent } from '../../../core/shared/confirm-dialog/confirm-dialog.component';
import { MatDialogModule, MatDialog } from '@angular/material/dialog';
import { MatInputModule } from '@angular/material/input'; 
import { TargetsService } from '../service/targets.service';
import { TargetDto } from '../model/target.model';


@Component({
  selector: 'app-target-list',
  standalone: true,
  templateUrl: './list.component.html',
  styleUrls: ['./list.component.scss'],
  imports: [
    CommonModule,
    RouterModule,
    MatTableModule,
    MatPaginatorModule,
    MatSortModule,
    MatSnackBarModule,
    MatIconModule,
    MatButtonModule,
    MatDialogModule,
    ConfirmDialogComponent,
    MatFormFieldModule,
    MatInputModule
  ]
})
export class TargetListComponent implements OnInit {
  displayedColumns: string[] = ['id', 'salesRepName', 'productName', 'targetAmount', 'targetMonth', 'actions'];
  dataSource = new MatTableDataSource<TargetDto>([]);

  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;

  constructor(
    private targetsService: TargetsService,
    private snackBar: MatSnackBar,
    private dialog: MatDialog
  ) {}

  ngOnInit(): void {
    this.loadTargets();
  }

  loadTargets(): void {
    this.targetsService.getAll().subscribe({
      next: (data) => {
        this.dataSource.data = data;
        this.dataSource.paginator = this.paginator;
        this.dataSource.sort = this.sort;
      },
      error: () => {
        this.snackBar.open('Failed to load targets.', 'Close', { duration: 3000 });
      }
    });
  }

  applyFilter(event: Event) {
    const filterValue = (event.target as HTMLInputElement).value.trim().toLowerCase();
    this.dataSource.filter = filterValue;
    if (this.dataSource.paginator) {
      this.dataSource.paginator.firstPage();
    }
  }

  deleteTarget(id: number): void {
    const dialogRef = this.dialog.open(ConfirmDialogComponent, {
      data: { title: 'Delete Confirmation', message: 'Are you sure you want to delete this target?' }
    });

    dialogRef.afterClosed().subscribe(result => {
      if (result === true) {
        this.targetsService.delete(id).subscribe({
          next: () => {
            this.snackBar.open('Target deleted successfully.', 'Close', { duration: 3000 });
            this.loadTargets();
          },
          error: () => {
            this.snackBar.open('Failed to delete target.', 'Close', { duration: 3000 });
          }
        });
      }
    });
  }
}
