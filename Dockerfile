# GIAI ĐOẠN 1: BUILD ỨNG DỤNG (Tạo file tĩnh)
# Sử dụng image Node.js đầy đủ để build
FROM node:18-alpine AS build

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy các file config
COPY package*.json ./

# Cài đặt dependencies và build ứng dụng sang chế độ Production
# Lưu ý: Lệnh này tạo ra thư mục "build" chứa các file tĩnh
RUN npm install
COPY . .
RUN npm run build

# GIAI ĐOẠN 2: CHẠY ỨNG DỤNG (Sử dụng Web Server nhẹ)
# Sử dụng Nginx image siêu nhẹ
FROM nginx:alpine

# Xóa file cấu hình mặc định của Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copy file cấu hình tùy chỉnh cho ứng dụng React (nếu cần)
# Nếu không có file tùy chỉnh, Nginx sẽ dùng cấu hình mặc định để serve các file tĩnh

# Copy các file Production đã build từ giai đoạn 1 vào thư mục gốc của Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Mở cổng 80 (cổng HTTP tiêu chuẩn)
EXPOSE 80

# Lệnh khởi động Nginx
CMD ["nginx", "-g", "daemon off;"]
