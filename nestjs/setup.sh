#!/usr/bin/env bash
# shellcheck disable=SC2046

git init
skf gitignore/nestjs >.gitignore

npm init -y
npm pkg set private=true --json
npm pkg set scripts.build="nest build"
npm pkg set scripts.start="nest start"
npm pkg set scripts.start:dev="nest start --watch"
npm pkg set scripts.start:debug="nest start --debug --watch"
npm pkg set scripts.start:prod="node dist/main"
npm pkg set scripts.test="jest"
npm pkg set scripts.test:watch="jest --watch"
npm pkg set scripts.test:cov="jest --coverage"
npm pkg set scripts.test:debug="node --inspect-brk -r tsconfig-paths/register -r ts-node/register node_modules/.bin/jest --runInBand"
npm pkg set scripts.test:e2e="jest --config ./test/jest-e2e.json"
npm pkg set scripts.format="eslint --fix . && prettier --write ."
npm pkg set scripts.lint="eslint ."

npm install --save \
    @nestjs/common \
    @nestjs/core \
    @nestjs/platform-fastify \
    reflect-metadata \
    rxjs
npm install --save-dev \
    @eslint/js \
    @nestjs/cli \
    @nestjs/schematics \
    @nestjs/testing \
    @swc/cli \
    @swc/core \
    @swc/jest \
    @types/jest \
    @types/node \
    @types/supertest \
    eslint \
    globals \
    jest \
    prettier \
    source-map-support \
    supertest \
    ts-node \
    tsconfig-paths \
    typescript \
    typescript-eslint

npm pkg set jest.moduleFileExtensions='["js","json","ts"]' --json
npm pkg set jest.rootDir="src"
npm pkg set jest.testRegex='.*\.spec\.ts$'
npm pkg set jest.transform\['^.+\.(t|j)s$'\]='["@swc/jest"]' --json
npm pkg set jest.collectCoverageFrom='["**/*.(t|j)s"]' --json
npm pkg set jest.coverageDirectory="../coverage"
npm pkg set jest.testEnvironment="node"

shskf editorconfig/nodejs.sh
skf prettier/prettier.config.mjs >prettier.config.mjs
skf eslint/nestjs.mjs >eslint.config.mjs

shskf direnv/nodejs.sh
direnv allow

cat >nest-cli.json <<'EOF'
{
  "$schema": "https://json.schemastore.org/nest-cli",
  "collection": "@nestjs/schematics",
  "sourceRoot": "src",
  "compilerOptions": {
    "builder": "swc",
    "deleteOutDir": true
  }
}
EOF

cat >.swcrc <<'EOF'
{
  "$schema": "https://swc.rs/schema.json",
  "sourceMaps": true,
  "jsc": {
    "parser": {
      "syntax": "typescript",
      "decorators": true,
      "dynamicImport": true
    },
    "transform": {
      "legacyDecorator": true,
      "decoratorMetadata": true
    },
    "baseUrl": "./"
  },
  "minify": false
}
EOF

cat >tsconfig.json <<'EOF'
{
  "compilerOptions": {
    "noEmit": true,
    "module": "nodenext",
    "moduleResolution": "nodenext",
    "resolvePackageJsonExports": true,
    "esModuleInterop": true,
    "isolatedModules": true,
    "declaration": true,
    "removeComments": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "allowSyntheticDefaultImports": true,
    "target": "ES2023",
    "sourceMap": true,
    "outDir": "./dist",
    "baseUrl": "./",
    "incremental": true,
    "skipLibCheck": true,
    "strictNullChecks": true,
    "forceConsistentCasingInFileNames": true,
    "noImplicitAny": true,
    "strictBindCallApply": true,
    "noFallthroughCasesInSwitch": true
  }
}
EOF

cat >tsconfig.build.json <<'EOF'
{
  "extends": "./tsconfig.json",
  "exclude": ["node_modules", "test", "dist", "**/*spec.ts"]
}
EOF

mkdir -p src test
cat >src/main.ts <<'EOF'
import { NestFactory } from "@nestjs/core";
import {
  FastifyAdapter,
  NestFastifyApplication,
} from "@nestjs/platform-fastify";
import { AppModule } from "./app.module";

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter({ logger: true }),
  );
  await app.listen(process.env.PORT ?? 3000, "0.0.0.0");
}

bootstrap().catch((err: unknown) => {
  console.error("Error starting server:", err);
});
EOF

cat >src/app.module.ts <<'EOF'
import { Module } from "@nestjs/common";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";

@Module({
  imports: [],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
EOF

cat >src/app.controller.ts <<'EOF'
import { Controller, Get } from "@nestjs/common";
import { AppService } from "./app.service";

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
}
EOF

cat >src/app.controller.spec.ts <<'EOF'
import { Test, TestingModule } from "@nestjs/testing";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";

describe("AppController", () => {
  let appController: AppController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [AppController],
      providers: [AppService],
    }).compile();

    appController = app.get<AppController>(AppController);
  });

  describe("root", () => {
    it('should return "Hello World!"', () => {
      expect(appController.getHello()).toBe("Hello World!");
    });
  });
});
EOF

cat >src/app.service.ts <<'EOF'
import { Injectable } from "@nestjs/common";

@Injectable()
export class AppService {
  getHello(): string {
    return "Hello World!";
  }
}
EOF

cat >test/app.e2e-spec.ts <<'EOF'
import { Test, TestingModule } from "@nestjs/testing";
import { INestApplication } from "@nestjs/common";
import request from "supertest";
import { App } from "supertest/types";
import { AppModule } from "./../src/app.module";

describe("AppController (e2e)", () => {
  let app: INestApplication<App>;

  beforeEach(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();
  });

  it("/ (GET)", () => {
    return request(app.getHttpServer())
      .get("/")
      .expect(200)
      .expect("Hello World!");
  });
});
EOF

cat >test/jest-e2e.json <<'EOF'
{
  "moduleFileExtensions": ["js", "json", "ts"],
  "rootDir": ".",
  "testEnvironment": "node",
  "testRegex": ".e2e-spec.ts$",
  "transform": {
    "^.+\\.(t|j)s$": "@swc/jest"
  }
}
EOF

npm run format
