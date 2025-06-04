import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Target, TargetDto } from '../model/target.model';


@Injectable({ providedIn: 'root' })
export class TargetsService {
  private baseUrl = 'https://localhost:7232/api/targets';

  constructor(private http: HttpClient) {}

  getAll(): Observable<TargetDto[]> {
    return this.http.get<TargetDto[]>(this.baseUrl);
  }

  getById(id: number): Observable<Target> {
    return this.http.get<Target>(`${this.baseUrl}/${id}`);
  }

  create(data: Target): Observable<Target> {
    return this.http.post<Target>(this.baseUrl, data);
  }

  update(id: number, data: Target): Observable<Target> {
    return this.http.put<Target>(`${this.baseUrl}/${id}`, data);
  }

  delete(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`);
  }
}
