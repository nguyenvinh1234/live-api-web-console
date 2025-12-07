# Sử dụng Node.js image nhẹ làm base image
FROM node:18-alpine

# Thiết lập thư mục làm việc bên trong container
WORKDIR /app

# Copy file package để cài đặt thư viện trước (tận dụng cache)
COPY package*.json ./

# Cài đặt dependencies (các thư viện cần thiết)
RUN npm install

# Copy toàn bộ mã nguồn còn lại vào
COPY . .

# Thiết lập biến môi trường để React chạy đúng trong Docker
ENV HOST=0.0.0.0
ENV PORT=3000

# Mở cổng 3000 cho truy cập bên ngoài
EXPOSE 3000

# Lệnh khởi động ứng dụng
CMD ["npm", "start"]
