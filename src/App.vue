<script setup>
import { ref, onMounted } from 'vue'
import { API_URL } from './config'

const staffList = ref([])
const notice = ref('')
const err = ref('')
const form = ref({ staff_code: '', staff_name: '', job_title: '', department: '', phone: '', salary: '' })

const loadStaff = async () => {
  try {
    const r = await fetch(`${API_URL}/get_staff.php`)
    const j = await r.json()
    if (j.success) staffList.value = j.data
  } catch { err.value = 'เชื่อมต่อ PHP API ไม่สำเร็จ' }
}

const saveStaff = async () => {
  notice.value = ''; err.value = ''
  try {
    const r = await fetch(`${API_URL}/create_staff.php`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(form.value)
    })
    const j = await r.json()
    if (j.success) {
      notice.value = j.message
      form.value = { staff_code: '', staff_name: '', job_title: '', department: '', phone: '', salary: '' }
      await loadStaff()
    } else err.value = j.message
  } catch { err.value = 'บันทึกไม่สำเร็จ' }
}

onMounted(loadStaff)
</script>

<template>
  <nav class="navbar navbar-dark bg-secondary">
    <div class="container">
      <span class="navbar-brand fw-semibold">ระบบบันทึกและแสดงข้อมูลพนักงาน (Vue + PHP)</span>
    </div>
  </nav>
  <div class="container my-4">
    <div v-if="notice" class="alert alert-success py-2">{{ notice }}</div>
    <div v-if="err" class="alert alert-danger py-2">{{ err }}</div>
    <div class="row g-4">
      <div class="col-lg-4">
        <div class="card">
          <div class="card-header fw-semibold">เพิ่มข้อมูลพนักงานใหม่</div>
          <div class="card-body">
            <form @submit.prevent="saveStaff">
              <div class="mb-2"><label class="form-label small">รหัสพนักงาน</label><input v-model="form.staff_code" class="form-control form-control-sm" required /></div>
              <div class="mb-2"><label class="form-label small">ชื่อ-นามสกุล</label><input v-model="form.staff_name" class="form-control form-control-sm" required /></div>
              <div class="mb-2"><label class="form-label small">ตำแหน่ง</label><input v-model="form.job_title" class="form-control form-control-sm" required /></div>
              <div class="mb-2"><label class="form-label small">แผนก</label><input v-model="form.department" class="form-control form-control-sm" required /></div>
              <div class="mb-2"><label class="form-label small">เบอร์โทร</label><input v-model="form.phone" class="form-control form-control-sm" /></div>
              <div class="mb-3"><label class="form-label small">เงินเดือน (บาท)</label><input v-model="form.salary" type="number" class="form-control form-control-sm" /></div>
              <button class="btn btn-primary btn-sm w-100">บันทึกข้อมูล</button>
            </form>
          </div>
        </div>
      </div>
      <div class="col-lg-8">
        <div class="card">
          <div class="card-header fw-semibold">รายชื่อพนักงานในระบบ ({{ staffList.length }} คน)</div>
          <div class="table-responsive">
            <table class="table table-striped table-bordered mb-0 align-middle small">
              <thead class="table-light">
                <tr><th>รหัส</th><th>ชื่อ-นามสกุล</th><th>ตำแหน่ง</th><th>แผนก</th><th>เบอร์โทร</th><th class="text-end">เงินเดือน</th></tr>
              </thead>
              <tbody>
                <tr v-for="s in staffList" :key="s.staff_id">
                  <td>{{ s.staff_code }}</td><td>{{ s.staff_name }}</td><td>{{ s.job_title }}</td>
                  <td>{{ s.department }}</td><td>{{ s.phone }}</td><td class="text-end">{{ Number(s.salary).toLocaleString() }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
